-- Brain Pulse account deletion requests.
create table if not exists public.deletion_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  user_email text not null,
  requested_at timestamptz not null default now(),
  reason text not null default 'User requested account deletion through the official Brain Pulse account deletion page.',
  status text not null default 'PENDING' check (status in ('PENDING','PROCESSING','COMPLETED','REJECTED')),
  processed_at timestamptz,
  admin_id uuid references auth.users(id)
);
create index if not exists idx_deletion_requests_user_id on public.deletion_requests(user_id);
create index if not exists idx_deletion_requests_status on public.deletion_requests(status);
create index if not exists idx_deletion_requests_requested_at on public.deletion_requests(requested_at desc);
alter table public.deletion_requests enable row level security;
drop policy if exists "Users can submit deletion request" on public.deletion_requests;
create policy "Users can submit deletion request" on public.deletion_requests for insert to authenticated with check (auth.uid() = user_id and user_email = coalesce(auth.jwt()->>'email',''));
drop policy if exists "Users can view own deletion request" on public.deletion_requests;
create policy "Users can view own deletion request" on public.deletion_requests for select to authenticated using (auth.uid() = user_id);

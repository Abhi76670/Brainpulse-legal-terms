# Brain Pulse Legal & Account Deletion

Static pages for Brain Pulse:
- index.html — legal home
- privacy.html — Privacy Policy
- terms.html — Terms & Conditions
- delete-account.html — Google-auth account deletion request

Account deletion verification:
1. User enters only the Google account email used for Brain Pulse.
2. Send OTP calls Supabase Auth `resetPasswordForEmail` (password-recovery email).
3. The user enters the 6-digit recovery OTP.
4. `verifyOtp({ type: 'recovery' })` creates a verified Supabase session.
5. The page inserts a PENDING row into `public.deletion_requests` using the authenticated user ID.
6. The page displays: “Request submitted — We will review your request in 1 to 3 working days.”

Important Supabase Auth email-template requirement:
The Brain Pulse Supabase recovery/password-reset email template must display the 6-digit `{{ .Token }}` value. The app already uses the same recovery OTP flow.

Run the included migration in the Brain Pulse Supabase project before using the deletion form:
`supabase db push`

Only the public Supabase URL and anon key are included in `config.js`. Never put a service-role key, JWT secret, or personal access token in this website.

Support: support@vexoralisoftware.in


OTP resend behavior: after a successful send, the Resend OTP button remains disabled for 30 seconds and shows a countdown. A new 30-second cooldown starts after each successful resend. Failed sends do not start a new cooldown.

Policy text was tailored to the app code's visible features: Google sign-in, rewards/coins/gems, rewarded ads/LevelPlay, quizzes/daily activities, referrals, Super Offers with install/Usage Access verification, screenshots for offer review, push tokens, redemptions and support. Please ensure the final published policy also matches every SDK/provider and data flow enabled in the production build and Play Console Data safety form.

🛠️ Bug Fixes Documentation – ExpertTest Lead Capture App

Version: vite_react_shadcn_ts_20250728_minor

1. Critical Bugs
1.1 Duplicate Email Invocation

File: src/components/LeadCaptureForm.tsx

Severity: Critical

Status: Identified → Resolved (Lovable edits)

Problem
Two identical supabase.functions.invoke('send-confirmation', ...) blocks existed, risking duplicate confirmation emails.

Root Cause
Copy-pasted try/catch blocks with the same payload and handling.

Impact

Users could receive two emails per submit

Higher function costs / rate-limit risks

Resolution
Lovable removed one duplicate block during their fixes pass.

1.2 Inconsistent State Management (Local vs Zustand)

Files:

src/components/LeadCaptureForm.tsx

src/components/LeadCapturePage.tsx

src/lib/lead-store.ts

Severity: High

Status: Identified → Refactored (Lovable edits)

Problem
The form used local state for submitted and leads, while the page expected Zustand (useLeadStore).

Root Cause
Mixed state sources, no single source of truth.

Impact

Success message not appearing reliably

Data lost on refresh (session only)

Harder testing and maintenance

Resolution
Lovable refactored to use the global Zustand store.

1.3 No Database Persistence in Original Code

Files:

src/components/LeadCaptureForm.tsx

src/lib/lead-store.ts

Severity: High

Status: Identified → Implemented (Lovable edits, post-approval)

Problem
Original form only updated local session state, not Supabase.

Impact

Leads lost on refresh

No server-side data for analytics/admin

Resolution

Table created: public.leads (UUID id, name, email, industry, submitted_at, timestamps)

RLS policies: insert open to anon/authenticated; select restricted

Form updated to insert into public.leads

✅ Connected & Writing

⏳ Types: Supabase types need regeneration for TS safety

2. High & Medium Issues
2.1 Redundant Success UI & Coupling

Files:

src/components/LeadCaptureForm.tsx

src/components/SuccessMessage.tsx

Severity: Medium

Status: Identified → Consolidated (Lovable edits)

Problem
Success logic/UI existed inline in the form and in a separate component.

Impact

Duplicate logic

Harder maintenance

Inconsistent transitions

Resolution
Consolidated into a single Success component.

2.2 Missing Custom CSS Animation Classes

File(s): src/index.css vs component usages

Severity: Medium

Status: Identified → Added (Lovable edits)

Problem
Referenced classes (animate-slide-up, animate-glow, etc.) were not defined.

Impact

Animations not running

Elements potentially invisible

Risk of “blank app” look

Resolution
Lovable added the missing CSS classes.

2.3 Possible Blank Screen – External Background & No Error Boundaries

File: src/components/LeadCapturePage.tsx

Severity: Medium

Status: Identified (No change originally requested)

Problem

Page used an external GIF for background; failure could hide content.

No error boundary present → runtime errors blank the UI.

Impact

Intermittent blank render

Hard to diagnose

Recommendation

Add local fallback for background

Add React ErrorBoundary for production

3. Non-Functional / UX Observations
3.1 Design Tokens & Hardcoded Colours

Files: LeadCaptureForm.tsx, index.css

Severity: Low

Status: Identified

Issues

Hardcoded gradients and shadows (e.g., hover:shadow-[0_0_60px_hsl(...)])

Not aligned with shadcn UI tokens

Recommendation
Map to Tailwind/shadcn design tokens for consistent theming.

3.2 Accessibility & Focus Management

Files: LeadCapturePage.tsx, form flow

Severity: Low

Status: Identified

Issues

Generic alt text (“Background animation”)

No focus shift to success container after submit

Impact

Limited screen reader support

Poor keyboard UX

Recommendation
Improve alt text and focus management.

4. Environment / Stack Notes

Tech stack: Vite + React + TypeScript + shadcn/ui + Zustand

External asset: Background GIF (risk of failure)

Supabase: Configured, later connected to DB

5. Reproduction & Verification

Duplicate email: Pre-fix → two invocations

State mismatch: Success UI not showing

Blank app risk: Broken GIF or missing CSS → blank layout

Supabase persistence: Before → no insert; After → verified row in public.leads

6. Final Status
✅ Fixed / Implemented

Removed duplicate email invocation

Normalised state flow (Zustand)

Consolidated success UI

Added missing CSS animations

Supabase table + RLS policies created and wired

🔧 Still Recommended

Add React ErrorBoundary

Provide local background fallback

Replace hardcoded colours with tokens

Regenerate Supabase TS types



# Welcome to your Lovable project

## Project info

**URL**: https://lovable.dev/projects/4d7a0a2c-31f4-4b22-a00f-e070ba81510e

## How can I edit this code?

There are several ways of editing your application.

**Use Lovable**

Simply visit the [Lovable Project](https://lovable.dev/projects/4d7a0a2c-31f4-4b22-a00f-e070ba81510e) and start prompting.

Changes made via Lovable will be committed automatically to this repo.

**Use your preferred IDE**

If you want to work locally using your own IDE, you can clone this repo and push changes. Pushed changes will also be reflected in Lovable.

The only requirement is having Node.js & npm installed - [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating)

Follow these steps:

```sh
# Step 1: Clone the repository using the project's Git URL.
git clone <YOUR_GIT_URL>

# Step 2: Navigate to the project directory.
cd <YOUR_PROJECT_NAME>

# Step 3: Install the necessary dependencies.
npm i

# Step 4: Start the development server with auto-reloading and an instant preview.
npm run dev
```

**Edit a file directly in GitHub**

- Navigate to the desired file(s).
- Click the "Edit" button (pencil icon) at the top right of the file view.
- Make your changes and commit the changes.

**Use GitHub Codespaces**

- Navigate to the main page of your repository.
- Click on the "Code" button (green button) near the top right.
- Select the "Codespaces" tab.
- Click on "New codespace" to launch a new Codespace environment.
- Edit files directly within the Codespace and commit and push your changes once you're done.

## What technologies are used for this project?

This project is built with:

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS

## How can I deploy this project?

Simply open [Lovable](https://lovable.dev/projects/4d7a0a2c-31f4-4b22-a00f-e070ba81510e) and click on Share -> Publish.

## Can I connect a custom domain to my Lovable project?

Yes, you can!

To connect a domain, navigate to Project > Settings > Domains and click Connect Domain.

Read more here: [Setting up a custom domain](https://docs.lovable.dev/tips-tricks/custom-domain#step-by-step-guide)

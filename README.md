🛠️ Bug Fixes Documentation – ExpertTest Lead Capture App

Version: vite_react_shadcn_ts_20250728_minor

Overview

This document outlines the major bugs that were discovered and resolved in the ExpertTest Lead Capture App (vite_react_shadcn_ts_20250728_minor).

Critical Fixes Implemented

1. Duplicate Email Invocation

File: src/components/LeadCaptureForm.tsx
Severity: Critical
Status: ✅ Fixed

Problem

Two identical supabase.functions.invoke('send-confirmation', ...) blocks were present, causing duplicate confirmation emails per form submission.

Root Cause

Copy-pasted try/catch blocks with the same payload and handling.

Fix

Removed the redundant block in LeadCaptureForm.tsx.

Impact

✅ Users receive only one confirmation email per submit

✅ Reduced function costs and avoided rate-limit risks

2. Inconsistent State Management (Local vs Zustand)

Files:

src/components/LeadCaptureForm.tsx

src/components/LeadCapturePage.tsx

src/lib/lead-store.ts
Severity: High
Status: ✅ Fixed

Problem

Form used local state for submitted and leads, while the page relied on Zustand (useLeadStore), leading to mismatched success state and data loss on refresh.

Root Cause

Mixed use of local and global state without a single source of truth.

Fix

Refactored code to consistently use Zustand as the global state store.

Impact

✅ Success message displays reliably

✅ Data preserved across refreshes

✅ Improved testability and maintainability

3. No Database Persistence

Files:

src/components/LeadCaptureForm.tsx

src/lib/lead-store.ts
Severity: High
Status: ✅ Fixed (post-approval)

Problem

Form submissions only updated local state; leads were lost on refresh and not persisted in Supabase.

Root Cause

No database connection or persistence logic implemented.

Fix

Created table public.leads with fields: id, name, email, industry, submitted_at, timestamps

Enabled RLS with insert policies for anon/authenticated users

Updated form to insert data into Supabase

Impact

✅ Leads are now stored in Supabase

✅ Data available for analytics and admin

⏳ Supabase types should be regenerated for full TypeScript safety

High & Medium Fixes
4. Redundant Success UI

Files:

src/components/LeadCaptureForm.tsx

src/components/SuccessMessage.tsx
Severity: Medium
Status: ✅ Fixed

Problem

Success message logic existed both inline in the form and in a separate SuccessMessage component.

Root Cause

UI duplication with overlapping logic.

Fix

Consolidated success UI into a single component.

Impact

✅ Cleaner codebase

✅ Consistent transitions and user experience

5. Missing Custom CSS Animations

File: src/index.css
Severity: Medium
Status: ✅ Fixed

Problem

Referenced classes (animate-slide-up, animate-glow, shadow-glow, etc.) were not defined, causing animations to fail and sometimes making elements invisible.

Root Cause

Components referenced CSS classes that weren’t declared in index.css.

Fix

Added the missing animation and style classes.

Impact

✅ Animations now function correctly

✅ Prevented risk of “blank app” appearance

6. External Background GIF & Missing Error Boundaries

File: src/components/LeadCapturePage.tsx
Severity: Medium
Status: ⚠️ Identified (not fixed)

Problem

The page relied on an external GIF for its background. If the asset failed to load, the UI could break. Additionally, no React error boundaries existed to catch runtime errors.

Root Cause

No local fallback or error handling implemented.

Recommendation

Add local fallback for background image

Implement React ErrorBoundary for production

Impact

❌ Risk of blank screen on failed load

❌ Harder debugging of runtime issues

Non-Functional / UX Observations
7. Design Tokens & Hardcoded Colours

Files: LeadCaptureForm.tsx, index.css
Severity: Low
Status: ⚠️ Identified

Problem

Hardcoded gradients and shadows reduced theming consistency with shadcn/tailwind tokens.

Recommendation

Map to shadcn/tailwind design tokens for theming consistency.

8. Accessibility & Focus Management

Files: LeadCapturePage.tsx, form submit flow
Severity: Low
Status: ⚠️ Identified

Problem

Background image had generic alt text (“Background animation”)

No focus shift to success message after form submission

Recommendation

Improve alt text and shift focus programmatically on submit for better screen reader and keyboard UX.

Final Status
✅ Fixed

Duplicate email invocation removed

State management refactored to Zustand

Database persistence implemented (Supabase)

Success UI consolidated

Missing CSS animations added

⚠️ Outstanding

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

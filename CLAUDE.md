@AGENTS.md

# Canteen status website

Students see live photos of campus canteens, post their own photos without
registering, and signal that they (or a group) are on their way.

## Rules

- The full product plan is in `canteen-website-plan.txt`; follow it.
  The step-by-step order is in `canteen-build-guide.txt`.
- We use **Option B (cost-free)** from the plan (section 9):
  - Hosting: Cloudflare Workers via the OpenNext adapter
    (`@opennextjs/cloudflare`). The plan says "Pages Functions"; in this
    project backend routes are Next.js route handlers (`src/app/api/...`)
    that run on the Worker.
  - Photos: **Supabase Storage** (signed upload URLs). NOT Cloudflare R2:
    R2 requires a payment card and the owner chose not to add one.
    Keep photo bandwidth very low (Supabase Free has a monthly egress limit).
  - Database, realtime, anonymous sessions: Supabase Free plan.
  - Don't use Cloudflare services that need a payment card (R2 etc.).
  - Bot protection: Cloudflare Turnstile. Moderation: community flags,
    auto-hide after 3 flags. Cleanup: Cloudflare Cron Triggers.
  - Never add a paid service without asking first.
- I'm a beginner: keep code simple, add short comments, and explain what
  you changed at the end of each task.
- Mobile-first design. Use the theme colours from the theme file
  (`src/app/globals.css`: classes like `bg-primary`, `bg-surface`,
  `text-muted`, `bg-quiet/busy/packed`). Never hard-code hex colours in
  components. UI text is in Croatian.
- Never put secret keys in code; use environment variables.
  Local secrets go in `.env.local` / `.dev.vars` (both git-ignored).
- Enable Row Level Security on every Supabase table.
- Never use the Supabase service role key in browser code.
- Keep bandwidth low: thumbnails in feeds, compress photos in the browser,
  show the 20 most recent photos, delete photos after 24 hours.

## Commands

- `npm run dev` - local dev server at http://localhost:3000
- `npm run preview` - build and run the real Cloudflare Worker locally
- `npm run deploy` - build and deploy to Cloudflare
- `npm run lint` - check code

## Environment notes

- Do NOT enable `cacheComponents` or `partialPrefetching` in
  `next.config.ts`: with the OpenNext adapter they make the Worker hang
  (every page returned 500 on Cloudflare).
- Live site: https://canteen-status.n0146.workers.dev
  Cloudflare builds and deploys automatically on every push to `main`.

- Windows machine. OpenNext warns it is not fully supported on Windows;
  if `npm run preview`/`deploy` fails oddly, build via Cloudflare's GitHub
  integration (runs on Linux) or use WSL.

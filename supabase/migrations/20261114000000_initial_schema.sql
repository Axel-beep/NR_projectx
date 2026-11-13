-- =====================================================================
-- Initial database schema for the canteen status website
-- (plan section 5). Run once in Supabase -> SQL Editor.
--
-- Security model:
--   * Row Level Security (RLS) is ON for every table.
--   * Visitors (roles "anon" and "authenticated") may only READ, and only
--     the rows/columns listed below.
--   * All WRITES go through our server routes (src/app/api/...), which use
--     the secret key. The secret key bypasses RLS, so we need no insert/
--     update policies for visitors.
-- =====================================================================


-- ---------- canteens ---------------------------------------------------
create table public.canteens (
  id            uuid primary key default gen_random_uuid(),
  name          text not null,              -- short name shown in the app
  full_name     text,                       -- official name from sczg.unizg.hr
  slug          text not null unique,       -- used in URLs: /menza/<slug>
  address       text,
  description   text,
  opening_hours text,                       -- human-readable, may be multi-line
  thumbnail_url text,                       -- e.g. /canteens/savska.webp
  sc_url        text,                       -- link to the canteen's SC page
  is_open       boolean not null default true,  -- false = temporarily closed
  sort_order    int not null default 0,
  created_at    timestamptz not null default now()
);


-- ---------- reports (photo + status) ----------------------------------
create table public.reports (
  id          uuid primary key default gen_random_uuid(),
  canteen_id  uuid not null references public.canteens(id) on delete cascade,
  device_id   uuid not null,                -- anonymous visitor ID
  photo_path  text,                         -- path in the "photos" storage bucket
  thumb_path  text,
  status      text check (status in ('quiet', 'busy', 'packed')),  -- null = no status
  created_at  timestamptz not null default now(),
  flag_count  int not null default 0,
  hidden      boolean not null default false
);
create index reports_canteen_recent on public.reports (canteen_id, created_at desc);


-- ---------- arrivals (people on their way) ----------------------------
create table public.arrivals (
  id          uuid primary key default gen_random_uuid(),
  canteen_id  uuid not null references public.canteens(id) on delete cascade,
  device_id   uuid not null,
  group_size  int not null check (group_size between 1 and 20),
  eta         timestamptz not null,         -- now + chosen minutes
  created_at  timestamptz not null default now(),
  cancelled   boolean not null default false
);
create index arrivals_canteen_eta on public.arrivals (canteen_id, eta);
create index arrivals_device on public.arrivals (device_id);


-- ---------- sponsors ---------------------------------------------------
create table public.sponsors (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  image_url   text not null,
  link_url    text,
  placement   text not null check (placement in ('top', 'feed', 'footer')),
  canteen_id  uuid references public.canteens(id) on delete cascade,  -- null = all canteens
  active_from timestamptz not null default now(),
  active_to   timestamptz,                  -- null = no end date
  weight      int not null default 1 check (weight > 0),
  views       int not null default 0,
  clicks      int not null default 0,
  created_at  timestamptz not null default now()
);


-- ---------- flags (community moderation) ------------------------------
create table public.flags (
  id          uuid primary key default gen_random_uuid(),
  report_id   uuid not null references public.reports(id) on delete cascade,
  device_id   uuid not null,
  reason      text,
  created_at  timestamptz not null default now(),
  unique (report_id, device_id)             -- one flag per device per photo
);


-- =====================================================================
-- Row Level Security
-- =====================================================================
alter table public.canteens enable row level security;
alter table public.reports  enable row level security;
alter table public.arrivals enable row level security;
alter table public.sponsors enable row level security;
alter table public.flags    enable row level security;

-- canteens: everyone can read all of them
create policy "Anyone can read canteens"
  on public.canteens for select to anon, authenticated
  using (true);

-- reports: only visible photos from the last 24 hours
create policy "Anyone can read recent visible reports"
  on public.reports for select to anon, authenticated
  using (hidden = false and created_at > now() - interval '24 hours');

-- arrivals: only active ones (not cancelled, ETA not more than 10 min ago)
create policy "Anyone can read active arrivals"
  on public.arrivals for select to anon, authenticated
  using (cancelled = false and eta > now() - interval '10 minutes');

-- sponsors: only those running right now
create policy "Anyone can read active sponsors"
  on public.sponsors for select to anon, authenticated
  using (active_from <= now() and (active_to is null or active_to > now()));

-- flags: no read policy at all -> visitors can never read them


-- =====================================================================
-- Column permissions: hide private columns from visitors.
-- device_id must never be public (it would let people track or
-- impersonate a device). Sponsor stats are only for the admin.
-- =====================================================================
revoke all on public.canteens, public.reports, public.arrivals,
              public.sponsors, public.flags
  from anon, authenticated;

grant select on public.canteens to anon, authenticated;

grant select (id, canteen_id, photo_path, thumb_path, status, created_at)
  on public.reports to anon, authenticated;

grant select (id, canteen_id, group_size, eta, created_at)
  on public.arrivals to anon, authenticated;

grant select (id, name, image_url, link_url, placement, canteen_id, weight)
  on public.sponsors to anon, authenticated;

-- Our server routes use the secret key (role "service_role").
grant all on public.canteens, public.reports, public.arrivals,
             public.sponsors, public.flags
  to service_role;


-- =====================================================================
-- Live updates: let the app subscribe to new reports and arrivals.
-- =====================================================================
alter publication supabase_realtime add table public.reports, public.arrivals;


-- =====================================================================
-- Photo storage bucket (Supabase Storage, free plan).
-- Public read so feeds can show photos; uploads only via signed URLs
-- created by our server, so no upload policy for visitors.
-- Max 1 MB per file, images only.
-- =====================================================================
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('photos', 'photos', true, 1048576, array['image/webp', 'image/jpeg']);

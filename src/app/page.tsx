// Landing page: a grid of canteen cards (Feature 1).
// Runs on the server, so the Supabase data is already in the HTML.
import Image from "next/image";
import Link from "next/link";
import TimeAgo from "@/components/TimeAgo";
import { createClient } from "@/lib/supabase/server";

export default async function Home() {
  const supabase = await createClient();

  // Three small queries. RLS already limits reports to the last 24 h
  // and arrivals to the ones still "incoming".
  const [canteensRes, reportsRes, arrivalsRes] = await Promise.all([
    supabase.from("canteens").select("id, name, slug, thumbnail_url, is_open").order("sort_order"),
    // shortcut: last 200 reports covers all 12 canteens for now; switch to a SQL view if it gets busier.
    supabase.from("reports").select("canteen_id, thumb_path, created_at").order("created_at", { ascending: false }).limit(200),
    supabase.from("arrivals").select("canteen_id, group_size"),
  ]);

  if (canteensRes.error) {
    return <p className="p-4 text-muted">Ne mogu učitati menze. Pokušaj ponovno.</p>;
  }

  return (
    <main className="mx-auto w-full max-w-3xl flex-1 px-4 py-6">
      {/* Sponsor banner slot: filled in a later feature */}
      <div className="mb-6 min-h-16 rounded-2xl border border-dashed border-border" aria-hidden />

      <ul className="grid grid-cols-2 gap-3 sm:grid-cols-3">
        {canteensRes.data.map((canteen) => {
          // Reports are newest first, so the first match is the latest.
          const latest = reportsRes.data?.find((r) => r.canteen_id === canteen.id);
          const incoming = (arrivalsRes.data ?? [])
            .filter((a) => a.canteen_id === canteen.id)
            .reduce((sum, a) => sum + a.group_size, 0);
          const thumb = latest?.thumb_path
            ? supabase.storage.from("photos").getPublicUrl(latest.thumb_path).data.publicUrl
            : canteen.thumbnail_url;

          return (
            <li key={canteen.id}>
              <Link
                href={`/menza/${canteen.slug}`}
                className="block overflow-hidden rounded-2xl border border-border bg-surface"
              >
                <div className="relative aspect-[4/3] bg-primary-soft">
                  {thumb && (
                    <Image src={thumb} alt="" fill unoptimized className="object-cover" />
                  )}
                  {!canteen.is_open && (
                    <span className="absolute left-2 top-2 rounded-full bg-surface px-2 py-0.5 text-xs font-medium text-muted">
                      Zatvoreno
                    </span>
                  )}
                </div>
                <div className="p-3">
                  <p className="font-semibold leading-tight">{canteen.name}</p>
                  <p className="mt-1 text-xs text-muted">
                    {latest ? <TimeAgo date={latest.created_at} /> : "Još nema slika"}
                  </p>
                  {incoming > 0 && (
                    <p className="mt-1 text-xs font-medium text-primary">
                      🚶 {incoming} {incoming === 1 ? "osoba dolazi" : "ljudi dolazi"}
                    </p>
                  )}
                </div>
              </Link>
            </li>
          );
        })}
      </ul>
    </main>
  );
}

// Canteen page: /menza/<slug> (Feature 1, read-only).
// The photo feed is empty for now; uploads come in a later feature.
import Link from "next/link";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function CanteenPage({ params }: { params: Promise<{ slug: string }> }) {
  // In Next.js 16, params is a Promise.
  const { slug } = await params;
  const supabase = await createClient();

  const { data: canteen } = await supabase
    .from("canteens")
    .select("name, address, opening_hours, is_open")
    .eq("slug", slug)
    .maybeSingle();

  if (!canteen) notFound();

  return (
    <main className="mx-auto w-full max-w-3xl flex-1 px-4 py-6">
      <Link href="/" className="text-sm text-muted">← Sve menze</Link>

      <h1 className="mt-2 text-2xl font-bold">{canteen.name}</h1>
      {canteen.address && <p className="text-sm text-muted">{canteen.address}</p>}
      {!canteen.is_open && <p className="mt-2 text-sm font-medium text-packed">Trenutno zatvoreno</p>}
      {canteen.opening_hours && (
        <p className="mt-3 whitespace-pre-line text-sm text-muted">{canteen.opening_hours}</p>
      )}

      {/* Photo feed: empty until the upload feature is built */}
      <section className="mt-6 rounded-2xl border border-dashed border-border bg-surface p-8 text-center">
        <p className="text-muted">Još nema slika – budi prvi!</p>
      </section>
    </main>
  );
}

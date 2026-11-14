// Temporary home page (Phase 0). Feature 1 replaces this with the
// grid of canteen cards. For now it just shows the theme works.
export default function Home() {
  return (
    <main className="mx-auto w-full max-w-3xl flex-1 px-4 py-8">
      <section className="rounded-2xl border border-border bg-surface p-6">
        <h1 className="text-2xl font-bold">Uskoro: menze uživo</h1>
        <p className="mt-2 text-muted">
          Ovdje će biti popis menzi sa svježim slikama i brojem ljudi koji
          upravo dolaze.
        </p>

        {/* Status colours preview: quiet / busy / packed */}
        <div className="mt-6 flex flex-wrap gap-2 text-sm font-medium">
          <span className="rounded-full bg-quiet px-3 py-1 text-white">Mirno</span>
          <span className="rounded-full bg-busy px-3 py-1 text-white">Gužva</span>
          <span className="rounded-full bg-packed px-3 py-1 text-white">Krcato</span>
        </div>

        <button
          type="button"
          className="mt-6 w-full rounded-xl bg-primary px-4 py-3 font-semibold text-on-primary hover:bg-primary-hover sm:w-auto"
        >
          Dolazim
        </button>
      </section>
    </main>
  );
}

// Top bar shown on every page: logo + site name.
// To change the logo, replace public/logo.png (square, about 160x160 px).
import Image from "next/image";
import Link from "next/link";

export default function Header() {
  return (
    <header className="sticky top-0 z-10 border-b border-border bg-surface/95 backdrop-blur">
      <div className="mx-auto flex max-w-3xl items-center gap-3 px-4 py-3">
        <Link href="/" className="flex items-center gap-3">
          <Image
            src="/logo.png"
            alt="SC fsb logo"
            width={40}
            height={40}
            className="rounded-md"
            priority
          />
          <div className="leading-tight">
            <p className="text-lg font-bold text-foreground">Menze uživo</p>
            <p className="text-xs text-muted">Koliko je gužve u menzi?</p>
          </div>
        </Link>
      </div>
    </header>
  );
}

// Supabase client for code that runs in the BROWSER
// (components that start with "use client").
// Uses only the public URL + publishable key, which are safe to expose.
import { createBrowserClient } from "@supabase/ssr";

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
  );
}

// Supabase client for code that runs on the SERVER
// (Server Components, Route Handlers in src/app/api, Server Functions).
// It reads/writes the login cookies so Supabase knows who the visitor is.
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";

export async function createClient() {
  // In Next.js 16, cookies() is async, so we await it.
  const cookieStore = await cookies();

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll();
        },
        setAll(cookiesToSet) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options),
            );
          } catch {
            // Server Components can't set cookies (only Route Handlers and
            // Server Functions can). Safe to ignore here.
          }
        },
      },
    },
  );
}

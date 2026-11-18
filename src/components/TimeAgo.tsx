"use client";
// Shows "prije X min" and refreshes every 30 s (plan section 3, step 5).
// Computed in the browser so the label stays correct without reloading.
import { useEffect, useState } from "react";

export default function TimeAgo({ date }: { date: string }) {
  const [now, setNow] = useState(() => Date.now());

  useEffect(() => {
    const timer = setInterval(() => setNow(Date.now()), 30_000);
    return () => clearInterval(timer);
  }, []);

  const minutes = Math.max(0, Math.floor((now - new Date(date).getTime()) / 60_000));
  let label = "upravo sada";
  if (minutes >= 60) label = `prije ${Math.floor(minutes / 60)} h`;
  else if (minutes >= 1) label = `prije ${minutes} min`;

  // suppressHydrationWarning: server and browser clocks differ by a few seconds.
  return <span suppressHydrationWarning>{label}</span>;
}

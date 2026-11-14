import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import Header from "@/components/Header";
import "./globals.css";

// "latin-ext" is needed for Croatian letters (č, ć, š, ž, đ).
const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin", "latin-ext"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin", "latin-ext"],
});

export const metadata: Metadata = {
  title: "Menze uživo",
  description:
    "Pogledaj svježe slike iz studentskih menzi i javi da dolaziš - bez registracije.",
};

// Colour of the phone's browser bar (light / dark mode).
export const viewport: Viewport = {
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#184898" },
    { media: "(prefers-color-scheme: dark)", color: "#0e1420" },
  ],
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="hr"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <body className="flex min-h-full flex-col">
        <Header />
        {children}
      </body>
    </html>
  );
}

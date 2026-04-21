import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Australian Weather",
  description: "Server-side weather lookup UI",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}

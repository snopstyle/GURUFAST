import './globals.css';
import type { ReactNode } from 'react';

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="fr" className="bg-gradient-to-br from-[#0F172A] to-[#3B82F6] text-white">
      <body className="min-h-screen flex items-center justify-center">{children}</body>
    </html>
  );
}

#!/usr/bin/env bash
set -e

echo "▶  Creating directories…"
mkdir -p app/{quiz,email-gate,results,admin} \
         lib \
         supabase/edge-funcs \
         db \
         scripts \
         public/branding

echo "▶  Writing placeholder files…"

## 1 ▸ Next.js ­files
cat > app/layout.tsx <<'TSX'
import './globals.css';
import type { ReactNode } from 'react';

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="fr" className="bg-gradient-to-br from-[#0F172A] to-[#3B82F6] text-white">
      <body className="min-h-screen flex items-center justify-center">{children}</body>
    </html>
  );
}
TSX

cat > app/page.tsx <<'TSX'
'use client';
import { useRouter } from 'next/navigation';
import { useState } from 'react';

export default function IntroPage() {
  const [name, setName] = useState('');
  const router = useRouter();

  return (
    <main className="w-full max-w-md p-6">
      <h1 className="text-3xl font-bold mb-6">WHY GURU</h1>
      <input
        autoFocus
        placeholder="Entre ton pseudo"
        className="w-full p-3 rounded bg-white/10 mb-4"
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <button
        disabled={!name}
        onClick={() => router.push('/quiz')}
        className="w-full py-3 rounded bg-emerald-500 disabled:opacity-40"
      >
        Commencer le quiz
      </button>
    </main>
  );
}
TSX

## 2 ▸ Lib helpers
cat > lib/supabase.ts <<'TS'
import { createBrowserClient } from '@supabase/ssr';
export const supabase = createBrowserClient<Database>(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);
TS

cat > lib/personality.ts <<'TS'
export type Vec = [number, number, number, number, number, number];
export const sumVecs = (arr: Vec[]): Vec =>
  arr.reduce((acc, v) => acc.map((x, i) => x + v[i]) as Vec, [0, 0, 0, 0, 0, 0]);
TS

## 3 ▸ Supabase SQL schema
cat > supabase/schema.sql <<'SQL'
-- Enable pgvector
create extension if not exists vector;
-- programs table
create table if not exists programs (
  program_id uuid primary key default gen_random_uuid(),
  school text, city text, domain text, title text,
  duration_months int, tuition_eur int,
  personality_vec vector(6)
);
-- questions
create table if not exists questions (
  qid smallint primary key, text text,
  type text check (type in ('radio','likert'))
);
-- answers
create table if not exists answers (
  aid uuid primary key default gen_random_uuid(),
  qid smallint references questions(qid) on delete cascade,
  label text, vector vector(6)
);
-- responses
create table if not exists responses (
  session_id uuid primary key default gen_random_uuid(),
  email text, profile_vec vector(6), created_at timestamptz default now()
);
SQL

## 4 ▸ Edge Function stub
cat > supabase/edge-funcs/score.ts <<'TS'
import { createClient } from "https://deno.land/x/supabase@1.7.1/mod.ts";
const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_ANON_KEY")!
);
Deno.serve(() => new Response("stub"));
TS

## 5 ▸ CSV & seed script placeholders
touch db/weight_matrix.csv
echo '// todo: upload programs + weight matrix' > scripts/seed.ts

echo "✅  Folder structure & placeholders ready."

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

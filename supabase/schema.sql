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

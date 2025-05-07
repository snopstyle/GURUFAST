import { createClient } from "https://deno.land/x/supabase@1.7.1/mod.ts";
const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_ANON_KEY")!
);
Deno.serve(() => new Response("stub"));

-- ============================================================
-- Subham Notes App — Supabase Database Setup
-- Run this WHOLE script in the Supabase SQL Editor:
--   https://supabase.com/dashboard/project/gkixdcpzkjrgioknrbxo/sql/new
-- ============================================================

-- 1) USERS table
CREATE TABLE IF NOT EXISTS public.users (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    is_admin SMALLINT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2) SESSIONS table
CREATE TABLE IF NOT EXISTS public.sessions (
    token TEXT PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 3) NOTES table
CREATE TABLE IF NOT EXISTS public.notes (
    id TEXT PRIMARY KEY,
    filename TEXT DEFAULT '',
    "originalName" TEXT DEFAULT '',
    title TEXT DEFAULT '',
    category TEXT DEFAULT '',
    course TEXT DEFAULT '',
    semester TEXT DEFAULT '',
    url TEXT DEFAULT '',
    date TEXT DEFAULT '',
    size BIGINT DEFAULT 0
);

-- 4) Enable Row Level Security (the backend uses the service-role key,
--    which bypasses RLS, so no policies are required for the app to work)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notes ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- DONE. Refresh the Schema Cache:
--   In Supabase Dashboard, go to Table Editor → click "Refresh"
--   (or run the query below) if 'public.users' still isn't found.
-- ============================================================

-- JEFIT APP - Supabase Schema
-- Robado de la lógica de: Strong (tracking) + Hevy (social) + Smart Fit (cupos)

-- 1. PROFILES (extends auth.users)
create table profiles (
  id uuid references auth.users not null primary key,
  name text,
  role text default 'USER' check (role in ('USER', 'ENTRENADOR')),
  body_weight numeric default 75,
  plan text default 'TRIAL' check (plan in ('TRIAL', 'PRO')),
  cupos_used integer default 0,
  cupos_total integer default 0,
  streak_count integer default 0,
  last_checkin timestamp with time zone,
  created_at timestamp with time zone default now()
);

-- 2. EJERCICIOS
create table ejercicios (
  id uuid default gen_random_uuid() primary key,
  name text,
  muscle_grupo text,
  video_url text,
  video_offline boolean default false,
  dificultad integer check (dificultad >= 1 and dificultad <= 5)
);

-- 3. TRAINING LOGS
create table training_logs (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  date date default current_date,
  ejercicios jsonb,
  meta_gym integer check (meta_gym >= 1 and meta_gym <= 10),
  notas text
);

-- 4. CHECKINS
create table checkins (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  date date default current_date,
  marcado boolean default false,
  hora timestamp with time zone
);

-- 5. CUPOS (ENTRENADOR <-> ALUMNO)
create table cupos (
  id uuid default gen_random_uuid() primary key,
  entrenador_id uuid references auth.users not null,
  alumno_id uuid references auth.users,
  start_date date,
  end_date date,
  estado text default 'ACTIVO' check (estado in ('ACTIVO', 'EXPIRADO'))
);

-- 6. RANKS
create table ranks (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  exercise_id uuid references ejercicios not null,
  rank_score numeric,
  badge text,
  last_updated timestamp with time zone default now()
);

-- ROW LEVEL SECURITY
alter table profiles enable row level security;
alter table training_logs enable row level security;
alter table checkins enable row level security;
alter table cupos enable row level security;
alter table ranks enable row level security;

-- Policies: USER ve solo su data
create policy "Users can view own profile" on profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);

create policy "Users can view own logs" on training_logs for select using (auth.uid() = user_id);
create policy "Users can insert own logs" on training_logs for insert with check (auth.uid() = user_id);

create policy "Users can view own checkins" on checkins for select using (auth.uid() = user_id);
create policy "Users can insert own checkins" on checkins for insert with check (auth.uid() = user_id);

-- Política: ENTRENADOR ve sus cupos/alumnos
create policy "Trainers view own cupos" on cupos for select using (auth.uid() = entrenador_id);
create policy "Trainers assign cupos" on cupos for insert with check (auth.uid() = entrenador_id);

create policy "Users view public exercises" on ejercicios for select to authenticated;
create policy "Users view public ranks" on ranks for select to authenticated;

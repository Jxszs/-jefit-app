# Setup Supabase - Guía paso a paso

## 1. Crear proyecto (5 minutos)

1. Ve a [supabase.com](https://supabase.com) → **New Project**
2. Nombre: `jefit-app`
3. Password: elige una segura (guárdala)
4. Region: `South America (sa-east-1)` o `US East`
5. Espera a que se cree (3-5 minutos)

## 2. Obtener credenciales

Ve a **Project Settings → API**:
- `SUPABASE_URL` → `https://[PROJECT_REF].supabase.co`
- `SUPABASE_ANON_KEY` → `eyJ...` (usado en frontend, público)
- `SUPABASE_SERVICE_ROLE_KEY` → `eyJ...` (usado en backend, **SECRETO**)

## 3. Configurar Schema DB

```bash
# Desde la terminal, usando el SQL editor de Supabase:
```

O copia el contenido de `supabase/schema.sql` → pégalo en **Supabase Dashboard → SQL Editor → New Query** → **Run**.

## 4. Configurar .env

**Frontend (.env)**:
```
SUPABASE_URL=https://[PROJECT_REF].supabase.co
SUPABASE_ANON_KEY=[ANON_KEY]
```

**Backend (.env)**:
```
SUPABASE_URL=https://[PROJECT_REF].supabase.co
SUPABASE_ANON_KEY=[ANON_KEY]
SUPABASE_SERVICE_ROLE_KEY=[SERVICE_ROLE_KEY]
JWT_SECRET=una_clave_larga_secreta
PORT=5000
```

## 5. Running

```bash
# Backend
cd backend && npm install && npm run dev

# Frontend
cd frontend && flutter pub get
flutter run --dart-define=SUPABASE_URL=https://... --dart-define=SUPABASE_ANON_KEY=eyJ...

# Algoritmo de ranks
cd algorithms && pip install -r requirements.txt
SUPABASE_URL=https://... SUPABASE_ANON_KEY=eyJ... python rank_calculator.py [user_id]
```

## 6. Variables de entorno (alternativo)

Puedes crear un script `.envrc` (con direnv):
```bash
export SUPABASE_URL=...
export SUPABASE_ANON_KEY=...
export SUPABASE_SERVICE_ROLE_KEY=...
```

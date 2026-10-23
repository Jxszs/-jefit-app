# MVP Semana 1: Auth + Dashboard

## Objetivo
Autenticación multi-rol (User/Entrenador) + Dashboard principal con sistema de check-in.

---

## Historias de Usuario (US-001 a US-003, US-011)

| ID | Historia | Criterio de Aceptación |
|---|---|---|
| US-001 | Como usuario nuevo, quiero registrarme con email+password | 1. Formulario con name/email/password/role 2. Validación 3. Profile creado en Supabase |
| US-002 | Como usuario, quiero iniciar sesión | 1. Email+password 2. JWT token 3. Redirige dashboard |
| US-003 | Como entrenador, veo mi dashboard con cupos | 1. Rol detectado 2. cupos_used/total visibles |
| US-010 | Como usuario, marco check-in diario | 1. Botón + 2. Heatmap actualizado |

---

## Implementación

### Frontend
- `lib/main.dart` — Supabase.initialize + AuthGate stream
- `lib/services/auth_service.dart` — register/login/logout
- `lib/screens/login_screen.dart` — formulario role selector
- `lib/screens/register_screen.dart` — choice chips USER/ENTRENADOR
- `lib/screens/dashboard_screen.dart` — stats cards + streak + heatmap

### Backend
- `backend/src/routes/authRoutes.js` — POST/GET auth endpoints
- `backend/src/controllers/authController.js` — register/login/me
- `backend/src/routes/checkinRoutes.js` — toggle + history

### DB
- `supabase/schema.sql` — tabla `profiles` con RLS policies

---

## Testing

| Acción | Expected Result | Status |
|---|---|---|
| Register USER | Profile creado, role=USER | Pending |
| Register ENTRENADOR | cupos_total=10 | Pending |
| Login | JWT token + profile | Pending |
| Check-in | marcado=true, streak+1 | Pending |
| Heatmap | 30-day history loaded | Pending |

---

## Deployment local

```bash
# Backend
cd backend
npm install
cp .env.example .env  # configurar Supabase
npm run dev

# Frontend
cd frontend
flutter pub get
flutter run  # hot reload
```

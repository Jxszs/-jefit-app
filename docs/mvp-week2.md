# MVP Semana 2: Tracking de Fuerza

## Objetivo
Training wizard (Strong style) + logs CRUD + ejercicios con mock data.

---

## Historias de Usuario

| ID | Historia | Criterio de Aceptación |
|---|---|---|
| US-004 | Como usuario, quiero registrar un entrenamiento | 1. Wizard de ejercicios → series/reps/carga 2. POST /api/tracking/log 3. Nota "Guardado" |
| US-005 | Como usuario, quiero ver mi historial | GET /api/tracking/logs → lista con fechas 3. Tap → detalle |
| US-013 | Como usuario, busco un ejercicio | Search en ejercicios 2. Categorías: Empuje/Tirón/Piernas/Core |

---

## Arquitectura (feature/tracking)

### Frontend
- `services/training_service.dart` — mock data + Supabase-ready
- `screens/training_wizard.dart` — wizard stepper (Ya existe)
- `screens/exercise_search.dart` — buscar ejercicios

### Backend  
- `controllers/exerciseController.js` — mock data
- `controllers/trainingController.js` — crear + listar logs
- `routes/exerciseRoutes.js` — GET /api/ejercicios

### Data
- `ejerciciosMock` → 10 ejercicios base (Press, Sentadilla, Peso muerto...)
- `templatesMock` → Full Body, Push Pull Legs

---

## Testing (Mock Mode)

```bash
# Frontend (mock data - Sin Supabase)
cd frontend
flutter run
# Auth flow: usar credenciales mock (no requiere backend)

# Backend (mock data)
cd backend
npm install
npm run dev
# GET http://localhost:5000/api/ejercicios
```

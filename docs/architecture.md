# Arquitectura JEFIT APP

## Stack Tecnológico
- **Frontend**: Flutter 3.x (Android + iOS)
- **Styling**: shadcn_flutter + Material 3 Dark + google_fonts
- **Backend**: Node.js 18 + Express 4
- **Database**: MongoDB 7 (Mongoose ODM)
- **Algorithms**: Python 3.12 (rank calculation)
- **Auth**: JWT + bcryptjs

## Arquitectura
```
┌─────────────┐     HTTP/REST      ┌─────────────┐
│  Flutter    │ ◄────────────────► │ Node.js API │
│  Frontend   │                    │  (Express)  │
└─────────────┘                    └──────┬──────┘
                                          │
┌─────────────┐     Python script        │
│ Algorithms  │ ◄────────────────────────┤
│ (rank)      │                          │
└─────────────┘                          ▼
                                    ┌──────────┐
                                    │  MongoDB │
                                    └──────────┘
```

## Database Schema (MongoDB)
Ver [db-schema.md](db-schema.md)

## API Endpoints
Ver [api-endpoints.md](api-endpoints.md)

## App Flow (Robado de Symmetry + Cbum)
1. Auth (multi-rol: USER / ENTRENADOR)
2. Dashboard principal (progreso + rank)
3. Check-in diario (heatmap)
4. Training wizard (Strong style)
5. Rank system + body map (Symmetry)
6. Cupos marketplace (Smart Fit)
7. Social leaderboard (Strava)
8. Before/after (Cbum)

## Estilo Visual (Dark Aesthetic)
- Primary bg: #0A0A0B (negro profundo)
- Card bg: #1A1A1D (gris oscuro)
- Success: #10B981 (verde Symmetry)
- Trophy: #D4AF37 (oro Cbum)
- Text primary: #F8FAFC

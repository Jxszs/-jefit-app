# MVP Semana 3: Rank System + Body Map + Leaderboard

## Objetivo
Sistema de ranks 0-100 (robado de Symmetry) + body map interactivo + leaderboard social.

---

## Historias de Usuario

| ID | Historia | Criterio de Aceptación |
|---|---|---|
| US-006 | Como usuario, quiero ver mi rank por ejercicio | 1. Body map con colores 2. Tap → detalle ejercicio 3. Badge visible |
| US-007 | Como amigo, quiero el leaderboard | GET leaderboard → top 10 2. Posición + rank total 3. Badges |
| US-008 | Como usuario, gano badges al subir rank | Titán 🥇 (rank≥90) / Guerrero 🥈 (rank≥70) / Héroe 🥉 (rank≥50) |

---

## Arquitectura (feature/ranks)

### Frontend
- `services/rank_service.dart` — mock ranks + leaderboard (Supabase-ready)
- `screens/rank_screen.dart` — body map interactivo (colores por muscle)
- `screens/leaderboard_screen.dart` — top amigos (Symmetry style)

### Backend (Python)
- `algorithms/rank_calculator.py` — conectado a Supabase
  Score = (volumen×0.4) + (frecuencia×20) + (intensidad×10)

### Rank system (robado de Symmetry)
| Rank | Badge | Criteria |
|---|---|---|
| 90-100 | Titán 🥇 | Top 1% fuerza |
| 70-89 | Guerrero 🥈 | Fuerza alta |
| 50-69 | Héroe 🥉 | Promedio-alto |
| 30-49 | Guerrero Jr. 🛡️ | Principiante-activo |
| 0-29 | Novato 🪙 | Iniciando |

---

## Body Map (muscles interactivos)
| Músculo | Color (Symmetry) |
|---|---|
| pecho | verde (#10B981) |
| piernas | azul (#3B82F6) |
| espalda | oro (#D4AF37) |
| hombros | verde |
| brazos | gris (textSecondary) |
| core | azul |

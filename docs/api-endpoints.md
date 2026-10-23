# API Endpoints (Blueprint)

## Auth
- POST `/api/auth/register` - Register USER/ENTRENADOR
- POST `/api/auth/login` - Login + JWT
- GET  `/api/auth/me` - Get current user

## Users
- GET  `/api/users/profile` - Get profile
- PUT  `/api/users/profile` - Update profile

## Tracking
- POST `/api/tracking/log` - Create training log
- GET  `/api/tracking/logs` - Get all logs (user)
- GET  `/api/tracking/log/:id` - Get single log

## Checkin
- POST `/api/checkin` - Mark check-in (toggle)
- GET  `/api/checkin/history` - Get check-in history (30 days)

## Ejercicios
- GET  `/api/ejercicios` - List all ejercicios
- GET  `/api/ejercicios/:id` - Get single ejercicio

## Ranks
- GET  `/api/ranks/user/:uid` - Get user's ranks
- GET  `/api/ranks/exercise/:eid` - Get rank leaderboard
- POST `/api/ranks/calculate` - Trigger rank calculation (Python)

## Cupos (ENTRENADOR)
- GET  `/api/cupos` - List cupos (entrenador)
- POST `/api/cupos/create` - Create cupo link
- POST `/api/cupos/assign` - Assign alumno to cupo
- GET  `/api/cupos/alumnos` - List alumnos

## Social
- GET  `/api/social/leaderboard` - Global leaderboard
- GET  `/api/social/feed` - Feed de amigos

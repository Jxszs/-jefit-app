# Database Schema (MongoDB)

## Collections

### 1. users
```json
{
  "_id": "ObjectId",
  "uid": "String (UUID)",
  "role": "USER | ENTRENADOR",
  "name": "String",
  "email": "String (unique)",
  "password_hash": "String",
  "body_weight": "Number",
  "plan": "TRIAL | PRO",
  "cupos_used": "Number",
  "cupos_total": "Number",
  "streak_count": "Number",
  "last_checkin": "Date",
  "created_at": "Date",
  "updated_at": "Date"
}
```

### 2. ejercicios
```json
{
  "_id": "ObjectId",
  "eid": "String",
  "name": "String",
  "muscle_grupo": "piernas | espalda | pecho | hombros | brazos",
  "video_url": "String",
  "video_offline": "Boolean",
  "dificultad": "Number (1-5)"
}
```

### 3. training_logs
```json
{
  "_id": "ObjectId",
  "user_id": "ObjectId (ref: users)",
  "date": "Date",
  "ejercicios": [
    {
      "eid": "String (ref: ejercicios)",
      "series": [
        {"reps": "Number", "carga": "Number", "nota": "String"}
      ]
    }
  ],
  "meta_gym": "Number (1-10)",
  "notas": "String"
}
```

### 4. checkins
```json
{
  "_id": "ObjectId",
  "user_id": "ObjectId (ref: users)",
  "date": "Date",
  "marcado": "Boolean",
  "hora": "Date"
}
```

### 5. cupos
```json
{
  "_id": "ObjectId",
  "entrenador_id": "ObjectId (ref: users)",
  "alumno_id": "ObjectId (ref: users)",
  "start_date": "Date",
  "end_date": "Date",
  "estado": "ACTIVO | EXPIRADO"
}
```

### 6. ranks
```json
{
  "_id": "ObjectId",
  "user_id": "ObjectId (ref: users)",
  "exercise_id": "ObjectId (ref: ejercicios)",
  "rank": "Number (0-100)",
  "last_updated": "Date",
  "badges": ["String"]
}
```

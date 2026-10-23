# PLAN DE PRUEBAS - JEFIT APP

## 1. Estrategia de Testing

| Tipo | Herramienta | Cobertura | Responsable |
|---|---|---|---|
| Unit tests | Jest (JS) / unittest (Python) | ≥ 80% backend | Backend |
| Widget tests | flutter_test | Dashboard, Auth | Frontend |
| Integration | Supabase SDK | Auth, CRUD | Full stack |
| E2E | Appium + Detox | Critical flows | QA |
| Manual | TestFlight + Play Store | UX flows | Product Owner |

---

## 2. User Stories (MVP)

### Epic 1: Autenticación (auth-supabase)
| ID | Historia | Test |
|---|---|---|
| US-001 | Como usuario, quiero registrarme con email + password | Verificar email + password hash en DB |
| US-002 | Como usuario, quiero iniciar sesión | Verificar JWT generado |
| US-003 | Como entrenador, quiero crear cupos | Verificar cupos_total en profile |

### Epic 2: Tracking (tracking)
| ID | Historia | Test |
|---|---|---|
| US-004 | Como usuario, quiero registrar un entrenamiento | Verificar ejercicios[0].sets en training_logs |
| US-005 | Como usuario, quiero ver mi historial | Verificar GET /api/logs |
| US-006 | Como usuario, quiero usar un template | Duplicate template → new log |

### Epic 3: Rankings (ranks)
| ID | Historia | Test |
|---|---|---|
| US-007 | Como usuario, quiero ver mi rank | Verificar rank en body map |
| US-008 | Como usuario, quiero subir de badge | rank ≥ 10 → badge actualizado |
| US-009 | Como amigo, quiero ver el leaderboard | GET /api/ranks/leaderboard |

### Epic 4: Marketplace (trainer-marketplace)
| ID | Historia | Test |
|---|---|---|
| US-010 | Como alumno, quiero ocupar un cupo | cupos_used ++ |
| US-011 | Como entrenador, quiero ver mis alumnos | SELECT alumnos por entrenador_id |
| US-012 | Como entrenador, quiero ver progreso alumno | Dashboard alumno per trainer |

---

## 3. Test Cases Críticos (release checklist)

Pre-release (release/v1.0):

| ID | Descripción | Expected | Status |
|---|---|---|---|
| TC-01 | App abre y muestra dashboard | Login screen visible | Pending |
| TC-02 | Registro con email válido | Usuario creado + redirect dashboard | Pending |
| TC-03 | Login con credenciales válidas | JWT token + dashboard cargado | Pending |
| TC-04 | Registro de training log | Log visible en historial | Pending |
| TC-05 | Rank calculation para ejercicio | Rank actualizado en DB | Pending |
| TC-06 | Check-in diaryario | Heatmap actualizado | Pending |
| TC-07 | Crear cupo (entrenador) | Cupo visible en marketplace | Pending |
| TC-08 | Reservar cupo (alumno) | cupos_used incrementa + cupo asignado | Pending |

---

## 4. QA Metrics

| Métrica | Objetivo | Herramienta |
|---|---|---|
| Defects per release | ≤ 3 | GitHub Issues |
| Test coverage | ≥ 80% | Jest/coverage |
| Mean time to detect | ≤ 2 hrs | Sentry |
| Release approval time | ≤ 24 hrs | PR review |

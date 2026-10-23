# 💪 JEFIT APP

**Tu app de gym: tracking + ranks + marketplace de entrenadores**
Estilo dark aesthetic (robado de Symmetry + Cbum) | Desarrollo profesional con ISO 9001/27001 + marco legal chileno.

## Arquitectura
| Capa | Tecnología |
|---|---|
| Frontend | Flutter 3.x (iOS + Android) |
| Backend | Node.js + Express + Supabase |
| Algoritmos | Python 3.12 (rank calculation) |
| DB | Supabase (PostgreSQL + Auth) |
| UI | shadcn_flutter + Material 3 Dark |
| CI/CD | GitHub Actions |

## Branch Strategy (GitFlow)
```
main              → producción
develop           → integración continua
feature/*         → funcionalidades
release/*         → preparación de release
hotfix/*          → correcciones urgentes
poc/*             → pruebas rapidas
```
**Politica:** PR requiere 1 aprobacion + CI pasado + checklist ISO

## Documentacion
| Tipo | Documento |
|---|---|
| ISO 9001 | [Quality Manual](docs/iso9001/quality-manual.md) |
| ISO 27001 | [Risk Assessment](docs/iso27001/risk-assessment.md) |
| Legal (Chile) | [Marco Legal](docs/legal/marco-legal-chile.md), [Terminos](docs/legal/terms.md), [Privacidad](docs/legal/privacy-policy.md) |
| Tests | [Test Plan](docs/testing/test-plan.md) |
| Procesos | [SOP](docs/processes/SOP-change-management.md) |
| MVP | [Week 1](docs/mvp-week1.md), [Week 2](docs/mvp-week2.md), [Week 3](docs/mvp-week3.md) |
| Setup | [Supabase Setup](docs/setup-supabase.md), [API Endpoints](docs/api-endpoints.md), [Schema](docs/db-schema.md) |

## Development

### Backend
```bash
cd backend
npm install
cp .env.example .env   # configurar Supabase
npm run dev            # http://localhost:5000
```

### Frontend
```bash
cd frontend
flutter pub get
flutter run -d chrome  # o -d [device]
```

### Algorithms (rank calculation)
```bash
cd algorithms
pip install -r requirements.txt
python rank_calculator.py [user_id]
```

## Roadmap (8 semanas)
| Semana | Feature | Estado |
|---|---|---|
| 1 | Auth multi-rol + Dashboard + check-in | Completado |
| 2 | Training wizard + logs | Completado |
| 3 | Rank system + body map + leaderboard | Completado |
| 4 | Cupos marketplace (Smart Fit) | Backend completado |
| 5 | Video tutoriales + analisis de forma | Pendiente |
| 6 | Integracion Supabase online | Pendiente (credenciales) |
| 7 | Testing + CI/CD | En progreso |
| 8 | Release v1.0 + store submission | Pendiente |

## Cumplimiento Legal (Chile)
- Ley 19.628 (Proteccion de Datos Personales)
- Ley 21.595 (Servicios de Comunicacion Electronica)
- GDPR (para usuarios UE)

## Contacto
- Email: jesus@jefit-app.com
- GitHub: [@Jxszs](https://github.com/Jxszs)

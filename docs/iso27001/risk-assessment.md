# 📋 JEFIT APP - ANÁLISIS DE RIESGOS (ISO 27001)

## 1. Metodología de Evaluación de Riesgos

**Alcance:** Aplicación móvil, backend Supabase, algoritmos Python, infraestructura.

**Umbral de riesgo:** Media (N° 15-25) → requiere tratamiento obligatorio.

---

## 2. Riesgos Identificados

| Riesgo | Probabilidad (1-5) | Impacto (1-5) | Score | Tratamiento |
|---|---|---|---|---|
| Fuga de datos de usuarios (Ley 19.628) | 3 | 5 | 15 | Encriptar + RBAC + logs |
| Fallo en algoritmo de ranking | 2 | 4 | 8 | Tests unitarios + fallback |
| Downtime Supabase (vendor lockin) | 3 | 3 | 9 | Backup + failover |
| Acceso no autorizado a cupos Premium | 4 | 3 | 12 | JWT + role check middleware |
| Carga en video streaming (ejercicios) | 2 | 2 | 4 | CDN + caching |
| App crash en iOS/Android | 3 | 2 | 6 | Monitoring (Sentry) + tests |

---

## 3. Controles de Seguridad (ISMS)

| Categoria | Control | Responsable | Frecuencia |
|---|---|---|---|
| Acceso | 2FA obligatoria para admins | DevOps | Continuo |
| Datos | Encriptación AES-256 en DB | Backend | Continuo |
| Código | Code review pre-PR | Senior Dev | Cada PR |
| Infraestructura | Backup diario Supabase | DevOps | Diario |
| Logs | Audit trail de accesos | Backend | Continuo |

---

## 4. Plan de Respuesta a Incidentes

1. **Detección**: Monitoreo (Sentry + Supabase logs)
2. **Clasificación**: Baja/Med/Alta (según score de riesgo)
3. **Respuesta**: Equipo de incidentes activado en Slack #incidencias
4. **Documentación**: Post-mortem → `docs/incident-reports/YYYYMMDD.md`
5. **Cierre**: Verificación + lecciones aprendidas

> Responsable Seguridad: Backend Lead
> Fecha última actualización: __/__/____

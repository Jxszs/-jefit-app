# 📋 JEFIT APP - DOCUMENTACIÓN ISO 9001

## 1. Alcance del Sistema de Gestión de Calidad

**Producto:** JEFIT APP - Aplicación móvil de fitness con tracking de fuerza, sistema de rankings y marketplace de entrenadores.

**Alcance:** Desarrollo, mantenimiento y soporte de la aplicación móvil iOS/Android, backend Supabase, algoritmos Python y documentación asociada.

**Leyes aplicables:** 
- ISO 9001:2015 (Gestión de Calidad)
- Ley Chilena 19.628 (Protección de Datos Personales)
- Ley Chilena 21.595 (Servicios de Comunicación Electrónica)
- Directiva Europea 2016/679 (GDPR) - para usuarios de la UE

---

## 2. Procesos del SGC

| Proceso | Entrada | Salida | Responsable |
|---|---|---|---|
| Requisitos del cliente | Feedback usuarios, issues | User stories | Product Owner |
| Diseño del software | User stories, arquitectura | Diagramas, specs | Arquitecto/Senior |
| Desarrollo | Specs, diagramas | Código fuente | Dev Team |
| Testing/QA | Código, test cases | Bugs reportados | QA/Testing |
| Deployment | Código aprobado | App en stores | DevOps |
| Soporte | Bugs, feedback | Issues, mejoras | Support Team |

---

## 3. Indicadores de Calidad (KPIs)

| Métrica | Objetivo | Fórmula |
|---|---|---|
| Bug resolution time | ≤ 24 hrs | Tiempo desde reporte hasta fix |
| Code coverage | ≥ 80% | Tests pasados / total tests |
| Deployment success rate | ≥ 95% | Deploys exitosos / total deploys |
| Mean time to recovery | ≤ 4 hrs | Tiempo entre fallo y recuperación |

---

## 4. Mejora Continua

- **Revisión trimestral** del SGC por el equipo
- **Auditoría interna** semestral
- **Feedback de usuarios** → backlog priorizado
- **Lecciones aprendidas** post-release en `docs/lecciones-aprendidas/`

> Responsable SGC: Product Owner (Jesús)
> Fecha última revisión: __/__/____

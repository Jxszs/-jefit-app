# SOP - Gestión de Cambios y Releases

**Código:** SOP-SW-DEV-01 | **Versión:** 1.0 | **Responsable:** DevOps

## 1. Objetivo
Establecer el proceso para incorporar cambios al código y lanzar versiones a producción.

## 2. Alcance
- Todo cambio al código fuente (frontend, backend, algorithms)
- Releases a App Store / Play Store
- Hotfix en producción

## 3. Procedimiento

### 3.1. Desarrollo de funcionalidad (feature)

1. Crear rama desde `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/ nombre-funcionalidad
   ```

2. Implementar + commits con conventional commits:
   ```
   feat: tracking wizard con antes/después
   fix: corrección en cálculo de rank
   ```

3. Push + Pull Request a `develop`
4. **Code review obligatorio** por 1 senior + test automatizado
5. Merge a `develop` → CI/CD corre tests

### 3.2. Release (cada 2 semanas o funcionality freeze)

1. Desde `develop`, crear rama `release/vX.Y`:
   ```bash
   git checkout develop
   git checkout -b release/v1.2
   ```

2. **QA valida** (test plan completo)
3. Merge a `main` → **tag** + deploy a stores
4. Merge a `develop` (sync)

### 3.3. Hotfix (urgencias)

1. Desde `main`, crear `hotfix/*`:
   ```bash
   git checkout main
   git checkout -b hotfix/ bug-crítico
   ```

2. Fix + PR a `main` y `develop`
3. Tag + deploy inmediato

## 4. Definition of Done
Un feature está "hecho" cuando:
- [ ] Código desarollado y comentado
- [ ] Tests unitarios ≥ 80% coverage
- [ ] Code review aprobada (1 senior)
- [ ] Documentation actualizada
- [ ] Deploy en staging validado

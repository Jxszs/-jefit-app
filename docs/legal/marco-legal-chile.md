# 📋 JEFIT APP - LEYES CHILENAS APLICABLES

## 1. Ley 19.628 - Protección de Datos Personales

**Aplicable:** App móvil con usuarios en Chile. Registro de datos personales (nombre, email, peso, medidas, videos).

**Obligaciones implementadas:**
- [ ] **Consentimiento explícito** en onboarding (checkbox doble)
- [ ] **Datos mínimos** (solo nombre + email inicialmente)
- [ ] **Derecho a la portabilidad** (exportar datos desde Settings)
- [ ] **Derecho al borrado** (eliminar cuenta → purge DB + Storage)
- [ ] **Notificación de brechas** (24h a la autoridad + usuarios)
- [ ] **DPO interno** (Product Owner como encargado)
- [ ] **Transferencia internacional**: Supabase (USA) → cláusulas contractuales

## 2. Ley 21.595 - Servicios de Comunicación Electrónica

**Aplicable:** App móvil con funcionalidades de red social (rankings, competencias, feed).

**Obligaciones:**
- [ ] **Términos de Servicio** en `legal/terms.md`
- [ ] **Política de Privacidad** en `legal/privacy-policy.md`
- [ ] **Identidad del prestador** (Jesús, RUT, contacto)
- [ ] **Moderación de contenido** (reportar usuarios/ejercicios)
- [ ] **No publicidad engañosa** (claims de resultados)

## 3. Registro de actividad con el correo electrónico

```dart
// En onboarding, el rol user debe aceptar:
// ☐ He leído los Términos de Servicio
// ☐ Autorizo el tratamiento de mis datos personales (Ley 19.628)
// ☐ Acepto recibir notificaciones push (Ley 21.595)
```

## 4. Responsables

| Rol | Nombre | Contacto |
|---|---|---|
| Titular | [Nombre completo] | [Email] |
| DPO | [Product Owner] | jesus@jefit-app.com |
| Encargado DDHH | [Product Owner] | jesus@jefit-app.com |

## 5. Checklist de cumplimiento (pre-launch)

- [ ] Términos de Servicio redactados
- [ ] Política de privacidad con datos de contacto
- [ ] Consentimiento CCPA/GDPR (para usuarios internacionales)
- [ ] Formulario de borrado de cuenta funcional
- [ ] Exportación de datos funcional
- [ ] Registro de actividad de datos (auditoría trimestral)

> Fecha última actualización legal: __/__/____
> Próximo review legal: __/__/____

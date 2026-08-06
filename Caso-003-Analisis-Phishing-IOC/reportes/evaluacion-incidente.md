# Evaluación y respuesta del incidente

## Clasificación

- **Veredicto:** phishing confirmado — simulación controlada
- **Categoría:** phishing orientado al robo de credenciales
- **Vectores:** enlace engañoso y adjunto HTML
- **Riesgo potencial:** alto
- **Impacto real en el laboratorio:** ninguno
- **Confianza analítica:** alta
- **Estado:** contenido y analizado

## Fundamentos del veredicto

1. El dominio `micros0ft-support.example` suplanta visualmente a Microsoft mediante el uso del número cero.
2. Las identidades `From`, `Reply-To` y `Return-Path` no coinciden.
3. SPF y DMARC presentan resultado `fail`; DKIM no está presente.
4. El asunto utiliza urgencia y amenaza de suspensión en 24 horas.
5. El texto visible del enlace muestra `account.microsoft.com`, pero el destino real es `login-microsoft.example`.
6. El archivo HTML adjunto dirige a `account-verify.example`.
7. La regla YARA de Athena Labs detectó tanto el correo como el adjunto.
8. ClamAV no detectó malware, lo que demuestra que un resultado antivirus limpio no descarta phishing.

## MITRE ATT&CK

- **T1566.001 — Phishing: Spearphishing Attachment:** uso de un archivo HTML adjunto como mecanismo de redirección.
- **T1566.002 — Phishing: Spearphishing Link:** uso de enlaces destinados a conducir al usuario hacia infraestructura fraudulenta.

## Acciones inmediatas recomendadas

1. Poner el mensaje en cuarentena.
2. Preservar el correo original y calcular sus hashes.
3. Bloquear los dominios, URL, direcciones de correo e IP validados.
4. Buscar mensajes similares en todos los buzones.
5. Revisar registros de proxy, DNS, correo e identidad.
6. Identificar usuarios que hayan abierto enlaces o adjuntos.
7. Eliminar copias adicionales del mensaje desde la plataforma de correo.
8. Notificar al equipo SOC y documentar el incidente.

## Acciones si un usuario ingresó credenciales

1. Restablecer inmediatamente la contraseña.
2. Revocar sesiones y tokens activos.
3. Verificar o restablecer MFA.
4. Revisar accesos anómalos y cambios en la cuenta.
5. Inspeccionar reglas de reenvío y delegaciones de correo.
6. Aumentar temporalmente la vigilancia sobre la identidad afectada.

## Acciones si el adjunto fue ejecutado

1. Aislar el endpoint afectado.
2. Preservar memoria, procesos, conexiones y registros.
3. Ejecutar análisis EDR y antivirus.
4. Buscar persistencia y actividad posterior a la ejecución.
5. Escalar a respuesta a incidentes si se confirma compromiso.

## Resultado del laboratorio

No se abrieron enlaces ni se ejecutó contenido. Las URL utilizan dominios `.example` y la IP `203.0.113.77` pertenece a un rango reservado para documentación. Por tanto, el impacto real fue nulo y la muestra permaneció contenida durante todo el análisis.

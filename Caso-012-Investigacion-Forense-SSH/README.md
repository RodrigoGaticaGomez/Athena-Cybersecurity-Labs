# 🔎 CASO-012 | Investigación Forense de Autenticación SSH

> Simulación controlada de un incidente de autenticación SSH en Linux siguiendo una metodología de **Digital Forensics and Incident Response (DFIR)**.

---

## 📖 Descripción

Este laboratorio documenta el ciclo completo de una investigación forense sobre un servicio OpenSSH en un sistema Ubuntu.

A diferencia de un laboratorio basado únicamente en el análisis de registros existentes, en este caso el incidente fue diseñado y ejecutado de forma controlada para generar evidencia real que posteriormente fue preservada, analizada y documentada.

El objetivo principal fue comprender el comportamiento del servicio OpenSSH frente a diferentes escenarios de autenticación y aplicar una metodología profesional de investigación forense.

---

# 📋 Resumen Ejecutivo

| Campo | Valor |
|-------|-------|
| Caso | CASO-012 |
| Tipo | Investigación Forense de Autenticación SSH |
| Metodología | Digital Forensics and Incident Response (DFIR) |
| Sistema Analizado | Ubuntu 24.04 LTS |
| Servicio Investigado | OpenSSH Server |
| Evidencia Principal | `/var/log/auth.log` |
| Estado | ✅ Finalizado |
| Entorno | Laboratorio controlado |

---

## 📑 Contenido

- Descripción
- Objetivos
- Escenario del laboratorio
- Herramientas utilizadas
- Arquitectura del laboratorio
- Metodología
- Estructura del proyecto
- Evidencias
- Cadena de Custodia
- IOC
- Competencias desarrolladas
- Timeline
- Hallazgos
- Lecciones aprendidas
- Conclusión
- Consideraciones éticas
- Autor

Este caso documenta el proceso completo de preparación, generación, preservación e investigación de un incidente de autenticación SSH utilizando evidencia creada en un entorno controlado.

---

# 🎯 Objetivos

- Comprender el funcionamiento del servicio OpenSSH.
- Generar un incidente de autenticación controlado.
- Preservar correctamente la evidencia digital.
- Aplicar cadena de custodia.
- Verificar la integridad mediante SHA-256.
- Identificar Indicadores de Compromiso (IOC).
- Construir una línea temporal del incidente.
- Elaborar un informe forense técnico.

---

# 🏗️ Escenario del laboratorio

Servidor:

- Ubuntu 24.04
- OpenSSH Server
- Puerto TCP 22

Equipo atacante:

- Kali Linux

Escenarios simulados:

✅ Usuario inexistente

✅ Usuario válido con contraseña incorrecta

✅ Usuario válido con autenticación exitosa

---

# 🛠️ Herramientas utilizadas

| Herramienta | Propósito |
|-------------|-----------|
| Ubuntu 24.04 LTS | Sistema objetivo |
| Kali Linux | Máquina atacante |
| OpenSSH Server | Servicio analizado |
| systemctl | Administración del servicio SSH |
| ss | Verificación de puertos en escucha |
| grep | Búsqueda de eventos |
| tail | Revisión de registros recientes |
| sha256sum | Verificación de integridad |
| cp | Preservación de evidencia |
| tee | Registro del hash |

---

# 🖥️ Arquitectura del laboratorio

                Kali Linux
          (Máquina atacante)
                    │
                    │ SSH (TCP/22)
                    ▼
+--------------------------------------+
| Ubuntu 24.04 LTS                     |
|--------------------------------------|
| OpenSSH Server                       |
| auth.log                             |
| Evidencias                           |
| Hash SHA-256                         |
+--------------------------------------+

Todos los intentos de autenticación fueron realizados sobre infraestructura propia y en un entorno controlado con fines exclusivamente educativos.

---

# 🔬 Metodología aplicada

El laboratorio fue desarrollado siguiendo el siguiente flujo de trabajo:

1. Preparación del entorno.
2. Configuración del servicio SSH.
3. Generación del incidente.
4. Preservación de la evidencia.
5. Cálculo del hash SHA-256.
6. Cadena de custodia.
7. Análisis de registros.
8. Identificación de IOC.
9. Construcción del Timeline.
10. Elaboración del informe forense.

---

# 📂 Estructura del proyecto

```text
Caso-012-Investigacion-Forense-SSH
│
├── documentacion/
├── evidencias/
├── logs/
├── reportes/
├── scripts/
└── README.md
```

---

# 📸 Evidencias

| Captura | Evidencia | Objetivo |
|---------|-----------|----------|
| 01 | Estructura inicial del laboratorio | Preparación del caso |
| 02 | Preservación de la evidencia | Copia del archivo original |
| 03 | Hash SHA-256 | Verificación de integridad |
| 04 | Reconocimiento de la evidencia | Inspección inicial del archivo |
| 05 | Servicio SSH activo | Preparación del servidor |
| 06 | Puerto TCP/22 en escucha | Validación del servicio |
| 07 | Primer evento SSH | Inicio del incidente |
| 08 | Usuario inexistente | Enumeración de usuarios |
| 09 | Usuario válido con contraseña incorrecta | Intento de autenticación fallido |
| 10 | Autenticación SSH exitosa | Confirmación del acceso |

---

# 🧾 Cadena de Custodia

Durante el laboratorio se aplicó un procedimiento básico de preservación de evidencia.

Las acciones realizadas incluyen:

- Copia de la evidencia original.
- Conservación del archivo original.
- Cálculo del hash SHA-256.
- Registro de comandos utilizados.
- Documentación de la adquisición.

---

# 🚩 Indicadores de Compromiso (IOC)

Durante el análisis del incidente se identificaron los siguientes Indicadores de Compromiso (IOC):

- Dirección IP de origen.
- Usuario inexistente utilizado durante la simulación.
- Usuario válido objetivo.
- Servicio OpenSSH.
- Eventos "Failed password".
- Evento "Accepted password".

---

# 🎓 Competencias desarrolladas

Durante este laboratorio se aplicaron conocimientos relacionados con:

- Preservación de evidencia digital.
- Cadena de custodia.
- Cálculo y validación de hashes SHA-256.
- Investigación de registros de autenticación Linux.
- Identificación de Indicadores de Compromiso (IOC).
- Reconstrucción de líneas temporales.
- Documentación técnica de incidentes.
- Análisis del comportamiento de OpenSSH.
- Análisis e interpretación de registros de OpenSSH.

---

# 📅 Timeline

La línea temporal reconstruye cronológicamente la evolución del incidente desde la preparación del servidor hasta la autenticación exitosa.

---

# 🔎 Hallazgos principales

Durante la investigación se identificó:

- Reconocimiento inicial de la evidencia.
- Ausencia inicial de eventos SSH.
- Activación del servicio OpenSSH.
- Intento con usuario inexistente.
- Diferencia entre "Invalid user" y "Failed password".
- Compresión de eventos mediante "message repeated".
- Autenticación SSH exitosa.

---

# 📚 Lecciones aprendidas

Este laboratorio permitió comprender que:

- La evidencia siempre debe preservarse antes de ser analizada.
- El hash SHA-256 garantiza la integridad del archivo.
- OpenSSH registra de forma distinta usuarios inexistentes y usuarios válidos.
- La correlación de eventos permite reconstruir un incidente completo.
- La documentación es tan importante como el análisis técnico.

---

# 🏁 Conclusión

El CASO-012 permitió diseñar, ejecutar y documentar un incidente controlado de autenticación SSH siguiendo una metodología de Digital Forensics and Incident Response (DFIR).

La investigación abarcó todas las etapas fundamentales de un análisis forense moderno: preparación del entorno, generación del incidente, preservación de evidencias, verificación de integridad, identificación de indicadores de compromiso, reconstrucción cronológica de los eventos y documentación técnica de los hallazgos.

Más allá del análisis del servicio OpenSSH, este laboratorio demuestra la importancia de aplicar una metodología estructurada para garantizar la trazabilidad, reproducibilidad y calidad de una investigación forense.

---

# ⚖️ Consideraciones éticas

Este laboratorio fue realizado exclusivamente con fines educativos sobre infraestructura propia y en un entorno controlado.

Todos los intentos de autenticación, generación de evidencias y análisis fueron ejecutados sin afectar sistemas de terceros ni servicios públicos.

El objetivo del caso es fortalecer conocimientos relacionados con Digital Forensics and Incident Response (DFIR), investigación de incidentes y buenas prácticas de documentación técnica.

# 👨‍💻 Autor

**Rodrigo Gatica**

Repositorio orientado al desarrollo de competencias en Blue Team, DFIR y Respuesta ante Incidentes mediante laboratorios reproducibles y documentación técnica.


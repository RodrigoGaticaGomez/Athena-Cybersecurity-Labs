# CASO-008 — Monitoreo de Integridad del Sistema con AIDE (Athena Guard)

**Fecha de análisis:** 15 de julio de 2026  
**Estado del caso:** Completado  
**Clasificación:** Blue Team / File Integrity Monitoring (FIM)

---

# Resumen

En este laboratorio se implementó un sistema de monitoreo de integridad utilizando **AIDE (Advanced Intrusion Detection Environment)** sobre Ubuntu 24.04 LTS.

El objetivo fue construir una línea base criptográfica del sistema y verificar posteriormente que los archivos críticos permanezcan sin modificaciones no autorizadas.

Como complemento se desarrolló **Athena Guard v0.1**, un script propio de Athena Labs encargado de automatizar las verificaciones de integridad y presentar los resultados de forma clara para futuras integraciones con plataformas SIEM.

---

# Objetivos

- Comprender el funcionamiento de un sistema FIM.
- Implementar AIDE sobre Ubuntu.
- Construir una base de integridad inicial.
- Automatizar las verificaciones mediante Athena Guard.
- Validar que el sistema no presente modificaciones inesperadas.
- Documentar el procedimiento como laboratorio reproducible.

---

# Tecnologías utilizadas

| Herramienta | Función |
|------------|----------|
| Ubuntu 24.04 LTS | Sistema operativo |
| AIDE | Monitoreo de integridad |
| SHA-256 | Verificación criptográfica |
| Bash | Automatización |
| Athena Guard | Script de monitoreo desarrollado para Athena Labs |

---

# ¿Qué es AIDE?

AIDE (Advanced Intrusion Detection Environment) es una herramienta de código abierto utilizada para detectar modificaciones en archivos críticos del sistema.

Su funcionamiento consiste en:

1. Construir una base de datos con el estado inicial del sistema.
2. Calcular múltiples hashes criptográficos.
3. Comparar futuras ejecuciones contra esa línea base.
4. Detectar archivos agregados, eliminados o modificados.

Este tipo de solución corresponde a la categoría **File Integrity Monitoring (FIM)**, ampliamente utilizada en entornos corporativos para detectar compromisos o alteraciones no autorizadas.

---

# Arquitectura del laboratorio

```

```
                Ubuntu 24.04 LTS
                       │
             ┌─────────┴─────────┐
             │                   │
          Athena Guard        AIDE
             │                   │
             └─────────┬─────────┘
                       │
            Base de Integridad
                       │
                       ▼
           Comparación del Sistema
                       │
             Cambios detectados
                       │
          Reporte para el Analista
```

```markdown

---

# Construcción de la línea base

Se inicializó la base de datos de AIDE mediante:

```bash
sudo aide --init
```

Una vez generada:

```bash
sudo cp /var/lib/aide/athena-labs.db.new \
        /var/lib/aide/athena-labs.db
```

A partir de este momento la base de datos representa el estado conocido como seguro del laboratorio.

---

# Athena Guard v0.1

Como complemento se desarrolló **Athena Guard**, un script encargado de ejecutar automáticamente las verificaciones de integridad.

Funciones actuales:

- Ejecutar comprobaciones AIDE.
- Mostrar información del sistema.
- Informar fecha y hora del análisis.
- Mostrar el estado de integridad.
- Facilitar futuras integraciones con SIEM.

Ejemplo de ejecución:

```bash
./scripts/athena-integrity-check.sh
```

Salida obtenida:

```
=================================================
              ATHENA GUARD v0.1
=================================================

Verificando integridad de Athena Labs...

AIDE found NO differences between database and filesystem.

Looks okay!!
```

El resultado confirma que no existen modificaciones respecto de la línea base registrada.

---

# Flujo de funcionamiento

```

```
Sistema

      │

      ▼

Construcción de Línea Base

      │

      ▼

Athena Guard

      │

      ▼

Ejecución de AIDE

      │

      ▼

Comparación

      │

 ┌────┴─────┐
 │          │

Sin cambios   Cambios detectados

 │          │

 ▼          ▼

Sistema      Alerta
Íntegro      de Integridad
```

```markdown

---

# Evidencias

## Inicialización de la base

- Generación de la base de datos.
- Registro de hashes.
- Creación del archivo principal.

---

## Primera verificación

Resultado:

```
AIDE found NO differences between database and filesystem.
```

Estado del laboratorio:

✅ Integridad verificada.

---

## Athena Guard

El script personalizado ejecutó correctamente la verificación mostrando:

- Fecha
- Host
- Estado
- Resultado del análisis

---

# Resultados

Se logró:

- Implementar correctamente un sistema FIM.
- Construir una línea base confiable.
- Automatizar las verificaciones.
- Validar la integridad del laboratorio.
- Incorporar Athena Guard como herramienta propia.

No se detectaron modificaciones no autorizadas durante las pruebas.

---

# MITRE ATT&CK

Este laboratorio contribuye principalmente a la fase de:

| Técnica | Descripción |
|----------|-------------|
| TA0005 | Defense Evasion |
| TA0009 | Collection |
| TA0007 | Discovery |

Aunque AIDE no bloquea ataques, permite detectar modificaciones posteriores que pueden evidenciar compromiso del sistema.

---

# Hardening aplicado

- Base de integridad protegida.
- Hashes criptográficos.
- Automatización de verificaciones.
- Separación entre base y sistema monitoreado.
- Ejecución mediante privilegios administrativos.

---

# Aprendizajes

Durante este laboratorio se reforzaron conocimientos sobre:

- File Integrity Monitoring.
- Hashes criptográficos.
- Automatización mediante Bash.
- Gestión de líneas base.
- Monitoreo defensivo.
- Hardening de sistemas Linux.

---

# Futuras mejoras

- Integración con Splunk.
- Integración con Wazuh.
- Integración con Elastic.
- Alertas por correo.
- Programación mediante systemd timers.
- Reportes automáticos.
- Dashboard para Athena Guard.
- Integración con Athena Local.

---

# Conclusiones

La implementación de AIDE permitió incorporar una capacidad esencial dentro de la estrategia defensiva de Athena Labs: la verificación periódica de la integridad del sistema.

Además del uso de una herramienta ampliamente reconocida en entornos Linux, este laboratorio marcó el nacimiento de **Athena Guard**, un componente desarrollado como parte del proyecto que automatiza las verificaciones y sienta las bases para futuras integraciones con plataformas de monitoreo y respuesta.

Este caso demuestra cómo un mecanismo de File Integrity Monitoring puede incorporarse dentro de una arquitectura Blue Team para detectar modificaciones no autorizadas, fortalecer el hardening del sistema y aumentar la visibilidad sobre posibles compromisos.

Athena Guard representa el primer paso hacia una plataforma de monitoreo defensivo construida progresivamente dentro de Athena Labs.

---

**Proyecto:** Athena Labs

*"Aprender, construir y compartir conocimiento en ciberseguridad mediante laboratorios reproducibles."*

---

**Athena Labs**


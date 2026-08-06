# CASO-010 — Integración de Athena Guard con Splunk Enterprise

![Estado](https://img.shields.io/badge/Estado-Completado-success)
![Sistema](https://img.shields.io/badge/Ubuntu-24.04-E95420?logo=ubuntu)
![SIEM](https://img.shields.io/badge/Splunk-Enterprise-000000?logo=splunk)
![Categoría](https://img.shields.io/badge/Categoría-SIEM-blue)

---

# Descripción

En este laboratorio se integró **Athena Guard** con **Splunk Enterprise**, permitiendo centralizar y analizar los eventos de integridad generados por AIDE mediante un SIEM profesional.

El objetivo principal fue validar el flujo completo desde la detección de cambios en el sistema de archivos hasta su análisis mediante consultas SPL, utilizando un índice dedicado para Athena Labs.

Este laboratorio representa el primer paso hacia la construcción de un entorno SIEM completamente funcional dentro del proyecto.

---

# Objetivos

- Instalar Splunk Enterprise sobre Ubuntu 24.04.
- Configurar el servicio correctamente.
- Crear un índice exclusivo para Athena Labs.
- Importar eventos generados por Athena Guard.
- Configurar el sourcetype JSON.
- Verificar la extracción automática de campos.
- Ejecutar consultas SPL.
- Obtener estadísticas sobre los eventos almacenados.

---

# Arquitectura del laboratorio

```text
                     +----------------------+
                     |        AIDE          |
                     | Detecta cambios      |
                     +----------+-----------+
                                |
                                v
                     +----------------------+
                     |    Athena Guard      |
                     | Conversión a JSON    |
                     +----------+-----------+
                                |
                                v
                  athena-guard-events.jsonl
                                |
                                v
                     +----------------------+
                     |  Splunk Enterprise   |
                     |    Índice: athena    |
                     +----------+-----------+
                                |
                                v
                  Consultas SPL • Estadísticas
                       Dashboards • Alertas
```

---

# Entorno

| Componente | Versión |
|------------|----------|
| Ubuntu | 24.04 LTS |
| Splunk Enterprise | 10.4.1 |
| Athena Guard | v0.1 |
| AIDE | 0.18.6 |

---

# Instalación de Splunk Enterprise

Se descargó e instaló Splunk Enterprise sobre Ubuntu.

Durante la configuración inicial se creó el usuario administrador:

```text
athena-admin
```

Posteriormente se verificó el correcto funcionamiento del servicio accediendo mediante:

```
http://localhost:8000
```

---

# Creación del índice

Se creó un índice dedicado denominado:

```text
athena
```

Este índice permite mantener separados los eventos propios de Athena Labs del resto de la plataforma.

---

# Importación de eventos

Se importó el archivo:

```text
logs/athena-guard-events.jsonl
```

Configuración utilizada:

| Parámetro | Valor |
|-----------|-------|
| Index | athena |
| Source Type | _json |
| Host | athena-workstation |

Splunk detectó automáticamente el formato JSON y extrajo correctamente todos los campos.

---

# Campos extraídos automáticamente

Entre los campos reconocidos por Splunk se encuentran:

- description
- event
- host
- path
- severity
- source
- timestamp
- tool

La correcta extracción de estos campos permitió realizar consultas SPL sin necesidad de configuraciones adicionales.

---

# Consultas SPL utilizadas

## Todos los eventos

```spl
index=athena
```

---

## Eventos de severidad alta

```spl
index=athena severity=high
```

---

## Eventos generados por AIDE

```spl
index=athena tool=AIDE
```

---

## Conteo por severidad

```spl
index=athena
| stats count by severity
```

Resultado obtenido:

| Severity | Eventos |
|-----------|---------:|
| high | 2 |

---

## Conteo por herramienta

```spl
index=athena
| stats count by tool
```

Resultado obtenido:

| Herramienta | Eventos |
|------------|---------:|
| AIDE | 2 |

---

# Evidencias

```
capturas/
├── 01_splunk_login.png
├── 02_creacion_indice_athena.png
├── 03_importacion_json.png
├── 04_index_athena.png
├── 05_busqueda_severity_high.png
├── 06_stats_severity.png
└── 07_stats_tool.png
```

---

# Resultados

Se verificó exitosamente:

- ✔ Instalación de Splunk Enterprise.
- ✔ Configuración del usuario administrador.
- ✔ Creación del índice **athena**.
- ✔ Importación de eventos JSON.
- ✔ Extracción automática de campos.
- ✔ Consultas SPL exitosas.
- ✔ Estadísticas mediante **stats**.
- ✔ Integración funcional entre Athena Guard y Splunk Enterprise.

---

# Aprendizajes

Este laboratorio permitió comprender el flujo completo de integración entre una herramienta desarrollada dentro de Athena Labs y un SIEM profesional.

Se comprobó que una estructura JSON correctamente diseñada facilita significativamente la indexación y el análisis de eventos, permitiendo a Splunk reconocer automáticamente los campos relevantes sin necesidad de configuraciones adicionales.

Asimismo, se reforzaron conceptos fundamentales relacionados con:

- SIEM
- Ingesta de eventos
- Índices
- Sourcetypes
- SPL (Search Processing Language)
- Extracción automática de campos

---

# Conclusiones

La integración fue completamente exitosa.

Athena Guard fue capaz de generar eventos estructurados que Splunk Enterprise interpretó correctamente, permitiendo realizar búsquedas, filtros y estadísticas mediante SPL.

Este laboratorio constituye la base sobre la cual se desarrollarán futuras capacidades de monitoreo, dashboards, alertas automáticas y correlación de eventos dentro de Athena Labs.

---

# Próximos pasos

- Dashboards personalizados.
- Alertas automáticas.
- Monitoreo continuo del archivo JSON.
- Correlación de eventos.
- Integración con nuevas fuentes de datos.
- Visualización avanzada mediante paneles.

---

# 🏆 Hito de Athena Labs

> **Primer laboratorio de integración con un SIEM profesional.**

Con este laboratorio, Athena Labs alcanza un nuevo nivel de madurez técnica.

Por primera vez, un evento generado por una herramienta desarrollada dentro del proyecto (Athena Guard) fue ingerido, indexado y analizado exitosamente por Splunk Enterprise mediante consultas SPL.

Este hito marca el inicio de la etapa SIEM de Athena Labs y establece las bases para futuros laboratorios de monitoreo continuo, dashboards, correlación de eventos y alertas automatizadas.

---


# 📜 Registro histórico de Athena Labs

**Fecha:** 17 de julio de 2026

**Hito alcanzado:**

Primer laboratorio donde Athena Guard se integra exitosamente con Splunk Enterprise mediante eventos JSON y consultas SPL.

# Autor

**Rodrigo Gatica Gómez**

Proyecto desarrollado como parte de **Athena Labs**, plataforma de investigación orientada al aprendizaje práctico, documentación reproducible y construcción de laboratorios profesionales de ciberseguridad.

---

*"La mejor forma de aprender ciberseguridad es construirla."*

**Athena Labs**

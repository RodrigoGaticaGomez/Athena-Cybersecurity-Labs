# CASO-013 — Correlación de Eventos SIEM con Athena Guard

## 1. Resumen ejecutivo

En este laboratorio se diseñó e implementó un motor básico de correlación de eventos para Athena Guard.

El sistema analiza una secuencia de eventos de seguridad almacenados en formato JSONL y determina si estos representan un posible compromiso mediante SSH.

La secuencia evaluada incluye:

- Escaneo de puertos.
- Múltiples intentos fallidos de autenticación SSH.
- Inicio de sesión SSH exitoso.
- Coincidencia de IP de origen y destino.
- Cumplimiento de una ventana temporal definida.

Como resultado, Athena Guard generó una alerta crítica de tipo `possible_ssh_compromise` y almacenó el incidente detectado en formato JSON.

## 2. Objetivo general

Implementar una prueba de concepto de correlación de eventos capaz de transformar múltiples alertas individuales en un incidente de seguridad contextualizado.

## 3. Objetivos específicos

- Procesar eventos de seguridad en formato JSONL.
- Ordenar los eventos cronológicamente.
- Correlacionar eventos por IP de origen y destino.
- Detectar tres o más intentos fallidos de acceso SSH.
- Identificar un inicio de sesión exitoso posterior.
- Aplicar una ventana temporal de correlación.
- Generar un incidente de severidad crítica.
- Guardar los resultados en formato JSON.
- Registrar evidencia de la ejecución del motor.

## Tecnologías utilizadas

- Ubuntu 24.04 LTS
- Python 3
- Visual Studio Code
- JSON
- JSONL
- Git
- GitHub


## Arquitectura del laboratorio

```text
logs/eventos_prueba.jsonl
            │
            ▼
    Correlation Engine
            │
            ▼
    Reglas de correlación
            │
            ▼
Incidente de seguridad
            │
            ▼
resultados/incidentes_detectados.json


## 4. Escenario simulado

Un atacante con dirección IP `192.168.1.150` realiza un escaneo de puertos contra el servidor `192.168.1.10`.

Posteriormente, la misma dirección IP ejecuta tres intentos fallidos de autenticación SSH utilizando distintos nombres de usuario.

Finalmente, se registra un inicio de sesión exitoso con el usuario `rodrigo`.

Athena Guard correlaciona los eventos y genera una alerta crítica al determinar que toda la secuencia ocurrió dentro de una ventana de 300 segundos.

## 5. Regla de correlación

La alerta se genera cuando se cumplen las siguientes condiciones:

1. Existe un evento `port_scan`.
2. Se detectan al menos tres eventos `ssh_failed_login`.
3. Se registra posteriormente un evento `ssh_successful_login`.
4. Todos los eventos poseen la misma IP de origen.
5. Todos los eventos poseen la misma IP de destino.
6. La secuencia completa ocurre dentro de una ventana de 300 segundos.

## 6. Resultado obtenido

Athena Guard procesó cinco eventos y generó un incidente con las siguientes características:

- Tipo: `possible_ssh_compromise`
- Severidad: `critical`
- IP de origen: `192.168.1.150`
- IP de destino: `192.168.1.10`
- Intentos SSH fallidos: `3`
- Usuario afectado: `rodrigo`
- Ventana temporal observada: `122 segundos`
- Estado: `detected`

## 7. Archivos generados

- `logs/eventos_prueba.jsonl`
- `scripts/correlation_engine.py`
- `resultados/incidentes_detectados.json`
- `evidencias/ejecucion_motor_correlacion.txt`

## Evidencias

Las evidencias gráficas del laboratorio se encuentran en la carpeta:

evidencias/

- EVIDENCIA-01-Estructura-Proyecto.png
- EVIDENCIA-02-Ejecucion-Correlation-Engine.png
- EVIDENCIA-03-Incidente-Generado-JSON.png
- EVIDENCIA-04-Codigo-Correlation-Engine.png
- EVIDENCIA-05-Documentacion.png
- EVIDENCIA-06-Estructura-VSCode.png

## 8. Conclusión

El laboratorio permitió comprobar que Athena Guard puede analizar múltiples eventos relacionados y transformarlos en un único incidente de seguridad con mayor contexto.

Esta capacidad representa una evolución importante respecto de la detección individual de alertas, ya que introduce conceptos propios de un SIEM, como correlación temporal, agrupación por activos y generación de incidentes priorizados.

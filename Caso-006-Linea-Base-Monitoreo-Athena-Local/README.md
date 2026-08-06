# CASO-006 — Línea Base y Monitoreo de Athena Local

**Fecha de análisis:** 12 de julio de 2026  
**Estado del caso:** Completado

## Resumen

Se realizó una recolección de línea base sobre Athena Local en Ubuntu, incluyendo hardware, sistema operativo, servicios, contenedores, puertos, consumo de recursos y registros operativos.

## Objetivo

Documentar el comportamiento normal de Athena Local para facilitar futuras tareas de monitoreo, detección de anomalías, diagnóstico y respuesta a incidentes.

## Entorno

- Host: athena-workstation
- Sistema operativo: Ubuntu 24.04.4 LTS
- Kernel: Linux 6.17
- CPU: AMD Ryzen 7 2700 — 8 núcleos y 16 hilos
- RAM: 20 GB DDR4 2666 MT/s (16 GB + 4 GB)
- GPU: NVIDIA GeForce RTX 4060 8 GB
- Ollama: 0.31.2
- Open WebUI: v0.10.1
- Docker: contenedor open-webui

## Metodología

La evidencia fue recopilada directamente desde la terminal mediante comandos reproducibles y almacenada en archivos de texto con `tee`. Se eliminaron identificadores únicos antes de incorporar la evidencia al repositorio.

## Hallazgos

### Estado operativo

- Ollama se encuentra habilitado y activo.
- Open WebUI se encuentra en estado `healthy`.
- El contenedor presenta cero reinicios.
- Los modelos `athena:latest` y `llama3.1:8b` están disponibles.
- Ollama detecta y utiliza la RTX 4060 mediante CUDA.

### Línea base de recursos

- Carga promedio del sistema inferior a 1.
- CPU entre 96 % y 99 % inactiva durante el muestreo.
- Aproximadamente 14 GiB de memoria disponibles.
- Partición raíz con 10 % de utilización.
- GPU a aproximadamente 40 °C en reposo.
- Open WebUI utiliza aproximadamente 1,5 GiB de RAM.

### Red

- Open WebUI está publicado únicamente en `127.0.0.1:3000`.
- Ollama escucha en el puerto TCP 11434 sobre todas las interfaces.
- UFW está activo con política predeterminada de bloqueo entrante.
- UFW permite el acceso a Ollama desde la interfaz Docker para la comunicación con Open WebUI.

### Registros

- Ollama no presentó advertencias ni errores.
- Open WebUI presentó advertencias no críticas relacionadas con CORS, dependencias, Hugging Face, migración de base de datos y límites del modelo de embeddings.
- No se observaron reinicios ni fallos críticos.

## Evaluación

Athena Local opera de forma estable, con amplio margen de CPU, RAM, almacenamiento y GPU. La exposición de Ollama debe mantenerse bajo control mediante UFW. Las advertencias de Open WebUI deberán revisarse en futuras actualizaciones y pruebas de indexación documental.

## Evidencias

- `Evidencias/01-Sistema/inventario-sistema.txt`
- `Evidencias/01-Sistema/gpu-memoria.txt`
- `Evidencias/02-Servicios/estado-servicios.txt`
- `Evidencias/03-Red/puertos-exposicion.txt`
- `Evidencias/04-Recursos/linea-base-recursos.txt`
- `Evidencias/05-Logs/revision-logs.txt`
- `Evidencias/06-Capturas/`

## Conclusión

Se estableció una línea base verificable del funcionamiento normal de Athena Local. Esta información permitirá comparar estados futuros, detectar desviaciones y acelerar el diagnóstico de incidentes.

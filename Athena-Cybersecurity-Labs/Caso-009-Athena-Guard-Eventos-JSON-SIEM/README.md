# CASO-009 — Athena Guard: Generación de Eventos JSON para SIEM

**Fecha de análisis:** 15 de julio de 2026  
**Estado del caso:** Completado  
**Clasificación:** Blue Team / File Integrity Monitoring (FIM) / SIEM

---

# Resumen

En este laboratorio se desarrolló **Athena Guard JSON**, una evolución del sistema de monitoreo de integridad implementado en el CASO-008.

El objetivo fue transformar automáticamente el resultado de las verificaciones realizadas por **AIDE (Advanced Intrusion Detection Environment)** en eventos estructurados en formato **JSON Lines (JSONL)**, permitiendo su posterior ingestión por plataformas SIEM como Splunk, Elastic Security o Wazuh.

En lugar de depender únicamente de la salida textual de AIDE, Athena Guard genera eventos normalizados que contienen información suficiente para ser indexada, consultada y correlacionada automáticamente.

---

# Objetivos

- Automatizar la ejecución de verificaciones de integridad.
- Convertir los resultados de AIDE en eventos JSON.
- Generar registros compatibles con SIEM.
- Validar la sintaxis de los eventos.
- Comprender el impacto de los cambios legítimos sobre los sistemas FIM.

---

# Tecnologías utilizadas

- Ubuntu 24.04 LTS
- Bash
- AIDE 0.18.6
- jq
- JSON Lines (JSONL)

---

# Arquitectura del laboratorio

```
Cambio de archivos
        │
        ▼
      AIDE
        │
        ▼
Athena Guard JSON
        │
        ▼
Eventos JSONL
        │
        ▼
SIEM
(Splunk / Elastic / Wazuh)
```

---

# Estructura del laboratorio

```
Caso-009-Athena-Guard-Eventos-JSON-SIEM/

├── capturas/
├── configuracion/
├── evidencias/
├── logs/
│   └── athena-guard-events.jsonl
├── pruebas/
└── scripts/
    └── athena-guard-json.sh
```

---

# Funcionamiento

El script ejecuta automáticamente:

1. Verificación de la existencia del archivo de configuración.
2. Ejecución de AIDE.
3. Captura del resultado.
4. Interpretación del estado.
5. Generación de un evento JSON estructurado.
6. Almacenamiento en formato JSONL.

Cada ejecución produce un evento independiente.

Ejemplo:

```json
{
  "timestamp": "2026-07-15T14:06:26-04:00",
  "host": "athena-workstation",
  "tool": "AIDE",
  "source": "athena-guard",
  "severity": "high",
  "event": "integrity_changes_detected",
  "path": "...",
  "description": "AIDE detectó cambios de integridad"
}
```

---

# Validación

Durante las pruebas se comprobó que:

- El script Bash posee sintaxis válida.
- Los eventos JSON generados son válidos.
- Los registros pueden almacenarse en formato JSONL.
- Cada ejecución genera un nuevo evento independiente.

---

# Observaciones técnicas

Durante la ejecución del laboratorio AIDE detectó un número elevado de modificaciones.

Lejos de representar un fallo del laboratorio, el comportamiento corresponde a la evolución normal del repositorio Git utilizado para Athena Labs.

Los cambios detectados incluyen:

- nuevos objetos Git;
- modificaciones del índice;
- incorporación del CASO-009;
- generación de nuevas evidencias.

Esto demuestra una característica importante de los sistemas **File Integrity Monitoring**:

> Un alcance demasiado amplio produce una gran cantidad de eventos legítimos.

Este fenómeno incrementa el ruido operacional y puede dificultar el análisis si no se aplican reglas de exclusión adecuadas.

---

# Aprendizajes

Este laboratorio permitió comprender que:

- detectar cambios no es suficiente;
- es necesario estructurar los eventos;
- los SIEM requieren información normalizada;
- el monitoreo de integridad debe minimizar falsos positivos;
- la calidad de las reglas es tan importante como la herramienta utilizada.

---

# Posibles mejoras

Como evolución natural del laboratorio se propone:

- excluir directorios dinámicos (.git, logs, evidencias);
- reducir falsos positivos;
- enriquecer los eventos con hashes;
- incorporar MITRE ATT&CK;
- enviar los eventos directamente mediante Syslog o HTTP Event Collector.

---

# Conclusión

Athena Guard JSON permitió convertir la salida tradicional de AIDE en eventos estructurados compatibles con plataformas SIEM.

El laboratorio demostró que la generación de eventos constituye únicamente una parte del proceso de monitoreo, siendo igualmente importante definir correctamente el alcance de la supervisión para evitar ruido operacional y mejorar la capacidad de detección.

---

# Autor

**Rodrigo Gatica Gómez**

Proyecto desarrollado para **Athena Labs**

Julio 2026


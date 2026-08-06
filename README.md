<div align="center">

# 🪖 Athena Cybersecurity Labs

### Laboratorios prácticos de ciberseguridad, detección, monitoreo y análisis defensivo

![Estado](https://img.shields.io/badge/estado-en%20desarrollo-00bfa5)
![Casos](https://img.shields.io/badge/casos%20documentados-10-2563eb)
![Enfoque](https://img.shields.io/badge/enfoque-Blue%20Team-1d4ed8)
![Plataforma](https://img.shields.io/badge/plataforma-Ubuntu%20%7C%20Windows-eab308)
![Uso](https://img.shields.io/badge/uso-educativo-64748b)

</div>

---

## Sobre Athena Labs

**Athena Cybersecurity Labs** es un proyecto personal de aprendizaje, experimentación y documentación técnica orientado a la ciberseguridad defensiva.

El repositorio reúne laboratorios construidos en entornos controlados para practicar:

- monitoreo de endpoints;
- análisis de registros;
- detección de amenazas;
- análisis de phishing;
- seguridad de redes;
- monitoreo de integridad;
- automatización;
- integración con plataformas SIEM.

Cada caso documenta sus objetivos, entorno, herramientas, procedimiento, evidencias, resultados y aprendizajes.

---

## Casos documentados

| Caso | Laboratorio | Área principal |
|---:|---|---|
| 001 | [Detección de conexión SMB con Sysmon](Caso-001-Deteccion-Conexion-SMB-Sysmon/) | Endpoint Monitoring |
| 002 | [Reconocimiento de red doméstica](Caso-002-Reconocimiento-Red-Domestica/) | Network Discovery |
| 003 | [Análisis de phishing e IOC](Caso-003-Analisis-Phishing-IOC/) | Phishing Analysis |
| 004 | [Detección de escaneo con Suricata](Caso-004-Deteccion-Escaneo-Puertos-Suricata/) | Network IDS |
| 005 | [Detección de ataques web en Nginx](Caso-005-Deteccion-Ataques-Web-Nginx/) | Web Security |
| 006 | [Línea base de Athena Local](Caso-006-Linea-Base-Monitoreo-Athena-Local/) | System Monitoring |
| 007 | [Detección de fuerza bruta SSH](Caso-007-Deteccion-Fuerza-Bruta-SSH/) | Authentication Security |
| 008 | [Monitoreo de integridad con AIDE](Caso-008-Monitoreo-Integridad-AIDE/) | File Integrity |
| 009 | [Eventos JSON para SIEM](Caso-009-Athena-Guard-Eventos-JSON-SIEM/) | Log Normalization |
| 010 | [Integración de Athena Guard con Splunk](Caso-010-Integracion-Athena-Guard-Splunk/) | SIEM Integration |

---

## Tecnologías y herramientas

- Linux, Windows y Kali Linux
- Ubuntu y VirtualBox
- Docker
- Nmap
- Sysmon
- Suricata
- Nginx
- AIDE
- Fail2ban
- Hydra
- YARA y ClamAV
- Splunk
- Bash
- JSON y JSONL
- Git y GitHub

---

## Metodología

Los laboratorios siguen una metodología general:

1. Definición del objetivo.
2. Preparación del entorno controlado.
3. Generación de actividad legítima o simulada.
4. Recolección de registros y evidencias.
5. Detección y análisis.
6. Aplicación de medidas defensivas.
7. Validación de resultados.
8. Preservación documental.

Todas las pruebas se realizan exclusivamente en sistemas propios, redes autorizadas o entornos de laboratorio.

---

## Estructura del repositorio

```text
Athena-Cybersecurity-Labs/
├── Caso-001-Deteccion-Conexion-SMB-Sysmon/
├── Caso-002-Reconocimiento-Red-Domestica/
├── Caso-003-Analisis-Phishing-IOC/
├── Caso-004-Deteccion-Escaneo-Puertos-Suricata/
├── Caso-005-Deteccion-Ataques-Web-Nginx/
├── Caso-006-Linea-Base-Monitoreo-Athena-Local/
├── Caso-007-Deteccion-Fuerza-Bruta-SSH/
├── Caso-008-Monitoreo-Integridad-AIDE/
├── Caso-009-Athena-Guard-Eventos-JSON-SIEM/
├── Caso-010-Integracion-Athena-Guard-Splunk/
├── ATHENA_LABS_BASE_DE_CONOCIMIENTO.md
└── README.md

# CASO-001 — Detección de Conexión SMB con Sysmon

**Fecha del laboratorio:** 5 de julio de 2026  
**Estado:** Completado  
**Clasificación:** Blue Team / Monitoreo de endpoints  
**Proyecto:** Athena Labs

## Resumen ejecutivo

Se construyó un laboratorio aislado en VirtualBox para generar y detectar una conexión de red dirigida al servicio SMB de un equipo Windows 10.

Desde una máquina Kali Linux se comprobó la conectividad con el objetivo y se realizó un escaneo mediante Nmap sobre el puerto TCP/445. En el endpoint Windows, Sysmon registró la actividad como un evento de conexión de red correspondiente al Event ID 3.

El laboratorio permitió validar una secuencia básica de generación, observación y documentación de actividad potencialmente relevante para un analista SOC.

## Objetivos

- Construir un entorno controlado con Kali Linux y Windows 10.
- Comprobar la comunicación entre ambas máquinas.
- Examinar la exposición del servicio SMB sobre TCP/445.
- Generar una conexión de prueba mediante Nmap.
- Detectar la actividad utilizando Sysmon.
- Preservar evidencias de cada etapa del procedimiento.

## Arquitectura del laboratorio

| Componente | Función | Dirección IP |
|---|---|---:|
| Kali Linux | Generación y análisis de actividad | `10.10.10.10` |
| Windows 10 | Endpoint monitoreado | `10.10.10.20` |
| VirtualBox | Plataforma de virtualización | No aplica |
| Red interna | Segmento aislado del laboratorio | `10.10.10.0/24` |

El entorno fue diseñado para que las pruebas se ejecutaran de forma controlada y sin afectar sistemas externos.

## Herramientas utilizadas

- VirtualBox
- Kali Linux
- Windows 10
- Nmap
- Sysmon
- Firewall de Windows
- Visor de eventos de Windows

## Procedimiento

### 1. Preparación del entorno

Se desplegaron las máquinas virtuales Kali Linux y Windows 10 dentro del laboratorio de Athena Labs.

La máquina Kali actuó como origen de la actividad, mientras que Windows 10 funcionó como endpoint objetivo y sistema de monitoreo.

### 2. Comprobación de conectividad

Desde Kali Linux se verificó la comunicación con el equipo Windows antes de realizar el escaneo.

Esta comprobación permitió confirmar que ambas máquinas se encontraban correctamente configuradas dentro del segmento de laboratorio.

### 3. Escaneo del servicio SMB

Se utilizó Nmap para comprobar el estado del puerto TCP/445 del equipo Windows:

```bash
nmap -p 445 10.10.10.20
```

El objetivo fue generar una conexión controlada hacia SMB que pudiera ser observada posteriormente en los registros del endpoint.

4. Configuración del endpoint

En Windows se comprobó la configuración relacionada con SMB y las reglas correspondientes del Firewall de Windows.

Esto permitió que el endpoint recibiera la conexión generada desde Kali dentro del entorno controlado.

5. Detección mediante Sysmon

Sysmon registró la actividad de red mediante el Event ID 3.

Este tipo de evento documenta conexiones de red observadas en el endpoint y puede incluir información como:

Proceso asociado.
Dirección IP de origen.
Dirección IP de destino.
Puerto de origen.
Puerto de destino.
Protocolo utilizado.
Fecha y hora del evento.

La evidencia obtenida permitió relacionar la actividad generada desde Kali Linux con el registro producido en Windows.

Línea temporal
Etapa	Actividad
1	Despliegue del laboratorio en VirtualBox
2	Comprobación de la red desde Kali Linux
3	Escaneo del puerto TCP/445 mediante Nmap
4	Verificación de la configuración SMB en Windows
5	Identificación del Sysmon Event ID 3
Resultado

El laboratorio finalizó satisfactoriamente.

La conexión dirigida al puerto TCP/445 fue generada desde Kali Linux y observada en Windows mediante Sysmon. Esto demostró la utilidad de la telemetría del endpoint para investigar conexiones de red dentro de un flujo básico de monitoreo SOC.

La aparición de un Event ID 3 no demuestra por sí sola la existencia de un ataque. El evento debe correlacionarse con el proceso, las direcciones IP, los puertos, el contexto del activo y otros registros disponibles.

Evidencias
N.º	Evidencia	Descripción
1	01_Athena_Lab_VirtualBox.png	Entorno virtual del laboratorio Athena Labs
2	02_Kali_Network_OK.png	Comprobación de conectividad desde Kali Linux
3	03_Kali_Nmap_SMB445_Scan.png	Escaneo del puerto SMB TCP/445
4	04_Windows_Firewall_SMB445_Enabled.png	Configuración relacionada con SMB en Windows
5	05_SYSmon_EventID3_SMB445_DETECTED.png	Registro de la conexión mediante Sysmon Event ID 3

Las capturas se encuentran en el directorio:

Caso-001-Deteccion-Conexion-SMB-Sysmon/evidencias/
Competencias demostradas
Construcción de laboratorios virtualizados.
Configuración básica de redes aisladas.
Reconocimiento de servicios mediante Nmap.
Monitoreo de conexiones de red con Sysmon.
Análisis inicial de eventos de Windows.
Preservación y organización de evidencias.
Interpretación de telemetría desde una perspectiva Blue Team.
Lecciones aprendidas
La generación controlada de actividad permite validar las fuentes de telemetría.
Sysmon aporta visibilidad adicional sobre las conexiones realizadas por un endpoint.
Un evento aislado requiere contexto antes de ser clasificado como malicioso.
La documentación de cada etapa facilita la reproducción y revisión del laboratorio.
Las evidencias deben relacionarse con una secuencia técnica clara y verificable.
Conclusión

El CASO-001 estableció la primera práctica documentada de Athena Labs orientada a la detección y análisis de actividad de red.

La correlación entre el escaneo originado desde Kali Linux y el evento registrado por Sysmon permitió construir un flujo elemental de trabajo SOC: generar actividad, recopilar telemetría, analizar el evento y conservar evidencias.

Athena Labs
Laboratorios construidos con propósito, evidencia y aprendizaje continuo.

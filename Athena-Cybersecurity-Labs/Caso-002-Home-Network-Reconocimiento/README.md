# CASO-002 — Reconocimiento de Red Doméstica

**Fecha del laboratorio:** 5 de julio de 2026  
**Estado:** Completado con observación sobre evidencia duplicada  
**Clasificación:** Blue Team / Descubrimiento de activos  
**Proyecto:** Athena Labs

## Resumen ejecutivo

Se realizó un reconocimiento autorizado de la red doméstica `192.168.1.0/24` para identificar hosts activos, fabricantes asociados y servicios potencialmente expuestos.

Mediante Nmap se detectaron cuatro hosts activos. Posteriormente se efectuó una enumeración de servicios TCP sobre el router probable y un análisis de los 20 puertos UDP más comunes sobre un dispositivo identificado por su fabricante como Mega Well Limited.

El laboratorio permitió construir un inventario inicial de activos y documentar las limitaciones propias de la identificación basada en direcciones MAC y resultados `open|filtered`.

## Alcance y autorización

El análisis se realizó exclusivamente sobre la red doméstica propia y dentro de un entorno autorizado.

El objetivo fue educativo y defensivo:

- Identificar dispositivos conectados.
- Reconocer servicios visibles.
- Comprender la superficie de exposición local.
- Documentar hallazgos sin explotar vulnerabilidades.
- Mantener trazabilidad de las evidencias.

## Objetivos

- Descubrir hosts activos en la red `192.168.1.0/24`.
- Asociar fabricantes mediante direcciones MAC.
- Enumerar servicios del router probable.
- Examinar los puertos UDP más comunes del dispositivo Mega Well.
- Construir un inventario inicial de activos.
- Registrar limitaciones y anomalías de la evidencia.

## Herramientas utilizadas

- Kali Linux
- Nmap 7.99
- Descubrimiento de hosts mediante `-sn`
- Detección de servicios mediante `-sV`
- Detección de sistema operativo mediante `-O`
- Escaneo UDP mediante `-sU`
- Identificación de fabricantes mediante direcciones MAC

## Metodología

### 1. Descubrimiento de hosts

Se ejecutó el siguiente comando sobre la red doméstica:

`sudo nmap -sn 192.168.1.0/24`

Nmap examinó 256 direcciones y reportó cuatro hosts activos.

### 2. Enumeración del router probable

Se examinó el host `192.168.1.1` mediante:

`sudo nmap -sV -O 192.168.1.1`

La dirección, el fabricante Fiberhome y los servicios web detectados son compatibles con un router o gateway doméstico.

### 3. Enumeración UDP del dispositivo Mega Well

Se examinaron los 20 puertos UDP más comunes del host `192.168.1.2` mediante:

`sudo nmap -sU --top-ports 20 192.168.1.2`

Los resultados fueron clasificados como `open|filtered`. Este estado significa que Nmap no pudo determinar si el puerto estaba abierto o si un mecanismo de filtrado descartó las sondas.

No debe interpretarse como confirmación definitiva de que todos los servicios enumerados estén activos.

## Inventario de activos observados

| Dirección IP | Fabricante identificado | Clasificación |
|---|---|---|
| `192.168.1.1` | Fiberhome Telecommunication Technologies | Router o gateway probable |
| `192.168.1.2` | Mega Well Limited | Dispositivo de función no confirmada |
| `192.168.1.3` | Samsung Electronics | Dispositivo Samsung no enumerado |
| `192.168.1.6` | No identificado en la captura | Host activo no identificado |

La asociación con un fabricante se obtuvo mediante el prefijo de la dirección MAC. Esto no demuestra por sí solo el modelo, función, propietario ni nivel de seguridad del dispositivo.

## Resultados del router probable

El host `192.168.1.1` presentó:

| Puerto | Estado | Servicio | Identificación de Nmap |
|---:|---|---|---|
| `80/tcp` | Abierto | HTTP | Nginx como reverse proxy |
| `443/tcp` | Abierto | SSL/HTTP | Nginx como reverse proxy |

Nmap también realizó una estimación general de sistema operativo compatible con Linux, con detalles aproximados entre las versiones de kernel 3.10 y 4.11.

La detección de sistema operativo es una estimación y no constituye una identificación exacta.

## Resultados del dispositivo Mega Well

El host `192.168.1.2` presentó los siguientes resultados UDP:

| Puerto | Estado | Servicio sugerido por Nmap |
|---:|---|---|
| `53/udp` | `open|filtered` | domain |
| `67/udp` | `open|filtered` | dhcps |
| `68/udp` | `open|filtered` | dhcpc |
| `69/udp` | `open|filtered` | tftp |
| `123/udp` | `open|filtered` | ntp |
| `135/udp` | `open|filtered` | msrpc |
| `137/udp` | `open|filtered` | netbios-ns |
| `138/udp` | `open|filtered` | netbios-dgm |
| `139/udp` | `open|filtered` | netbios-ssn |
| `161/udp` | `open|filtered` | snmp |
| `162/udp` | `open|filtered` | snmptrap |
| `445/udp` | `open|filtered` | microsoft-ds |
| `500/udp` | `open|filtered` | isakmp |
| `514/udp` | `open|filtered` | syslog |
| `520/udp` | `open|filtered` | route |
| `631/udp` | `open|filtered` | ipp |
| `1434/udp` | `open|filtered` | ms-sql-m |
| `1900/udp` | `open|filtered` | upnp |
| `4500/udp` | `open|filtered` | nat-t-ike |
| `49152/udp` | `open|filtered` | unknown |

Estos nombres corresponden a asociaciones estándar de puertos utilizadas por Nmap. No confirman que cada aplicación esté realmente ejecutándose en el dispositivo.

## Hallazgos principales

### Hallazgo 1 — Servicios administrativos web visibles

El router probable expuso interfaces web mediante TCP/80 y TCP/443 dentro de la red local.

### Hallazgo 2 — Dispositivo Mega Well requiere identificación adicional

La evidencia permitió asociar `192.168.1.2` con Mega Well Limited, pero no confirmó el modelo ni su función específica.

### Hallazgo 3 — Resultados UDP no concluyentes

Los 20 puertos UDP aparecieron como `open|filtered`. Se requerirían pruebas adicionales y respuestas específicas de protocolo para confirmar servicios activos.

### Hallazgo 4 — Dispositivo Samsung descubierto, pero no enumerado

El host `192.168.1.3` fue asociado con Samsung Electronics durante el descubrimiento. No existe una captura válida que demuestre una enumeración de sus puertos o servicios.

### Hallazgo 5 — Host adicional no identificado

El host `192.168.1.6` respondió al descubrimiento, pero la evidencia disponible no permitió establecer fabricante, función o servicios.

## Anomalía documental

Los archivos siguientes tienen exactamente el mismo contenido y hash SHA-256:

- `03_MegaWell_Device_UDP_Enumeration_Nmap.png.png`
- `04_Samsung_Device_Enumeration_Nmap.png.png`

Hash compartido:

`3848498a92e6d5897c5966bc48a77fe820a9ae4257640e5b7d39f4f971a8c043`

La evidencia 04 está etiquetada como una enumeración del dispositivo Samsung, pero muestra nuevamente el análisis UDP de `192.168.1.2`, correspondiente a Mega Well.

Por integridad documental:

- No se afirma que el dispositivo Samsung haya sido enumerado.
- No se atribuyen los puertos UDP al host `192.168.1.3`.
- El duplicado se conserva como parte del registro histórico.
- La anomalía queda expresamente documentada.

## Evidencias

| N.º | Archivo | Descripción |
|---:|---|---|
| 1 | `01_Nmap_Host_Discovery.png.png` | Descubrimiento de cuatro hosts activos |
| 2 | `02_Router_Service_Enumeration_Nmap.png.png` | Enumeración TCP del router probable |
| 3 | `03_MegaWell_Device_UDP_Enumeration_Nmap.png.png` | Escaneo UDP del dispositivo Mega Well |
| 4 | `04_Samsung_Device_Enumeration_Nmap.png.png` | Duplicado exacto de la evidencia 03 |

## Recomendaciones defensivas

- Mantener actualizado el firmware del router y los dispositivos conectados.
- Utilizar credenciales administrativas robustas y únicas.
- Preferir HTTPS para la administración del router.
- Desactivar servicios de administración o descubrimiento que no sean necesarios.
- Separar dispositivos IoT en una red de invitados o VLAN cuando sea posible.
- Repetir el inventario periódicamente para detectar activos nuevos o desconocidos.
- Verificar manualmente la identidad del host `192.168.1.6`.
- Confirmar servicios UDP con técnicas específicas antes de clasificarlos como expuestos.

## Competencias demostradas

- Descubrimiento de activos de red.
- Enumeración básica de servicios TCP y UDP.
- Interpretación de fabricantes mediante direcciones MAC.
- Análisis prudente de resultados `open|filtered`.
- Construcción de inventarios tecnológicos.
- Revisión de integridad y trazabilidad de evidencias.
- Documentación técnica desde una perspectiva defensiva.

## Lecciones aprendidas

- El descubrimiento de hosts constituye el primer paso para conocer la superficie de una red.
- La identificación por fabricante no confirma el tipo exacto de dispositivo.
- Los resultados UDP requieren cautela y validación adicional.
- La detección de un puerto no equivale automáticamente a una vulnerabilidad.
- La integridad de las evidencias debe verificarse antes de redactar conclusiones.
- Una anomalía documental debe registrarse, no ocultarse.

## Conclusión

El CASO-002 permitió identificar cuatro hosts activos y construir una visión inicial de la red doméstica autorizada.

Se documentaron los servicios web del router probable, los resultados UDP no concluyentes del dispositivo Mega Well y las limitaciones de identificación de los demás activos.

La detección de una evidencia duplicada reforzó un principio central de Athena Labs: las conclusiones deben ajustarse a la evidencia disponible, incluso cuando ello implique corregir o limitar afirmaciones anteriores.

---

**Athena Labs**  
*Laboratorios construidos con propósito, evidencia y aprendizaje continuo.*

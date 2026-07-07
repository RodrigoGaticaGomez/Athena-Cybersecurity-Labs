# Caso-004: Implementación de SIEM con Splunk Enterprise y análisis de eventos Windows

## Descripción

Este laboratorio tiene como objetivo implementar una solución SIEM utilizando Splunk Enterprise para la recolección, indexación y análisis de eventos generados por un sistema Windows.

Durante el caso práctico se configura la ingesta de Windows Event Logs, se realizan búsquedas mediante SPL (Search Processing Language) y se desarrolla una lógica básica de detección orientada al monitoreo de eventos de autenticación.

---

## Objetivos del laboratorio

- Instalar y configurar Splunk Enterprise.
- Crear un índice personalizado para eventos Windows.
- Recolectar logs del sistema operativo.
- Analizar eventos mediante consultas SPL.
- Identificar eventos relevantes de seguridad.
- Simular un incidente de autenticación fallida.
- Crear una lógica básica de detección tipo SOC.

---

## Entorno utilizado

| Componente | Descripción |
|-----------|-------------|
| SIEM | Splunk Enterprise |
| Sistema operativo | Windows |
| Fuente de datos | Windows Event Logs |
| Logs recolectados | Application, Security, System |
| Índice | windows_lab |
| Tipo de laboratorio | Blue Team / SOC |

---

# 1. Instalación de Splunk Enterprise

Se realiza la instalación de Splunk Enterprise en un entorno local Windows.

Durante la instalación se configura una cuenta administradora para acceder a la consola web.

Acceso:

```
http://localhost:8000
```

---

# 2. Creación del índice

Para mantener organizada la información del laboratorio se crea un índice dedicado.

Nombre:

```
windows_lab
```

Tipo:

```
Events
```

Objetivo:

Separar los eventos del laboratorio de los índices internos de Splunk.

---

# 3. Configuración de entrada de datos

Se configura la recolección de eventos desde:

- Application
- Security
- System

Fuente:

```
WinEventLog
```

Los eventos recolectados son enviados al índice:

```
windows_lab
```

---

# 4. Validación de ingesta de eventos

Se realiza una búsqueda inicial para confirmar la recepción de datos.

Consulta SPL:

```spl
index=windows_lab
```

Resultado:

Splunk recibe correctamente eventos generados por Windows.

---

# 5. Análisis de eventos por fuente

Consulta:

```spl
index=windows_lab
| stats count by source
```

Resultado:

Se identifican las fuentes principales:

- WinEventLog:Security
- WinEventLog:System
- WinEventLog:Application

---

# 6. Análisis de autenticaciones exitosas

Evento analizado:

```
EventCode 4624
```

Descripción:

```
An account was successfully logged on
```

Consulta:

```spl
index=windows_lab EventCode=4624
| stats count by Nombre_de_cuenta
```

Objetivo:

Identificar cuentas que realizaron autenticaciones exitosas en el sistema.

---

# 7. Simulación de incidente de seguridad

Se genera un evento controlado ingresando credenciales incorrectas en Windows.

Esto provoca la generación del evento:

```
EventCode 4625
```

Descripción:

```
An account failed to log on
```

---

# 8. Detección de autenticación fallida

Consulta:

```spl
index=windows_lab EventCode=4625
```

Resultado:

Splunk detecta correctamente los intentos fallidos de autenticación generados.

---

# 9. Investigación del evento

Consulta:

```spl
index=windows_lab EventCode=4625
| table _time Nombre_de_cuenta Direccion_de_red_de_origen Tipo_de_inicio_de_sesion Estado
```

Campos analizados:

| Campo | Función |
|-|-|
| _time | Hora del evento |
| Nombre_de_cuenta | Cuenta involucrada |
| Dirección origen | Posible origen del intento |
| Tipo sesión | Método de autenticación |
| Estado | Código del fallo |

Resultado identificado:

```
Estado: 0xC000006D
```

Interpretación:

Intento de inicio de sesión fallido debido a credenciales inválidas.

---

# 10. Creación de lógica de detección

Consulta SPL:

```spl
index=windows_lab EventCode=4625
| stats count by Nombre_de_cuenta
| where count>=2
```

Objetivo:

Detectar cuentas con múltiples intentos fallidos de autenticación.

Caso de uso:

- Posible fuerza bruta
- Password spraying
- Error repetido de credenciales

---

# Flujo de detección

```
Usuario genera evento
        |
        v
Windows Security Log
        |
        v
Splunk Indexer
        |
        v
Consulta SPL
        |
        v
Análisis SOC
        |
        v
Detección
```

---

# Conclusión

Durante este laboratorio se implementó un entorno SIEM funcional utilizando Splunk Enterprise.

Se logró recolectar información del sistema operativo Windows, analizar eventos de seguridad y desarrollar una detección básica basada en comportamiento.

El ejercicio representa un flujo inicial de trabajo realizado por un analista SOC:

- Recolección de evidencia.
- Búsqueda de eventos.
- Interpretación de logs.
- Investigación de actividad sospechosa.
- Creación de reglas de detección.

---

## Tecnologías utilizadas

- Splunk Enterprise
- Windows Event Viewer
- SPL (Search Processing Language)
- Windows Security Logs

---

## Relación con MITRE ATT&CK

Táctica:
Credential Access

Técnica:
Brute Force (T1110)

Descripción:
La detección de múltiples eventos 4625 puede apoyar la identificación de intentos repetidos de autenticación fallida.

## Analista

Athena Labs  
Laboratorio Blue Team / SOC
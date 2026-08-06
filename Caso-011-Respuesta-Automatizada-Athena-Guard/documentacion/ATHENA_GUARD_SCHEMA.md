# Athena Guard Event Schema

**Versión:** 0.1.0

---

## Objetivo

Definir la estructura oficial de los incidentes generados por Athena Guard.

Este documento establece el esquema (schema) que deberán seguir todas las versiones de Athena Guard al generar eventos de seguridad.

Su propósito es garantizar la compatibilidad con Athena Labs, Athena Local, plataformas SIEM como Splunk y futuras herramientas del ecosistema.

## Filosofía de diseño

Athena Guard ha sido diseñado siguiendo los siguientes principios:

- Simplicidad.
- Escalabilidad.
- Compatibilidad.
- Legibilidad.
- Recolección de evidencia.
- Transparencia. 
  
  ### Simplicidad

Cada evento debe ser fácil de generar, leer y procesar, evitando estructuras innecesariamente complejas.

### Escalabilidad

El esquema debe permitir incorporar nuevos tipos de incidentes, acciones y herramientas sin romper la compatibilidad con versiones anteriores.

### Compatibilidad

Los eventos deben utilizar formatos estándar que puedan ser procesados por Athena Local, Splunk y otras plataformas SIEM.

### Legibilidad

Los nombres de los campos deben ser claros, descriptivos y comprensibles tanto para personas como para sistemas automatizados.

### Recolección de evidencia

Cada incidente debe conservar información suficiente para reconstruir lo ocurrido, las acciones realizadas y sus resultados.

### Transparencia

Athena Guard debe registrar las decisiones adoptadas, su justificación, las acciones ejecutadas y los resultados obtenidos, con el objetivo de proporcionar trazabilidad y apoyar al analista durante la investigación de incidentes.
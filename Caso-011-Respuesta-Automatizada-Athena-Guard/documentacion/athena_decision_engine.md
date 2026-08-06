# ATHENA Decision Engine

> "Antes de actuar, Athena Guard comprende."

## Versión

0.1.0

---

# 1. Propósito

El ATHENA Decision Engine es el componente responsable de transformar eventos de seguridad en decisiones fundamentadas.

Su objetivo no es únicamente determinar qué acción ejecutar, sino establecer un proceso lógico, transparente y reproducible que permita evaluar cada incidente antes de responder.

El motor de decisiones constituye el núcleo de Athena Guard, separando el razonamiento de la implementación técnica.

Gracias a esta separación, Athena Guard puede evolucionar hacia distintos lenguajes de programación o plataformas sin modificar la lógica de decisión definida en este documento.

# 2. Filosofía

El ATHENA Decision Engine ha sido diseñado bajo un principio fundamental:

**Las decisiones no se improvisan; se construyen.**

Cada respuesta ejecutada por Athena Guard debe ser el resultado de un proceso estructurado de análisis, evaluación y razonamiento.

El motor de decisiones nunca actúa únicamente porque ocurrió un evento. Antes de seleccionar una respuesta, procura comprender el contexto, identificar el activo afectado, estimar el riesgo, consultar las políticas aplicables y evaluar las posibles consecuencias de cada acción.

Este enfoque permite que las respuestas sean consistentes, explicables y reproducibles, independientemente del entorno donde Athena Guard sea ejecutado.

La automatización constituye un medio para acelerar la respuesta, pero nunca reemplaza el criterio técnico sobre el cual se fundamenta cada decisión.

# 3. Ciclo de decisión

El ciclo de decisión representa el proceso lógico seguido por ATHENA Decision Engine para transformar un evento de seguridad en una respuesta fundamentada.
Cada etapa recibe información de la anterior, genera nuevo conocimiento y produce la entrada para el siguiente componente del proceso.

Evento recibido
        │
        ▼
Validación del evento
        │
        ▼
Clasificación del activo
        │
        ▼
Evaluación del riesgo
        │
        ▼
Consulta de políticas
        │
        ▼
Planificación de respuesta
        │
        ▼
Autorización
        │
        ▼
Ejecución
        │
        ▼
Verificación
        │
        ▼
Documentación

## 3.1 Validación del evento

### Objetivo

Determinar si el evento recibido contiene la información mínima necesaria para ser procesado por Athena Guard.

### Entradas

- Evento recibido
- Fecha
- Origen
- Tipo de evento
- Identificador

### Proceso

Durante esta etapa el sistema verifica la integridad del evento, comprueba que los campos obligatorios estén presentes y valida que el formato sea compatible con el esquema oficial definido por ATHENA_GUARD_SCHEMA.md.

Los eventos incompletos, corruptos o incompatibles no continúan el ciclo de decisión y son registrados como errores de validación.

### Criterios de decisión

El evento será considerado válido cuando:

- Contenga todos los campos obligatorios.
- Su estructura sea compatible con ATHENA_GUARD_SCHEMA.md.
- El origen del evento sea reconocible.
- No presente inconsistencias en su formato.

En caso contrario, el evento será rechazado y registrado para su posterior análisis.

### Salida

Evento validado.

o

Evento rechazado.

### Evidencia

Registro de validación.

## 3.2 Clasificación del activo

### Objetivo

Identificar y clasificar el activo afectado por el evento de seguridad, proporcionando el contexto necesario para las etapas posteriores del proceso de decisión.

La correcta clasificación del activo permite que Athena Guard evalúe el impacto potencial del incidente y seleccione las políticas de respuesta más adecuadas.

### Entradas

- Evento validado.
- Información del activo.
- Metadatos del sistema.
- Inventario de activos (cuando esté disponible).

### Proceso

Durante esta etapa, el sistema identifica el tipo de activo involucrado y recopila la información relevante para su clasificación.

Siempre que sea posible, el activo será contextualizado considerando su función dentro del sistema, su criticidad operativa y su nivel de exposición.

La clasificación obtenida será utilizada posteriormente por el módulo de evaluación del riesgo.

### Criterios de decisión

El activo deberá clasificarse considerando, como mínimo:

- Tipo de activo.
- Criticidad.
- Función dentro del sistema.
- Impacto potencial sobre la confidencialidad.
- Impacto potencial sobre la integridad.
- Impacto potencial sobre la disponibilidad.

Cuando no sea posible determinar la clasificación completa del activo, Athena Guard continuará el proceso registrando el nivel de incertidumbre asociado.

### Salida

Activo clasificado junto con su contexto operativo.

### Evidencia

Registro de clasificación del activo.

## 3.3 Evaluación del riesgo

### Objetivo

Determinar el nivel de riesgo asociado al incidente considerando las características del evento, el contexto del activo afectado y el impacto potencial sobre el sistema.

La evaluación del riesgo proporciona el fundamento técnico necesario para seleccionar las políticas y respuestas más apropiadas.

### Entradas

- Evento validado.
- Activo clasificado.
- Contexto operativo.
- Historial de eventos relacionados (cuando esté disponible).

### Proceso

Durante esta etapa, Athena Guard analiza la información recopilada en las fases anteriores para estimar el riesgo asociado al incidente.

La evaluación considera tanto las características del evento como la importancia del activo involucrado y el posible impacto sobre la operación del sistema.

Siempre que exista información suficiente, el riesgo será evaluado utilizando criterios consistentes y reproducibles.

### Criterios de decisión

La evaluación del riesgo podrá considerar, entre otros aspectos:

- Criticidad del activo.
- Tipo de evento.
- Impacto potencial.
- Probabilidad de ocurrencia.
- Alcance del incidente.
- Existencia de eventos relacionados.
- Nivel de confianza de la evidencia disponible.

Cuando la información disponible resulte insuficiente para determinar el riesgo con certeza, Athena Guard deberá registrar el nivel de incertidumbre y continuar el proceso utilizando el escenario más conservador definido por las políticas del sistema.

### Salida

Nivel de riesgo estimado junto con la justificación de la evaluación.

### Evidencia

Registro de la evaluación del riesgo y de los criterios utilizados.

## 3.4 Consulta de políticas

### Objetivo

Determinar las políticas de seguridad aplicables al incidente evaluado, garantizando que toda respuesta ejecutada por Athena Guard se encuentre previamente autorizada y alineada con las reglas definidas por la organización.

### Entradas

- Evento validado.
- Activo clasificado.
- Evaluación del riesgo.
- Repositorio de políticas.

### Proceso

Durante esta etapa, Athena Guard consulta el conjunto de políticas disponibles para identificar aquellas que resulten compatibles con el incidente analizado.

Las políticas determinan las acciones permitidas, restringidas o prohibidas para cada combinación de tipo de evento, activo afectado y nivel de riesgo.

Cuando existan múltiples políticas aplicables, el sistema deberá priorizar la más específica.

### Criterios de decisión

Las políticas podrán definir, entre otros aspectos:

- Acciones permitidas.
- Acciones restringidas.
- Acciones prohibidas.
- Requisitos de autorización.
- Necesidad de intervención humana.
- Prioridad de ejecución.
- Restricciones temporales.

Si no existe una política aplicable, Athena Guard no ejecutará respuestas automáticas y registrará el incidente para revisión por parte del analista.

### Salida

Política seleccionada junto con las acciones autorizadas.

### Evidencia

Registro de la política aplicada y de los criterios utilizados para su selección.

## 3.5 Planificación de respuesta

### Objetivo

Construir un plan de respuesta adecuado para el incidente analizado, seleccionando las acciones más apropiadas de acuerdo con la evaluación del riesgo y las políticas aplicables.

El objetivo de esta etapa no es ejecutar acciones, sino diseñar una estrategia de respuesta técnicamente fundamentada.

### Entradas

- Evento validado.
- Activo clasificado.
- Evaluación del riesgo.
- Política seleccionada.

### Proceso

Durante esta etapa, Athena Guard analiza las posibles acciones disponibles y construye un plan de respuesta ordenado.

Cada acción propuesta deberá respetar las restricciones definidas por las políticas de seguridad y considerar el posible impacto sobre el sistema.

Siempre que existan múltiples alternativas válidas, el sistema deberá priorizar aquella que minimice el riesgo operativo y preserve la mayor cantidad posible de evidencia.

### Criterios de decisión

El plan de respuesta podrá considerar, entre otros aspectos:

- Preservación de evidencia.
- Impacto operativo.
- Riesgo residual.
- Tiempo estimado de ejecución.
- Dependencias entre acciones.
- Posibilidad de reversión.
- Requisitos de autorización.

El plan deberá evitar acciones innecesarias y reducir al mínimo el impacto sobre la continuidad operacional.

### Salida

Plan de respuesta construido y listo para su evaluación final.

### Evidencia

Registro del plan generado y de los criterios considerados durante su construcción.

## 3.6 Autorización

### Objetivo

Determinar si el plan de respuesta construido puede ser ejecutado de acuerdo con las políticas de seguridad, el nivel de riesgo y las condiciones operativas del sistema.

La autorización constituye el último punto de control antes de que Athena Guard intervenga sobre el entorno.

### Entradas

- Plan de respuesta.
- Política seleccionada.
- Nivel de riesgo.
- Estado actual del sistema.

### Proceso

Durante esta etapa, Athena Guard verifica que todas las condiciones necesarias para ejecutar el plan de respuesta se encuentren satisfechas.

El sistema confirma que las acciones propuestas estén autorizadas, que no existan restricciones activas y que el contexto operativo permita su ejecución de forma segura.

Cuando el plan requiera aprobación humana, Athena Guard detendrá el proceso hasta recibir la autorización correspondiente.

### Criterios de decisión

La autorización podrá considerar, entre otros aspectos:

- Nivel de riesgo.
- Tipo de respuesta.
- Restricciones definidas por las políticas.
- Estado del sistema.
- Disponibilidad de recursos.
- Requisitos de aprobación manual.

Si cualquiera de estas condiciones no se cumple, el plan permanecerá pendiente y no será ejecutado.

### Salida

Plan autorizado.

o

Plan pendiente de autorización.

### Evidencia

Registro de la decisión de autorización y de los criterios considerados.

## 3.7 Ejecución

### Objetivo

Ejecutar el plan de respuesta previamente autorizado de forma controlada, segura y trazable.

La ejecución deberá respetar el orden definido durante la planificación, registrando cada acción realizada y sus resultados.

### Entradas

- Plan autorizado.
- Estado actual del sistema.
- Recursos necesarios para la ejecución.

### Proceso

Durante esta etapa, Athena Guard ejecuta secuencialmente las acciones definidas en el plan de respuesta.

Cada acción deberá completarse antes de iniciar la siguiente, salvo que el propio plan especifique mecanismos de ejecución paralela.

Ante un error crítico, el sistema podrá detener la ejecución o aplicar las estrategias de recuperación definidas por las políticas correspondientes.

### Criterios de decisión

Durante la ejecución se evaluarán, entre otros aspectos:

- Resultado de cada acción.
- Código de retorno.
- Integridad del sistema.
- Disponibilidad de recursos.
- Cumplimiento del orden establecido.
- Necesidad de abortar la ejecución.

### Salida

Plan ejecutado.

o

Plan parcialmente ejecutado.

o

Plan interrumpido.

### Evidencia

Registro detallado de todas las acciones ejecutadas, sus resultados y los tiempos de ejecución.

## 3.8 Verificación

### Objetivo

Comprobar que las acciones ejecutadas produjeron el resultado esperado y que los objetivos definidos por el plan de respuesta fueron alcanzados.

### Entradas

- Plan ejecutado.
- Evidencias generadas.
- Estado actual del sistema.

### Proceso

Athena Guard verifica cada acción ejecutada utilizando evidencia objetiva.

La verificación puede incluir comprobaciones de integridad, disponibilidad, restauración de servicios, comparación de estados o cualquier otro mecanismo definido por las políticas correspondientes.

### Criterios de decisión

La verificación podrá considerar:

- Objetivo alcanzado.
- Estado esperado.
- Integridad preservada.
- Ausencia de errores.
- Evidencia consistente.

### Salida

Respuesta verificada.

o

Verificación fallida.

### Evidencia

Resultados de las comprobaciones realizadas.

## 3.9 Documentación

### Objetivo

Registrar de forma estructurada todo el ciclo de decisión, garantizando la trazabilidad completa del incidente y preservando el conocimiento generado durante el proceso.

### Entradas

- Evento original.
- Plan ejecutado.
- Resultados de la verificación.
- Evidencias recopiladas.

### Proceso

Athena Guard consolida toda la información generada durante el ciclo de decisión en un registro único del incidente.

La documentación deberá permitir reconstruir posteriormente las decisiones adoptadas, las acciones ejecutadas y sus resultados.

### Criterios de decisión

La documentación deberá incluir, como mínimo:

- Evento original.
- Activo afectado.
- Evaluación del riesgo.
- Política aplicada.
- Plan de respuesta.
- Resultado de la autorización.
- Acciones ejecutadas.
- Resultado de la verificación.
- Evidencias generadas.

### Salida

Incidente completamente documentado.

### Evidencia

Registro final del incidente listo para auditoría, aprendizaje e integración con otras plataformas.

# 4. Principios del Decision Engine

- Las decisiones no se improvisan; se construyen.
- La automatización nunca reemplaza el criterio técnico.
- Toda decisión debe poder ser explicada.
- Toda acción debe generar evidencia.
- La respuesta debe ser proporcional al riesgo.
- La preservación de evidencia tiene prioridad sobre la rapidez.
- La intervención humana siempre debe ser posible cuando las políticas lo requieran.
- El conocimiento generado durante cada incidente debe poder reutilizarse.

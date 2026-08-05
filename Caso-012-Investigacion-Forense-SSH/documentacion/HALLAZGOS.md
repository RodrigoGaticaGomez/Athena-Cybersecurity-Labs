# Hallazgo 001

## Título
Reconocimiento inicial de la evidencia

## Descripción

Se verificó que la evidencia corresponde a un archivo de texto ASCII con registros de autenticación del sistema Linux.

## Evidencia

Comandos utilizados:

file auth_2026-08-05.log

wc -l auth_2026-08-05.log

head -10 auth_2026-08-05.log

## Resultado

- Tipo de archivo: ASCII text.
- Cantidad de registros: 477 líneas.
- Las primeras entradas corresponden al inicio de sesión gráfico (GDM) del sistema.

## Conclusión

La evidencia es válida para iniciar el análisis y aún no se observan indicios de actividad SSH en las primeras líneas del archivo.

# Hallazgo 002

## Título
Ausencia de registros SSH

## Descripción

Se realizó una búsqueda de eventos asociados al servicio SSH (`sshd`) dentro de la evidencia preservada.

## Comando

grep sshd auth_2026-08-05.log

## Resultado

No se encontraron registros relacionados con el servicio SSH.

## Conclusión

Con la evidencia disponible no es posible afirmar que existiera actividad SSH durante el período registrado.

# Hallazgo 003

## Título
Servicio OpenSSH habilitado para la simulación

## Descripción

Se verificó que el servicio OpenSSH se encontraba instalado en el sistema y fue iniciado correctamente para preparar el escenario del incidente.

## Evidencia

Comandos:

sudo systemctl start ssh

systemctl status ssh

## Resultado

- Servicio iniciado correctamente.
- Estado: Active (running).
- Escuchando en el puerto TCP 22.
- Listo para aceptar conexiones remotas.

## Conclusión

El servidor se encuentra preparado para recibir conexiones SSH y generar eventos de autenticación que serán utilizados durante la investigación.

# Hallazgo 004

## Título

Primer intento de autenticación SSH detectado

## Descripción

Durante la simulación del incidente se identificó un intento de autenticación utilizando un usuario inexistente.

## Evidencia

Invalid user

Failed password

## Resultado

Usuario:

usuario_inexistente

Origen:

10.193.9.63

Puerto origen:

57318

## Conclusión

El servidor registró correctamente el intento de autenticación y generó los eventos necesarios para iniciar una investigación forense.

# Hallazgo 005

## Título
Diferencia entre "Invalid user" y "Failed password"

## Descripción

Se observó que el servidor registra un único evento "Invalid user" por conexión SSH, mientras que cada intento de contraseña genera un evento independiente "Failed password".

## Evidencia

Comandos:

grep "Invalid user" /var/log/auth.log

grep "Failed password" /var/log/auth.log

## Resultado

- 2 eventos "Invalid user".
- 4 eventos "Failed password".

## Conclusión

El comportamiento observado corresponde al funcionamiento esperado de OpenSSH, donde la validación del usuario ocurre una vez por conexión y los intentos de autenticación se registran individualmente.

# Hallazgo 006

## Título

Compresión de eventos repetidos en el registro de autenticación

## Descripción

Se observó que el sistema consolidó múltiples eventos idénticos mediante el mensaje "message repeated X times", evitando registrar cada intento en una línea independiente.

## Evidencia

Failed password for rodrigo...

message repeated 2 times

## Conclusión

El número de líneas del archivo no representa necesariamente el número real de eventos ocurridos.

Durante una investigación forense debe considerarse la compresión de eventos para evitar subestimar la actividad observada.

# Hallazgo 007

## Título

Autenticación SSH exitosa

## Descripción

Se registró un inicio de sesión exitoso mediante el servicio OpenSSH utilizando una cuenta válida.

## Evidencia

Accepted password for rodrigo

## Resultado

Usuario:
rodrigo

Estado:
Autenticación exitosa

## Conclusión

El servidor aceptó las credenciales suministradas y permitió el acceso remoto mediante SSH.

Este evento representa el punto final del escenario de autenticación y debe ser considerado de alta relevancia durante una investigación, ya que confirma que un usuario obtuvo acceso al sistema.

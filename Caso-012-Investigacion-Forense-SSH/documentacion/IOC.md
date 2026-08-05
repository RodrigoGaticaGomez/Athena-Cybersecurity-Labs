| Campo       | Valor                      |
| ----------- | -------------------------- |
| Tipo        | Dirección IP               |
| Valor       | 10.193.9.63                |
| Descripción | Origen de los intentos SSH |


| Campo       | Valor                                   |
| ----------- | --------------------------------------- |
| Tipo        | Usuario                                 |
| Valor       | usuario_inexistente                     |
| Descripción | Usuario utilizado durante la simulación |


| Campo  | Valor    |
| ------ | -------- |
| Tipo   | Servicio |
| Valor  | SSH      |
| Puerto | 22/TCP   |


| Campo            | Valor                     |
| ---------------- | ------------------------- |
| Usuario objetivo | **rodrigo**               |
| Tipo             | Cuenta válida del sistema |
| Estado           | Credenciales incorrectas  |

| Tipo             | Valor                 | Descripción             |
| ---------------- | --------------------- | ----------------------- |
| Dirección IP     | `10.193.9.63`         | Origen de la simulación |
| Usuario inválido | `usuario_inexistente` | Intento de enumeración  |
| Usuario válido   | `rodrigo`             | Cuenta objetivo         |
| Servicio         | SSH                   | Puerto TCP/22           |
| Evidencia        | `Failed password`     | Intentos fallidos       |
| Evidencia        | `Accepted password`   | Acceso exitoso          |



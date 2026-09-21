# DOCUMENTACION DE LA REVISION
## Introduccion.
En esta seccion damos a conocer lo realizado en la base de datos lo cual es su revision completa del funcionamiento, revision de los errores y ciertas modificaciones que realizamos para que estuviera mas claro y ordenado.
1. Revisión de los tipos de datos: <br>
1.1. Tabla *device*
En la versión original, los campos estaban definidos de la siguiente manera:
```sql
id_device   text NOT NULL,
device_ip   text,
device_name text,
```
De lo cual nosotros lo modificamos ya que durante la revision consideramos que no todos los campos debian utilizar el comando **TEXT**, ya que cada dato dado posee una naturaleza o estructura diferente. <br>
**Por lo cual se modifico a la siguente:**
```sql
id_device   INT NOT NULL,
device_ip   NUMBER,
device_name VARCHAR(10),
```
¿Motivo de la modificación? <br>
* **id_device:** se cambió de TEXT a INT, ya que corresponde a un identificador numérico. <br>
* **device_ip:** se intentó utilizar un tipo numérico para representar la dirección IP. <br>
* **device_name:** se cambió de TEXT a VARCHAR(10) para establecer una longitud máxima. <br>
# Muestra visual de modificacion: Modificado/Anterior <br>
![Device](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/device2.jpg?raw=true)

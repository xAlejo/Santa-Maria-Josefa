# DOCUMENTACION DE LA REVISION
## Introduccion.
En esta seccion damos a conocer lo realizado en la base de datos lo cual es su revision completa del funcionamiento, revision de los errores y ciertas modificaciones que realizamos para que estuviera mas claro y ordenado.
# 1. Revisión de los tipos de datos: <br>
# 1.1. Tabla *device*
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
device_ip   INT NOT NULL,
device_name VARCHAR(10),
```
¿Motivo de la modificación? <br>
* **id_device:** se cambió de TEXT a INT, ya que corresponde a un identificador numérico. <br>
* **device_ip:** se cambió de TEXT a INT, ya que corresponde a un identificador numérico.  <br>
* **device_name:** se cambió de TEXT a VARCHAR(10) para establecer una longitud máxima. <br>
# Muestra visual de modificacion: Modificado/Anterior <br>
![Device](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/device2.jpg?raw=true)

# 2. Revisión de la tabla *file* <br>
* En la tabla file se mantuvo la estructura general, pero se modificaron algunos tipos de datos. <br>
Originalmente:
```sql
id_file     text NOT NULL,
module_name text,
field_name  text,
object_id   text,
file_area   text,
extension   text,
description text,
```
Se modificó a:
```sql
id_file     INT NOT NULL,
module_name VARCHAR(20),
field_name  VARCHAR(15),
object_id   NUMBER,
file_area   VARCHAR(5),
extension   text,
description text,
```
El motivo de esto fue que se buscó especificar mejor el tipo y tamaño de los datos.
* **id_file** → identificador numérico.
* **module_name** → texto con una longitud máxima.
* **field_name** → texto con longitud limitada.
* **object_id** → se consideró como dato numérico.
* **file_area** → texto corto. <br>

Ademas se agrego un comentario indicando que esta tabla no se estaria siendo utilizada actualmente y no estaria vinculada a nada, por ende se encuentra en evaluacion para ser eliminada.
![file](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/file.jpg?raw=true)

# 3. Modificación de la tabla holiday

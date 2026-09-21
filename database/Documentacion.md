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

# 3. Modificación de la tabla *holiday*
* Esta fue una modificación importante o mas bien grande, ya que la estructura original utilizaba cuatro campos separados para almacenar la fecha.
```sql
holiday_year   text,
holiday_month  text,
holiday_day    text,
holiday_detail text,
```
* Por lo cual se propuso reemplazarlos por un único campo:
```sql
holiday_date DATE,
```
* Por lo cual quedo de esta forma el apartado de Holiday.
```sql
CREATE TABLE IF NOT EXISTS holiday (
    id_holiday INT NOT NULL,
    holiday_date DATE,
    holiday_detail TEXT,
    CONSTRAINT holiday_pkey PRIMARY KEY (id_holiday)
)
```
**¿Motivo de la modificación?** <br>

La fecha estaba dividida en tres columnas independientes:

* año
* mes
* día

Esto puede complicar la manipulación de las fechas y la modificacion realizada la hace mas sencilla y simple para las consultas y operaciones, de esta forma Se propuso utilizar *DATE*, que permite almacenar directamente una fecha completa. <br>
* Ejemplo
```sql
2026-09-18
```
* Por ende en los datos de inserccion tambien se realizo una modifacion, pasando de esto:
```sql
INSERT INTO holiday VALUES
('1','2026','01','01','ano nuevo'),
('2','2026','04','03','viernes santo'),
('3','2026','04','04','sabado santo'),
('4','2026','05','01','dia del trabajador'),
('5','2026','05','21','dia de las glorias navales'),
('6','2026','06','29','san pedro y san pablo'),
('7','2026','07','16','dia de la virgen del carmen'),
('8','2026','08','15','asuncion de la virgen'),
('9','2026','09','18','independencia nacional'),
('10','2026','09','19','dia de las glorias del ejercito'),
('11','2026','10','12','encuentro de dos mundos'),
('12','2026','10','31','dia de las iglesias evangelicas'),
('13','2026','11','01','dia de todos los santos'),
('14','2026','12','08','inmaculada concepcion'),
('15','2026','12','25','navidad');
```
* A esto:
```sql
INSERT INTO holiday VALUES
(1, '2026-01-01', 'ano nuevo'),
(2, '2026-04-03', 'viernes santo'),
(3, '2026-04-04', 'sabado santo'),
(4, '2026-05-01', 'dia del trabajador'),
(5, '2026-05-21', 'dia de las glorias navales'),
(6, '2026-06-29', 'san pedro y san pablo'),
(7, '2026-07-16', 'dia de la virgen del carmen'),
(8, '2026-08-15', 'asuncion de la virgen'),
(9, '2026-09-18', 'independencia nacional'),
(10, '2026-09-19', 'dia de las glorias del ejercito'),
(11, '2026-10-12', 'encuentro de dos mundos'),
(12, '2026-10-31', 'dia de las iglesias evangelicas'),
(13, '2026-11-01', 'dia de todos los santos'),
(14, '2026-12-08', 'inmaculada concepcion'),
(15, '2026-12-25', 'navidad');
```
# 4. Modificación de la tabla patient.
* En la tabla original, la fecha de nacimiento estaba almacenada como texto.
```sql
patient_birthday text,
```
* Por lo cual Se modificó para utilizar una fecha real.
```sql
patient_birth DATE,
```
* Por lo cual la estructua al modificarse quedo de la siguente forma:
```sql
id_patient       INT NOT NULL,
patient_run      VARCHAR(12),
patient_name     VARCHAR(30),
patient_birth    DATE,
patient_contact  NUMBER,
patient_gender   VARCHAR(1),
patient_address  VARCHAR(20),
```
**¿El motivo?**

Se buscó utilizar tipos de datos más específicos:

* **patient_name** → VARCHAR(30)
* **patient_birth** → DATE
* **patient_gender** → VARCHAR(1)
* **patient_address** → VARCHAR(20)

![Patient](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/patient.png?raw=true)

# 5. Modificación de la tabla staff
* Anteriormente la tabla utilizaba TEXT para prácticamente todos los campos, pero esto se cambio.
```sql
id_staff          TEXT,
staff_name        VARCHAR(15),
staff_ocupation   VARCHAR(20),
staff_gender      VARCHAR(1),
staff_area        VARCHAR(5),
staff_credentials NUMBER,
staff_password    VARCHAR(12),
device_ip         NUMBER,
```
**¿El motivo?**
* Se intentó definir con mayor precisión qué tipo de información almacena cada campo y limitar la cantidad de caracteres cuando corresponde.
* Ejemplo:
```sql
staff_gender VARCHAR(1)
```
* Esto permite almacenar solo un caracter lo cual es lo justo y necesario para este atributo
![staff](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/staff.png?raw=true)

# 6. Modificación de la tabla service
* La tabla original tenía:
```sql
service_code       text,
service_name       text,
service_credential text,
service_time       text,
```
* Por lo cual se modificó a:
```sql
service_code       NUMBER,
service_name       VARCHAR(10),
service_credential NUMBER,
service_time       INT NOT NULL,
```
**¿EL motivo?**
* Se buscó representar cada dato mediante un tipo más específico, especialmente:
```sql
service_time INT NOT NULL
```
* Esto permite almacenar y representar Minutos
![Services](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/services.png?raw=true)

# 7. Modificación de workcalendar
* Originalmente se utilizaban:
```sql
work_month text,
work_day   text,
```
* Y se reemplazó por:
```sql
work_date DATE,
```
* Y los horarios:
```sql
work_start  TIME,
work_finish TIME,
break_start TIME,
break_finish TIME,
```
* **¿El motivo?**
* Se buscó manejar las fechas y horas utilizando tipos específicos en lugar de almacenarlas como texto.

* Esto permite realizar operaciones y comparaciones de fechas y horas de manera más adecuada.
* Ademas se realizo la modificacion de los datos de insercion debido a que en las tablas antiguas habian 8 secciones y en la actual se dejaron 7. <br>

* **Tablas**
  ![tablas](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/workcalendar%20parte1.png?raw=true) <br>
  
* **Datos Insercion**
![workcalendar parte2.png](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/workcalendar%20parte2.png?raw=true)

# 8. Modificación de *reservation*
* En la versión original se utilizaban columnas separadas.
```sql
reservation_year
reservation_month
reservation_day
```
* A lo que se propuso remplazarlo por:
```sql
reservation_date DATE,
```
* Y tambien:
```sql
reservation_hour TIME
```
**¿El Motivo?**
* se buscó evitar almacenar fechas separadas como texto. <br>
![reservation.mrd](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/reservation.png?raw=true)

# 9. Revisión de *medicalhistory*
* Aqui se modificaron principalmente los tipos de datos:
```sql
id_medicalhistory INT NOT NULL,
id_patient INT NOT NULL,
staff_id INT,
staff_name VARCHAR(15),
staff_ocupation VARCHAR(20),
staff_area VARCHAR(5),
...
day_attention DATE,
hour_attention TIME,
```
* También se agregó el comentario:
```sql
--- Tabla no usada (en decisión para borrar)
```
**¿El Motivo?**
Se consideró que la tabla podría no estar siendo utilizada dentro de la aplicación y se dejó marcada para evaluar posteriormente si realmente era necesaria.
* También se cambiaron:
```sql
day_attention DATE
hour_attention TIME
```
* Para representar correctamente fecha y hora.
![Medicalhistory](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/medicalhistory.png?raw=true)

# 10. Modificación de medicalimage

* Se cambiaron los identificadores:

```sql
id_medicalimage INT NOT NULL,
id_medicalhistory INT NOT NULL,
```
* manteniendo la relación:
```sql
FOREIGN KEY (id_medicalhistory)
REFERENCES medicalhistory(id_medicalhistory)
ON DELETE CASCADE
```

**¿El Motivo?**

* Se buscó mantener la relación entre una imagen médica y su historial médico, utilizando identificadores numéricos.
![medicalimage](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/medicalimage.png?raw=true)

# 11. Modificación de *session*

Se modificó:
```sql
id_session INT NOT NULL,
session_number NUMBER,
session_encode TEXT,
Motivo
```
* Se buscó utilizar un tipo numérico para los identificadores y el número de sesión.
![a](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/session.png?raw=true)

# 12. Creacion de rol y permisos al rol como ejemplo (para revision)
de forma autonoma se investigó al respecto, para así crear un rol dentro de un procedure y la posterior ejecucion de los permisos deseados, en si esto no es algo que se implementa en la base de datos, solo es una nota para revision de nuestro docente.
```sql
-- CREATE USER pa100t WITH PASSWORD ****;
-- GRANT CONNECT ON DATABASE seed_test_data TO pa100t;
-- GRANT ALL ON ALL TABLES IN SCHEMA public TO pa100t;
```
* Se identificó que entregar:
```sql
GRANT ALL
```
* otorga permisos demasiado amplios.

Por eso se dejó indicado:
```sql
---- > Está mal darle todos los permisos al paciente
```
**¿Motivo?**

* Los usuarios deberían tener solamente los permisos necesarios para realizar sus funciones.

* Por ejemplo, un usuario que solamente necesita consultar información no debería tener automáticamente permisos para:

* eliminar registros;
* modificar registros;
* insertar información;
* alterar estructuras.
![v](https://github.com/xAlejo/Santa-Maria-Josefa/blob/main/database/Imagenes/createuser.png?raw=true)

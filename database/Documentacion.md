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

* Además, se agregó patient_age para almacenar la edad del paciente y de esta forma poder adquirid informacion mas rapida debido a su etapa de vida.

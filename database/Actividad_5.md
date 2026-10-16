# Actividad 5: Implementar Base de Datos en PostgreSQL

## Descripción

Se implementó una base de datos utilizando PostgreSQL mediante pgAdmin 4. Se creó la base de datos denominada **Consultorio Santa María Josefa**, donde se definieron las tablas necesarias para almacenar información relacionada con contacto, especialidades médicas, horarios de atención e información institucional del Consultorio Santa María Josefa.

## Tablas creadas

| Tabla | Función |
| :--- | :--- |
| Contacto | Almacena teléfono, correo y datos contactos |
| Nosotros | Almacena información institución del consultorio |
| Especialidad | Almacena las especialidades médicas disponibles |
| Horario | Almacena días y horarios de atención |
| Ubicación | Almacena la ubicación y dirección del consultorio |
| Imagen | Almacena información de las imágenes utilizadas en el sitio web |

```SQL
CREATE TABLE contacto (
    id_contacto SERIAL PRIMARY KEY,
    telefono VARCHAR(20),
    correo VARCHAR(100),
    formulario TEXT
);

CREATE TABLE nosotros (
    id_nosotros SERIAL PRIMARY KEY,
    historia TEXT,
    mision TEXT
);

CREATE TABLE especialidades (
    id_especialidad SERIAL PRIMARY KEY,
    nombre_especialidad VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE horario (
    id_horario SERIAL PRIMARY KEY,
    dia VARCHAR(20),
    hora_apertura TIME,
    hora_cierre TIME
);

CREATE TABLE ubicacion (
    id_ubicacion SERIAL PRIMARY KEY,
    direccion VARCHAR(200),
    mapa TEXT
);

CREATE TABLE imagen (
    id_imagen SERIAL PRIMARY KEY,
    url_imagen VARCHAR(255),
    descripcion VARCHAR(200)
);
```
<img width="494" height="697" alt="image" src="https://github.com/user-attachments/assets/b7b09ae2-934d-461f-aba0-043684432ac4" />

## Resultado obtenido

La base de datos fue creada correctamente en PostgreSQL y se definió una estructura compuesta por seis tablas destinadas a almacenar información de contacto, especialidades médicas, horarios de atención, ubicación e información institucional que será utilizada por la página web del Consultorio Santa María Josefa.

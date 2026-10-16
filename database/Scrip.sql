-- SCRIPT BASE DE DATOS: CONSULTORIO SANTA MARÍA JOSEFA -- Creado en PostgreSQL 10[cite: 16]

-- 1. TABLA CONTACTO
CREATE TABLE Contacto (
    id_contacto SERIAL PRIMARY KEY, 
    telefono VARCHAR(20), 
    correo VARCHAR(100), 
    direccion TEXT
);

-- 2. TABLA NOSOTROS
CREATE TABLE Nosotros (
    id_nosotros SERIAL PRIMARY KEY, 
    descripcion TEXT
);

-- 3. TABLA ESPECIALIDAD
CREATE TABLE Especialidad (
    id_especialidad SERIAL PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL
);

-- 4. TABLA HORARIO
CREATE TABLE Horario (
    id_horario SERIAL PRIMARY KEY, 
    dia VARCHAR(20) NOT NULL, 
    hora_inicio TIME, 
    hora_fin TIME
);

-- 5. TABLA UBICACIÓN
CREATE TABLE UBICACIÓN (
    id_ubicación SERIAL PRIMARY KEY, 
    dirección VARCHAR(200), 
    mapa TEXT
);

-- 6. TABLA IMAGEN
CREATE TABLE IMAGEN (
    id_imagen SERIAL PRIMARY KEY, 
    url_imagen VARCHAR(200), 
    descripcion VARCHAR(100)
);

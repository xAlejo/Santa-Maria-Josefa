# Version 2.0 ( Actual)
Aqui dejo la actual base modificada por mi, ya habia realizado otra que dejare en el documento oficial pero esta es la nueva que aun falta un poco pulir...

  -- Pa100T — DB de prueba con datos ficticios
-- Staff: superhéroes Marvel | Pacientes: dibujos animados
--
-- Ejecutar desde cmd de Windows:
--   psql -U postgres -f "C:\ruta\seed_test_data.sql"

-- Desconectar otras sesiones activas de pa100t
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'pa100t' AND pid <> pg_backend_pid();

\connect pa100t
 
-- Limpiar datos en orden inverso a FK
TRUNCATE medicalimage, medicalhistory, reservation, service, workcalendar,
         file, session, patient, staff, device, holiday CASCADE;

-- Tablas (solo si no existen aún)
CREATE TABLE IF NOT EXISTS device (
    id_device   BIGINT NOT NULL,
    device_ip   INET NOT NULL,
    device_name VARCHAR(30),
    CONSTRAINT device_pkey PRIMARY KEY (id_device),
    CONSTRAINT device_device_ip_key UNIQUE (device_ip)
);

--- Tabla no usada (en decisión para borrar)
CREATE TABLE IF NOT EXISTS file (
    id_file     INT NOT NULL,
    module_name VARCHAR(20),
    field_name  VARCHAR(15),
    object_id   INT,
    file_area   VARCHAR(5),
    extension   text,
    description text,
    CONSTRAINT file_pkey PRIMARY KEY (id_file)
);

------------
CREATE TABLE IF NOT EXISTS holiday (
	id_holiday INT NOT NULL,
	holiday_date DATE,
	holiday_detail TEXT,
	CONSTRAINT holiday_pkey PRIMARY KEY (id_holiday)
);
------------

CREATE TABLE IF NOT EXISTS patient (
    id_patient       BIGINT NOT NULL,
    patient_run      VARCHAR(12),
    patient_name     VARCHAR(30),
    patient_birth    DATE,
    patient_contact  VARCHAR(15),
    patient_gender   VARCHAR(1),
    patient_address  VARCHAR(50),
    CONSTRAINT patient_pkey PRIMARY KEY (id_patient),
    CONSTRAINT patient_patient_run_key UNIQUE (patient_run)
);

CREATE TABLE IF NOT EXISTS staff (
    id_staff          BIGINT,
    staff_name        VARCHAR(30),
    staff_ocupation   VARCHAR(20),
    staff_gender      VARCHAR(1),
    staff_area        VARCHAR(5),
    staff_credentials VARCHAR(20),
    staff_password    VARCHAR(12),
    device_ip         INET	 NOT NULL,
    CONSTRAINT staff_pkey PRIMARY KEY (id_staff),
    CONSTRAINT staff_staff_password_key UNIQUE (staff_password)
);

CREATE TABLE IF NOT EXISTS service (
    id_service         BIGINT NOT NULL,
    id_staff           BIGINT NOT NULL,
    service_code       VARCHAR(5),
    service_name       VARCHAR(30),
    service_credential INT,
    service_time       INT NOT NULL,
    CONSTRAINT service_pkey PRIMARY KEY (id_service),
    CONSTRAINT fk_staff_service FOREIGN KEY (id_staff) REFERENCES staff(id_staff) ON DELETE CASCADE
);

-- PREGUNTAR

CREATE TABLE IF NOT EXISTS workcalendar (
    id_workcalendar BIGINT NOT NULL,
    id_staff        BIGINT NOT NULL,
	work_day		VARCHAR(10),
    work_start      TIME,
    work_finish     TIME,
    break_start     TIME,
    break_finish    TIME,
    CONSTRAINT workcalendar_pkey PRIMARY KEY (id_workcalendar),
    CONSTRAINT fk_staff_workcalendar FOREIGN KEY (id_staff) REFERENCES staff(id_staff)
);

CREATE TABLE IF NOT EXISTS reservation (
    id_reservation       BIGINT NOT NULL,
    id_staff             BIGINT NOT NULL,
    service_name         VARCHAR(15),
    service_time         INT, -- cuantos minutos dura la consulta
    reservation_creator  VARCHAR(20),
    reservation_date	 DATE,
    reservation_hour     TIME,
    reservation_detail   text,
    reservation_verified VARCHAR(10),
    id_patient           BIGINT NOT NULL,
    CONSTRAINT reservation_pkey PRIMARY KEY (id_reservation),
    CONSTRAINT fk_staff_reservation   FOREIGN KEY (id_staff)   REFERENCES staff(id_staff),
    CONSTRAINT fk_patient_reservation FOREIGN KEY (id_patient) REFERENCES patient(id_patient) ON DELETE CASCADE
);


--- Tabla no usada (en decisión para borrar)
CREATE TABLE IF NOT EXISTS medicalhistory (
    id_medicalhistory BIGINT NOT NULL,
    id_patient        BIGINT NOT NULL,
    staff_id          BIGINT,
    staff_name        VARCHAR(15),
    staff_ocupation   VARCHAR(20),
    staff_area        VARCHAR(5),
    reason            text,
    diagnostic        text,
    prescription      text,
    day_attention     DATE,
    hour_attention    TIME,
    CONSTRAINT medicalhistory_pkey PRIMARY KEY (id_medicalhistory),
    CONSTRAINT fk_patient_medicalhistory FOREIGN KEY (id_patient) REFERENCES patient(id_patient) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS medicalimage (
    id_medicalimage          BIGINT NOT NULL,
    id_medicalhistory        BIGINT NOT NULL,
    medicalimage_description text,
    medicalimage_path        text,
    CONSTRAINT medicalimage_pkey PRIMARY KEY (id_medicalimage),
    CONSTRAINT fk_medicalhistory FOREIGN KEY (id_medicalhistory) REFERENCES medicalhistory(id_medicalhistory) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS session (
    id_session     BIGINT NOT NULL,
    session_number INT,
    session_encode TEXT,
    CONSTRAINT session_pkey PRIMARY KEY (id_session),
    CONSTRAINT session_session_number_key UNIQUE (session_number)
);

-- CREATE USER pa100t WITH PASSWORD ****;
-- GRANT CONNECT ON DATABASE seed_test_data TO pa100t;
-- GRANT ALL ON ALL TABLES IN SCHEMA public TO pa100t; ---- > Está mal darle todos los permisos al paciente

CREATE OR REPLACE PROCEDURE crear_staff(usuario TEXT, rut VARCHAR(10))
LANGUAGE plpgsql
AS $$
BEGIN
    -- Crea el usuario usando el RUT como contraseña
    EXECUTE format(
        'CREATE USER %I WITH PASSWORD %L',
        usuario,
        rut
    );

    -- Permisos sobre las tablas existentes
    EXECUTE format(
        'GRANT SELECT, INSERT, UPDATE, DELETE
         ON ALL TABLES IN SCHEMA public 
		 TO %I',
        usuario
    );
END;
$$;

-- Data
INSERT INTO staff VALUES
('1000000000000000001','thor odinson','administrador','m','a','1,2,3,4','12345678-9','192.168.122.10'),
('1000000000000000002','dra. natasha romanoff','medico','f','m','3,4','27182818-2','192.168.122.11'),
('1000000000000000003','dr. tony stark','cirujano','m','d','3,4','16180339-8','192.168.122.12'),
('1000000000000000004','wanda maximoff','administrativa','f','a','2,4','14142135-6','192.168.122.13');

INSERT INTO device VALUES
('2000000000000000001','192.168.122.10','pc administracion'),
('2000000000000000002','192.168.122.11','pc medico 1'),
('2000000000000000003','192.168.122.12','pc medico 2'),
('2000000000000000004','192.168.122.13','pc recepcion');

INSERT INTO patient VALUES
('3000000000000000001','11223344-5','bugs bunny','1950-07-27','912345678','m','looney tunes 123, chillan'),
('3000000000000000002','55667788-9','daisy duck','1940-06-07','','f','pato donald 456, chillan'),
('3000000000000000003','99887766-k','tom gato','1940-02-10','987654321','m','hanna barbera 789, chillan'),
('3000000000000000004','44332211-3','wilma flintstone','1960-09-30','','f','bedrock 1, piedradura');

INSERT INTO service VALUES
('4000000000000000001','1000000000000000002','con','consulta medica','2','30'),
('4000000000000000002','1000000000000000002','eco','ecografia','4','15'),
('4000000000000000003','1000000000000000003','cir','evaluacion quirurgica','4','20'),
('4000000000000000004','1000000000000000003','rx','radiografia','2','10');

-- ARREGLAR
INSERT INTO workcalendar VALUES
('5000000000000000001','1000000000000000002','monday','09:00','17:00','13:00','13:30'),
('5000000000000000002','1000000000000000002','wednesday','09:00','17:00','13:00','13:30'),
('5000000000000000003','1000000000000000002','friday','09:00','14:00','NULL','NULL'),
('5000000000000000004','1000000000000000003','tuesday','10:00','18:00','13:00','13:30'),
('5000000000000000005','1000000000000000003','thursday','10:00','18:00','13:00','13:30');

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


--- ARREGLAR INERSIONES
-- EJEMPLO:
-- INSERT INTO reservation VALUES (
-- '6000000000000000001',   '1000000000000000002', 'consulta medica', 30, 'wanda maximoff', '2026-07-10', '09:00', '', 'viewed', '3000000000000000001'
-- );

-- ARREGLAR
INSERT INTO reservation VALUES
('6000000000000000001','1000000000000000002','consulta medica','30','wanda maximoff','2026','07','10','09:00','','viewed','3000000000000000001'),
('6000000000000000002','1000000000000000002','ecografia','15','wanda maximoff','2026','07','10','10:00','control','checked','3000000000000000002'),
('6000000000000000003','1000000000000000003','evaluacion quirurgica','20','thor odinson','2026','07','11','10:00','urgente','viewed','3000000000000000003');

-- ARREGLAR
INSERT INTO medicalhistory VALUES
('8000000000000000001','3000000000000000001','1000000000000000002','dra. natasha romanoff','medico','m','dolor de cabeza recurrente','cefalea tensional','ibuprofeno 400mg c/8h por 5 dias','2026-07-10','09:30'),
('8000000000000000002','3000000000000000002','1000000000000000002','dra. natasha romanoff','medico','m','control de embarazo','embarazo 20 semanas sin complicaciones','acido folico, control en 4 semanas','2026-07-10','10:15');

INSERT INTO session VALUES
('7000000000000000001','1','2c8ecf4a0331ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffff');

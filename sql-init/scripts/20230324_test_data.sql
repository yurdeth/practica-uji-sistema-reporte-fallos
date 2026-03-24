\echo 'Limpiando datos previos...'

TRUNCATE TABLE reportes_fallos, tecnicos, pizarras
RESTART IDENTITY CASCADE;

\echo 'Insertando datos de prueba...'

INSERT INTO pizarras (ubicacion, estado)
VALUES
('Aula 101', 'Operativa'),
('Aula 102', 'Operativa');

INSERT INTO tecnicos (nombre, especialidad)
VALUES
('Carlos Ruiz', 'Hardware'),
('Ana Lopez', 'Electronica');

\echo 'Probando trigger...'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
(CURRENT_DATE, 'No enciende', 1, 1, 3),
(CURRENT_DATE, 'Pantalla dañada', 2, 2, 5);

SELECT * FROM pizarras;

\echo 'Probando ON DELETE SET NULL...'

DELETE FROM tecnicos WHERE id_tecnico = 1;

SELECT * FROM reportes_fallos;

\echo 'Probando ON DELETE CASCADE...'

DELETE FROM pizarras WHERE id_pizarra = 2;

SELECT * FROM reportes_fallos;
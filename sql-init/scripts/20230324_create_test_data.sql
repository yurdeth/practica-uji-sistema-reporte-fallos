\echo 'Limpiando datos previos'

TRUNCATE TABLE reportes_fallos, tecnicos, pizarras
RESTART IDENTITY CASCADE;

\echo 'Insertando pizarras operativas'

INSERT INTO pizarras (ubicacion, estado)
VALUES
('Aula 101', 'Operativa'),
('Aula 102', 'Operativa');

\echo 'Insertando técnicos'

INSERT INTO tecnicos (nombre, especialidad)
VALUES
('Carlos Ruiz', 'Hardware'),
('Ana Lopez', 'Electronica');

\echo 'Probando trigger al insertar reporte'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
(CURRENT_DATE, 'No enciende', 1, 1, 3);

\echo 'Verificando que el estado cambio a En Reparacion'

SELECT id_pizarra, ubicacion, estado FROM pizarras WHERE id_pizarra = 1;

\echo 'Probando CHECK de nivel_prioridad con valor invalido'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
(CURRENT_DATE, 'Prueba valor invalido', 1, 2, 6);

\echo 'Probando CHECK de estado con valor invalido'

INSERT INTO pizarras (ubicacion, estado)
VALUES
('Aula 103', 'EstadoInvalido');

\echo 'Insertando segundo reporte con prioridad maxima'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
(CURRENT_DATE, 'Pantalla dañada', 2, 2, 5);

\echo 'Reportes de fallos creados'

SELECT id_reporte, fecha, descripcion, id_tecnico, nivel_prioridad FROM reportes_fallos;

\echo 'Probando ON DELETE SET NULL al eliminar tecnico'

DELETE FROM tecnicos WHERE id_tecnico = 1;

\echo 'Verificando que id_tecnico quedo en NULL'

SELECT id_reporte, descripcion, id_tecnico FROM reportes_fallos WHERE id_reporte = 1;

\echo 'Probando ON DELETE CASCADE al eliminar pizarra'

DELETE FROM pizarras WHERE id_pizarra = 2;

\echo 'Verificando que el reporte fue eliminado en cascada'

SELECT COUNT(*) AS reportes_restantes FROM reportes_fallos;

\echo 'Verificando triggers creados'

SELECT tgname AS nombre_trigger FROM pg_trigger WHERE tgname LIKE '%pizarra%';

\echo 'Verificando indices creados'

SELECT indexname AS nombre_indice FROM pg_indexes WHERE tablename = 'reportes_fallos';

\echo 'Verificando comentario en tabla tecnicos'

SELECT SUBSTRING(obj_description('tecnicos'::regclass), 1, 80) AS comentario_tabla;

\echo 'Verificando comentario en columna estado de pizarras'

SELECT SUBSTRING(col_description('pizarras'::regclass, attnum), 1, 80) AS comentario_columna
FROM pg_attribute
WHERE attrelid = 'pizarras'::regclass AND attname = 'estado';

\echo 'Pruebas completadas....'

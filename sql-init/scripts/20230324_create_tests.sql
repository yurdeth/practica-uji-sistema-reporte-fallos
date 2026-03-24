\echo 'Iniciando pruebas del sistema'

\echo 'Estado actual de pizarras (antes de pruebas)'

SELECT id_pizarra, ubicacion, estado FROM pizarras;

\echo 'Reportes de fallos registrados'

SELECT id_reporte, fecha, descripcion, id_tecnico, nivel_prioridad FROM reportes_fallos;

\echo 'Prueba 1: Trigger de actualizacion de estado'

\echo 'Insertando nuevo reporte para probar trigger'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
(CURRENT_DATE, 'Fallo en sistema operativo', 6, 3, 4);

\echo 'Verificando que el estado de la pizarra cambio a En Reparacion'

SELECT id_pizarra, ubicacion, estado FROM pizarras WHERE id_pizarra = 6;

\echo 'Prueba 2: CHECK de nivel_prioridad'

\echo 'Intentando insertar prioridad invalida (valor 6)'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
(CURRENT_DATE, 'Prueba prioridad invalida', 1, 1, 6);

\echo 'Prueba 3: CHECK de estado en pizarras'

\echo 'Intentando insertar estado invalido'

INSERT INTO pizarras (ubicacion, estado)
VALUES
('Aula 401', 'EstadoInvalido');

\echo 'Prueba 4: ON DELETE SET NULL'

\echo 'Eliminando tecnico Carlos Ruiz (id 1)'

DELETE FROM tecnicos WHERE id_tecnico = 1;

\echo 'Verificando que sus reportes quedaron con tecnico NULL'

SELECT id_reporte, descripcion, id_tecnico FROM reportes_fallos
WHERE id_tecnico IS NULL;

\echo 'Prueba 5: ON DELETE CASCADE'

\echo 'Eliminando pizarra Aula 102 (id 2)'

DELETE FROM pizarras WHERE id_pizarra = 2;

\echo 'Verificando que sus reportes fueron eliminados en cascada'

SELECT COUNT(*) AS reportes_restantes FROM reportes_fallos;

\echo 'Prueba 6: Verificacion de objetos creados'

\echo 'Triggers creados en el sistema'

SELECT tgname AS nombre_trigger FROM pg_trigger WHERE tgname LIKE '%pizarra%';

\echo 'Indices creados para reportes_fallos'

SELECT indexname AS nombre_indice FROM pg_indexes WHERE tablename = 'reportes_fallos';

\echo 'Comentario en tabla tecnicos'

SELECT SUBSTRING(obj_description('tecnicos'::regclass), 1, 70) AS comentario_tabla;

\echo 'Comentario en columna estado de pizarras'

SELECT SUBSTRING(col_description('pizarras'::regclass, attnum), 1, 70) AS comentario_columna
FROM pg_attribute
WHERE attrelid = 'pizarras'::regclass AND attname = 'estado';

\echo 'Pruebas completadas'

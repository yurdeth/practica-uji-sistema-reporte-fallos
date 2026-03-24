\echo 'Creando datos de prueba para el sistema'

\echo 'Insertando pizarras'

INSERT INTO pizarras (ubicacion, estado)
VALUES
('Aula 101 - Edificio A', 'Operativa'),
('Aula 102 - Edificio A', 'Operativa'),
('Aula 201 - Edificio B', 'Operativa'),
('Aula 202 - Edificio B', 'Operativa'),
('Aula 301 - Lab Computacion 1', 'Operativa'),
('Sala de conferencias', 'Operativa'),
('Aula 401 - Edificio C', 'Operativa');

\echo 'Insertando técnicos'

INSERT INTO tecnicos (nombre, especialidad)
VALUES
('Carlos Ruiz', 'Hardware'),
('Ana Lopez', 'Electronica'),
('Miguel Torres', 'Software'),
('Laura Garcia', 'Redes'),
('Pedro Martin', 'Hardware');

\echo 'Insertando reportes de fallos'

INSERT INTO reportes_fallos (fecha, descripcion, id_pizarra, id_tecnico, nivel_prioridad)
VALUES
('2026-03-20', 'Pantalla no responde', 1, 1, 3),
('2026-03-21', 'Sin conexion a internet', 2, 4, 2),
('2026-03-22', 'No enciende', 3, 1, 5),
('2026-03-23', 'Teclado no funciona', 4, 2, 3),
('2026-03-24', 'Problema de resolucion', 5, 3, 2);

\echo 'Datos de prueba insertados correctamente'

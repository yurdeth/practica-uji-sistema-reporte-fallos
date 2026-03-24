-- Este archivo es el punto de entrada único para la creación de todos los objetos de la base de datos y el mismo se ejecuta al levantar el contenedor por primera vez

-- Ejecución manual: docker exec -it postgres17 psql -U postgres -d sistema_reporte_fallos -f /docker-entrypoint-initdb.d/main.sql

\i /docker-entrypoint-initdb.d/20230323_create_tablas.sql

\i /docker-entrypoint-initdb.d/20230324_create_triggers.sql

\i /docker-entrypoint-initdb.d/20230324_create_alter.sql

\i /docker-entrypoint-initdb.d/20230324_create_indices.sql

\i /docker-entrypoint-initdb.d/20230324_create_script_mantenimiento.sql

\i /docker-entrypoint-initdb.d/20230324_create_metadatos.sql
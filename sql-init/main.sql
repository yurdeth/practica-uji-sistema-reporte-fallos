\echo 'Iniciando instalacion del sistema'

\i /docker-entrypoint-initdb.d/scripts/20230323_create_tablas.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_triggers.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_alter.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_indices.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_script_mantenimiento.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_metadatos.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_insert_data.sql

\i /docker-entrypoint-initdb.d/scripts/20230324_create_tests.sql
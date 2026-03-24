\echo 'Modificando esquema: agregando nivel_prioridad...'

ALTER TABLE reportes_fallos
    ADD COLUMN nivel_prioridad NUMERIC(1, 0);

ALTER TABLE reportes_fallos
    ADD CONSTRAINT chk_nivel_prioridad
        CHECK (nivel_prioridad BETWEEN 1 AND 5);

\echo 'Se crearon las atleraciones.....'

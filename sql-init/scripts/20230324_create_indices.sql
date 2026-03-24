\echo 'Creando índices de optimización...'

CREATE INDEX idx_reportes_fallos_fecha
    ON reportes_fallos (fecha);

CREATE INDEX idx_reportes_fallos_tecnico
    ON reportes_fallos (id_tecnico);

-- Análisis de Impacto en el Planificador de Consultas:
-- Estos índices ayudan al planificador de consultas a localizar más rápido los registros cuando se filtra por fecha o por técnico. En lugar de revisar toda la tabla (llamado Sequential Scan), PostgreSQL puede usar un acceso más directo (Index Scan)
-- La desventaja es que cada inserción, actualización o borrado cuesta un poco más, porque el sistema también debe mantener estos índices actualizados
-- El administrador o la persona acargo debe equilibrar la velocidad de lectura contra el costo adicional en operaciones de escritura

\echo 'Se crearon los índices......'

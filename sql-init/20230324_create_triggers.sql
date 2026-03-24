\echo 'Creando función y trigger de actualización de estado...'

CREATE OR REPLACE FUNCTION actualizar_estado_pizarra()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE pizarras
    SET estado = 'En Reparación'
    WHERE id_pizarra = NEW.id_pizarra;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_actualizar_estado_pizarra
    AFTER INSERT
    ON reportes_fallos
    FOR EACH ROW
EXECUTE FUNCTION actualizar_estado_pizarra();

-- Justificación:
-- FOR EACH ROW: se usa porque cada inserción representa un reporte individual y se necesita actuar sobre la pizarra específica de esa fila
-- AFTER INSERT: es preferible porque primero debe quedar registrado el reporte correctamente y después actualizar la pizarra. Así se evita intervenir antes de que la fila exista y se mantiene coherencia entre ambas tablas

\echo 'Se crearon los triggers........'

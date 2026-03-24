\echo 'Ejecutando mantenimiento VACUUM ANALYZE...'

VACUUM (ANALYZE) reportes_fallos;

-- Justificación del uso de VACUUM ANALYZE:
-- En entornos con alta rotación de datos (inserciones masivas y borrados de históricos), se produce fragmentación física o "tuplas muertas" que degradan el rendimiento. VACUUM ANALYZE combate ambos problemas en una sola operación

\echo 'Se ejecutó el mantenimiento.....'

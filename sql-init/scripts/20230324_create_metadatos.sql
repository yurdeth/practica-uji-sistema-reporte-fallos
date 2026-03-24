\echo 'Agregando comentarios de metadatos...'

COMMENT ON TABLE tecnicos IS
    'Tabla que almacena los técnicos responsables del mantenimiento y reparación de pizarras electrónicas';

COMMENT ON COLUMN pizarras.estado IS
    'Estado operativo de la pizarra: Operativa, En Reparación o Fuera de Servicio';

\echo 'Se agregaron os metadatos.....'
\echo 'ejecución exitosa'

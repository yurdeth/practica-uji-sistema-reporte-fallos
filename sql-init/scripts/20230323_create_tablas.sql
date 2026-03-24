\echo 'Creando tablas...'

CREATE TABLE pizarras
(
    id_pizarra SERIAL PRIMARY KEY,
    ubicacion  VARCHAR(50) NOT NULL,
    estado     VARCHAR(20) NOT NULL,
    CONSTRAINT chk_pizarras_estado
        CHECK (estado IN ('Operativa', 'En Reparación', 'Fuera de Servicio'))
);

CREATE TABLE tecnicos
(
    id_tecnico   SERIAL PRIMARY KEY,
    nombre       VARCHAR(50) NOT NULL,
    especialidad VARCHAR(50) NOT NULL
);

CREATE TABLE reportes_fallos
(
    id_reporte  SERIAL PRIMARY KEY,
    fecha       DATE        NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    id_pizarra  INT         NOT NULL,
    id_tecnico  INT         NULL,

    CONSTRAINT fk_reportes_pizarras
        FOREIGN KEY (id_pizarra)
            REFERENCES pizarras (id_pizarra)
            ON DELETE CASCADE,

    CONSTRAINT fk_reportes_tecnicos
        FOREIGN KEY (id_tecnico)
            REFERENCES tecnicos (id_tecnico)
            ON DELETE SET NULL
);

\echo 'Se rearon las tablas ......'

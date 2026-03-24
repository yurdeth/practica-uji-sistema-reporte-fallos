# Sistema de Reporte de Fallos en Pizarras Electrónicas - UJI

**Departamento de Ingeniería y Arquitectura**

---

## Requisitos Previos

- Docker
- Docker Compose
- Git (para clonar el repositorio)

---

## Instalación y Ejecución

### 1. Clonar el Repositorio

```bash
git clone https://github.com/yurdeth/practica-uji-sistema-reporte-fallos.git
cd practica-uji-sistema-reporte-fallos
```

### 2. Levantar los Servicios

```bash
docker compose up -d
```

Este comando iniciará dos contenedores:
- **postgres17**: PostgreSQL 17 en el puerto 5434
- **pgadmin**: Interfaz web de administración en el puerto 5050

### 3. Verificar que los Contenedores Están Corriendo

```bash
docker compose ps
```

Se debería ver algo como:
```
NAME                IMAGE              STATUS
postgres17          postgres:17        Up
pgadmin            dpage/pgadmin4     Up
```

---

## Acceso a la Base de Datos

### Mediante pgAdmin (Interfaz Web)

1. Abrir el navegador en: http://localhost:5050
2. Iniciar sesión:
   - **Email**: admin@admin.com
   - **Contraseña**: admin123
3. Agregar un nuevo servidor con las siguientes credenciales:

| Campo | Desde dentro del contenedor (pgAdmin en Docker) | Desde fuera del contenedor (acceso externo) |
|-------|--------------------------------------------------|-----------------------------------------------|
| **Nombre** | PostgreSQL 17 (o el nombre que se prefiera) | PostgreSQL 17 (o el nombre que se prefiera) |
| **Host** | postgres17 | localhost |
| **Puerto** | 5432 | 5434 |
| **Usuario** | postgres | postgres |
| **Contraseña** | admin123 | admin123 |
| **Base de datos** | sistema_reporte_fallos | sistema_reporte_fallos |

**Nota**: pgAdmin se ejecuta dentro del contenedor Docker, por lo que debe usar `postgres17` como host y el puerto interno `5432`. Si se conecta desde fuera del contenedor (por ejemplo, desde otra aplicación en el host), use `localhost` y el puerto mapeado `5434`.

---

## Ejecución Manual de Scripts (si es necesario)

**Nota:** Al levantar los servicios por primera vez, el archivo `main.sql` se ejecuta automáticamente y crea todas las tablas, triggers, índices y demás objetos de la base de datos. No es necesario ejecutarlo manualmente a menos que se detecte que los objetos no se crearon correctamente.

Si por alguna razón los scripts no se ejecutaron automáticamente al iniciar los contenedores, se pueden ejecutar manualmente:

```bash
# Ejecutar el script principal en la base de datos especificada
docker exec -it postgres17 psql -U postgres -d sistema_reporte_fallos -f /docker-entrypoint-initdb.d/main.sql
```

**Nota:** El parámetro `-d sistema_reporte_fallos` especifica la base de datos donde se ejecutará el script. Para ejecutarlo en una base de datos diferente, primero debe estar creada. Por ejemplo, para usar una base de datos llamada `midb`:

```bash
# Crear la base de datos primero (si no existe)
docker exec -it postgres17 psql -U postgres -c "CREATE DATABASE midb;"

# Luego ejecutar el script en esa base de datos
docker exec -it postgres17 psql -U postgres -d midb -f /docker-entrypoint-initdb.d/main.sql
```

---

## Verificar que el Sistema Funciona Correctamente

Una vez dentro de la base de datos, se pueden ejecutar las siguientes consultas para verificar que el sistema se creó correctamente:

### Comandos de psql (solo consola)

```sql
-- Ver las tablas creadas
\dt

-- Ver la estructura detallada de una tabla
\d+ reportes_fallos
```

### Consultas SQL (funcionan en psql y pgAdmin)

```sql
-- Ver los triggers creados
SELECT tgname FROM pg_trigger WHERE tgname LIKE '%pizarra%';

-- Ver los índices creados
SELECT indexname FROM pg_indexes WHERE tablename = 'reportes_fallos';

-- Ver los comentarios de metadatos de la tabla
SELECT obj_description('tecnicos'::regclass);

-- Ver los comentarios de metadatos de la columna
SELECT col_description('pizarras'::regclass, attnum)
FROM pg_attribute
WHERE attrelid = 'pizarras'::regclass
  AND attname = 'estado';
```

**Nota:** Los comandos que comienzan con barra invertida (`\`) son comandos meta de psql y solo funcionan en la consola. Las consultas SQL estándar funcionan tanto en psql como en pgAdmin.

---

## Estructura de Scripts SQL

| Archivo | Descripción |
|---------|-------------|
| `main.sql` | Punto de entrada único que llama a todos los demás scripts |
| `20230324_create_tablas.sql` | Crea las tablas: pizarras, tecnicos, reportes_fallos |
| `20230324_create_trigger.sql` | Crea función PL/pgSQL y trigger de actualización de estado |
| `20230324_alter_table.sql` | Agrega columna nivel_prioridad con restricción CHECK |
| `20230324_create_indices.sql` | Crea índices para optimizar consultas |
| `20230324_create_script_mantenimiento.sql` | Ejecuta VACUUM ANALYZE para mantenimiento |
| `20230324_create_metadatos.sql` | Agrega comentarios COMMENT ON al esquema |
| `20230324_test_data.sql` | Inserta datos de prueba y valida trigger, ON DELETE SET NULL y CASCADE |
CREATE TABLE carrera(
  id VARCHAR(4) PRIMARY KEY,
  descripcion VARCHAR(50) NOT NULL
);

    CREATE TABLE alumnos (
        matricula VARCHAR(20) PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );
CREATE TABLE estudiante(
  matricula VARCHAR(7) PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  id_carrera VARCHAR(4) REFERENCES carrera(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    NOT NULL,
  correo VARCHAR(50) NOT NULL
);

    CREATE TABLE maestros (
        id_maestro SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );
CREATE TABLE profesor(
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  correo VARCHAR(50) NOT NULL
);

    CREATE TABLE grupos (
        periodo VARCHAR(10) NOT NULL,
        seccion VARCHAR(10) NOT NULL,
        nombre_grupo VARCHAR(50) NOT NULL,
        id_maestro INTEGER NOT NULL,
        PRIMARY KEY (periodo, seccion),
        FOREIGN KEY (id_maestro) REFERENCES maestros(id_maestro)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
    );
CREATE TABLE materia(
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(100) NOT NULL,
  semestre INTEGER NOT NULL
);

    CREATE TABLE inscripciones (
        matricula VARCHAR(20) NOT NULL,
        periodo VARCHAR(10) NOT NULL,
        seccion VARCHAR(10) NOT NULL,
        fecha_inscripcion DATE NOT NULL,
        FOREIGN KEY (matricula) REFERENCES alumnos(matricula)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (periodo, seccion) REFERENCES grupos(periodo, seccion)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        PRIMARY KEY (matricula, periodo, seccion)
    );

    CREATE TABLE asistencia (
        matricula VARCHAR(20) NOT NULL,
        periodo VARCHAR(10) NOT NULL,
        seccion VARCHAR(10) NOT NULL,
        fecha_hora TIMESTAMP NOT NULL,
        presente BOOLEAN NOT NULL,
        FOREIGN KEY (matricula) REFERENCES alumnos(matricula)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        FOREIGN KEY (periodo, seccion) REFERENCES grupos(periodo, seccion)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
        PRIMARY KEY (matricula, periodo, seccion, fecha_hora)
    );

CREATE TABLE grupo(
  id VARCHAR(4) NOT NULL,
  id_profesor INTEGER REFERENCES profesor(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    NOT NULL,
  id_materia INTEGER REFERENCES materia(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    NOT NULL,
  id_carrera VARCHAR(4) REFERENCES carrera(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    NOT NULL,
  periodo VARCHAR(6) NOT NULL,
  PRIMARY KEY(id,periodo)
--s38a, s38e, t41a, t48a
);

CREATE TABLE inscripcion(
  id_estudiante VARCHAR(7) REFERENCES estudiante(matricula)
    ON DELETE CASCADE
    ON UPDATE CASCADE
    NOT NULL,
  id_grupo VARCHAR(4) NOT NULL,
  periodo VARCHAR(6) NOT NULL,
  FOREIGN KEY(id_grupo, periodo) REFERENCES grupo(id,periodo)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  PRIMARY KEY(id_estudiante,id_grupo,periodo)
);

CREATE TABLE asistencia(
  id_estudiante VARCHAR(7) NOT NULL,
  id_grupo VARCHAR(4) NOT NULL,
  periodo VARCHAR(6) NOT NULL,
  asistencia TIMESTAMP NOT NULL,
  presente BOOLEAN NOT NULL DEFAULT false,
  FOREIGN KEY(id_estudiante,id_grupo,periodo) REFERENCES inscripcion(id_estudiante,id_grupo,periodo)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  PRIMARY KEY(id_estudiante,id_grupo,periodo,asistencia)
);

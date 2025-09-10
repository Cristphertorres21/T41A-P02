import psycopg2
import pytest

@pytest.fixture(scope="module")
def db_connection():
    conn = psycopg2.connect(
        dbname="test_db",
        user="postgres",
        password="postgres",
        host="localhost",
        port="5432"
      )
    yield conn
    conn.close()

def test_alumnos_insertados(db_connection):

def test_carreras_insertadas(db_connection):
    with db_connection.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM carrera;")
        count = cur.fetchone()[0]
        assert count == 6

def test_estudiantes_insertados(db_connection):
    with db_connection.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM alumnos;")
        cur.execute("SELECT COUNT(*) FROM estudiante;")
        count = cur.fetchone()[0]
        assert count == 10

def test_maestros_insertados(db_connection):
def test_profesores_insertados(db_connection):
    with db_connection.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM profesor;")
        count = cur.fetchone()[0]
        assert count == 10

def test_materias_insertadas(db_connection):
    with db_connection.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM maestros;")
        cur.execute("SELECT COUNT(*) FROM materia;")
        count = cur.fetchone()[0]
        assert count == 10

def test_grupos_insertados(db_connection):
    with db_connection.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM grupos;")
        cur.execute("SELECT COUNT(*) FROM grupo;")
        count = cur.fetchone()[0]
        assert count == 10

def test_inscripciones_insertados(db_connection):
    with db_connection.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM inscripciones;")
        cur.execute("SELECT COUNT(*) FROM inscripcion;")
        count = cur.fetchone()[0]
        assert count == 10  

@@ -47,12 +59,11 @@ def test_structure(db_connection):
    sql = ''' 
            SELECT tablename FROM pg_tables 
            WHERE tablename 
            IN ('alumnos', 'maestros', 'grupos',
            'inscripciones', 'asistencia');
            IN ('carrera','estudiante', 'profesor', 'materia', 'grupo',
            'inscripcion', 'asistencia');
          '''
    expected_tables = {'alumnos', 'maestros',
                       'grupos', 'inscripciones',
                       'asistencia'}
    expected_tables = {'carrera','estudiante', 'profesor', 'materia', 'grupo',
            'inscripcion', 'asistencia'}
    with db_connection.cursor() as cur:
        cur.execute(sql)
        result_tables = {row[0] for row in cur.fetchall()}
        msg = f'''Expected tables {expected_tables},
              but found {result_tables}'''
        assert result_tables == expected_tables, msg

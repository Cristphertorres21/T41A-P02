  SELECT g.periodo, g.seccion, g.nombre_grupo,
           COUNT(*) FILTER (WHERE a.presente = FALSE) AS total_faltas
    FROM asistencia a
    JOIN grupos g ON a.periodo = g.periodo AND a.seccion = g.seccion
    GROUP BY g.periodo, g.seccion, g.nombre_grupo
    ORDER BY g.seccion;
SELECT asistencia.id_estudiante,e.nombre,asistencia.id_grupo,asistencia.periodo,m.descripcion,
COUNT(*) FILTER (WHERE asistencia.presente=false) AS total_faltas
FROM asistencia
JOIN estudiante e on asistencia.id_estudiante=e.matricula
JOIN grupo g on asistencia.id_grupo=g.id
JOIN materia m on  g.id_materia=m.id
GROUP BY asistencia.id_estudiante,e.nombre,asistencia.id_grupo,asistencia.periodo,m.descripcion
ORDER BY id_estudiante;

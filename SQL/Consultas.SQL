--------comandos de uso para SQL------


---------------------------------------------1. Comandos de Selección de Datos-----------------------------

  --SELECT:  Recupera datos de una o más tablas.---
  SELECT columna1, columna2 FROM tabla;

---SELECT DISTINCT: Recupera valores únicos (elimina duplicados).-----
SELECT DISTINCT columna FROM tabla;

----WHERE: Filtra los resultados basados en una condición.-----
SELECT * FROM tabla WHERE columna = valor;

---ORDER BY: Ordena los resultados (ascendente o descendente).--
SELECT * FROM tabla ORDER BY columna ASC;
SELECT * FROM tabla ORDER BY columna DESC;

----LIMIT: Limita el número de filas devueltas---
SELECT * FROM tabla LIMIT ;

---GROUP BY: Agrupa filas que tienen los mismos valores en columnas especificadas.--
SELECT columna, COUNT(*) 
FROM tabla 
GROUP BY columna;

--HAVING: Filtra los resultados después de agrupar--
SELECT columna, SUM(columna2)
FROM tabla
GROUP BY columna 
HAVING SUM(columna2) > 1000;


---------------------------------------------------2. Comandos de Inserción de Datos-------------------------------------------

----INSERT INTO: Inserta nuevos registros en una tabla---
INSERT INTO tabla (columna1, columna2) 
VALUES (valor1, valor2);

----INSERT INTO con varias filas:-----
INSERT INTO tabla (columna1, columna2)
VALUES (valor1, valor2), (valor3, valor4);



---------------------------------------------------3. Comandos de Actualización de Datos-----------------------------------------

---UPDATE: Actualiza registros existentes en una tabla.--


UPDATE tabla 
SET columna1 = valor1, columna2 = valor2 
WHERE ID = 1


--------------------------------------------------4. Comandos de Eliminación de Datos----------------------------------------------

-----DELETE: Elimina registros de una tabla.----
DELETE FROM tabla 
WHERE ID = 1;

--------------------------------------------------5.Comandos para Crear Tablas y Bases de Datos--------------------------------------

---CREATE DATABASE: Crea una nueva base de datos---
CREATE DATABASE nombre_basedatos;


----CREATE TABLE: Crea una nueva tabla en la base de datos.-----

CREATE TABLE nombre_tabla (
    columna1 tipo_dato,
    columna2 tipo_dato
);


-----------------------------------------------------6. Comandos para Modificar Tablas-------------------------------------------------

----ALTER TABLE: Modifica una tabla existente.---
ALTER TABLE nombre_tabla ADD columna tipo_dato;

                ---Añadir una columna:---           
                ALTER TABLE nombre_tabla ADD columna tipo_dato;
                
                --Eliminar una columna:--
                ALTER TABLE nombre_tabla DROP COLUMN columna;


----------------------------------------------------7. Comandos de Eliminación de Tablas y Bases de Datos---------------------------------

------DROP TABLE: Elimina una tabla.---
DROP TABLE nombre_tabla;

----DROP DATABASE: Elimina una base de datos.---
DROP DATABASE nombre_basedatos;


-----------------------------------------------------8. Comandos para Relaciones Entre Tablas (Joins)---------------------------------------

---INNER JOIN: Devuelve filas que tienen coincidencias en ambas tablas.---
SELECT tabla1.columna1, tabla2.columna2
FROM tabla1
INNER JOIN tabla2 ON tabla1.columna = tabla2.columna;

-----LEFT JOIN: Devuelve todas las filas de la tabla de la izquierda, incluso si no hay coincidencias en la tabla de la derecha.---
SELECT tabla1.columna1, tabla2.columna2
FROM tabla1
LEFT JOIN tabla2 ON tabla1.columna = tabla2.columna;

----RIGHT JOIN: Devuelve todas las filas de la tabla de la derecha, incluso si no hay coincidencias en la tabla de la izquierda.---
SELECT tabla1.columna1, tabla2.columna2
FROM tabla1
RIGHT JOIN tabla2 ON tabla1.columna = tabla2.columna;

---FULL OUTER JOIN: Devuelve filas cuando hay una coincidencia en una de las tablas.--
SELECT tabla1.columna1, tabla2.columna2
FROM tabla1
FULL OUTER JOIN tabla2 ON tabla1.columna = tabla2.columna;


-------------------------------------------------------9. Comandos de Agregación-------------------------------------------------------------

---COUNT(): Devuelve el número de filas.---

SELECT COUNT(*) FROM tabla;

---SUM(): Devuelve la suma total de una columna numérica.----
SELECT SUM(columna) FROM tabla;

---AVG(): Devuelve el valor promedio de una columna.--
SELECT AVG(columna) FROM tabla;


--MAX() y MIN(): Devuelve el valor máximo y mínimo de una columna.--

SELECT MAX(columna), MIN(columna) FROM tabla;



-----------------------------------------------------10. Comandos de Transacciones------------------------------------------------------------

-----BEGIN: Comienza una transacción.---

        ---BEGIN;-- 

----COMMIT: Confirma una transacción.---
COMMIT;

----ROLLBACK: Revierte una transacción en caso de error.---
ROLLBACK;

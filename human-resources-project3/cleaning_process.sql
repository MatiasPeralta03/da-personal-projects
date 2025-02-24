USE hrproject;


-- Revisar los tipos de datos y otros campos
-- Check the data types and other fields
DESCRIBE humanresources;		

		
SELECT * FROM humanresources LIMIT 1000;  # Fast data overview / Vista rápida de los datos


-- Renombrar Columnas para Mayor Claridad
-- Renaming Columns for Clarity 
ALTER TABLE humanresources
RENAME COLUMN `ï»¿id` to id,
RENAME COLUMN `birthdate` to birth_date,
RENAME COLUMN `jobtitle` to job_title,
RENAME COLUMN `termdate` to term_date
;


-- Verificación de Duplicados
-- Checking for Duplicates
SELECT id, first_name, last_name, birth_date, COUNT(*) as cnt
FROM humanresources
GROUP BY id, first_name, last_name, birth_date
HAVING cnt > 1;


-- Formateo de birth_date y Cambio de Tipo de Dato
-- Formatting birth_date and Changing Data Type
UPDATE humanresources
SET birth_date = CASE
	WHEN birth_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN birth_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birth_date, '%m-%d-%Y'), '%Y-m-%d')
	ELSE 
		NULL
END;

ALTER TABLE humanresources
MODIFY COLUMN birth_date DATE;


-- Formateo de hire_date y Cambio de Tipo de Dato
-- Formatting hire_date and Changing Data Type
UPDATE humanresources
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
	ELSE 
		NULL
END;

ALTER TABLE humanresources
MODIFY COLUMN hire_date DATE;


-- Eliminación de Empleados Menores de Edad (<18)
-- Removing Underage Employees (<18)
SELECT *
FROM humanresources
WHERE YEAR(birth_date) >= 2007;

DELETE 
FROM humanresources
WHERE YEAR(birth_date) >= 2007;


-- Verificación de Edad Mínima al Contratar
--  Ensuring Minimum Age at Hiring
SELECT *
FROM humanresources
WHERE TIMESTAMPDIFF(YEAR, birth_date, hire_date) < 18;

DELETE 
FROM humanresources
WHERE TIMESTAMPDIFF(YEAR, birth_date, hire_date) < 18;


-- Manejo del Formato y Valores Nulos de term_date
-- Handling term_date Formatting and Null Values
UPDATE humanresources
SET term_date = date(str_to_date(term_date, '%Y-%m-%d'))
WHERE term_date IS NOT NULL AND term_date != '';

UPDATE humanresources
SET term_date = NULL
WHERE term_date = '';

ALTER TABLE humanresources
MODIFY COLUMN term_date DATE;


-- Filtrado de Fechas de Terminación Futuras
-- Filtering Future Termination Dates
SELECT *
FROM humanresources
WHERE YEAR(term_date) > 2024;

DELETE 
FROM humanresources
WHERE YEAR(term_date) IS NOT NULL AND YEAR(term_date) > 2024;


-- Creación y Actualización de la Columna age
-- Creating and Updating Age Column
ALTER TABLE humanresources
ADD COLUMN age INT;

UPDATE humanresources 
SET age = TIMESTAMPDIFF(YEAR, birth_date, '2024-12-31');



# Vista rápida de los datos
# Fast data overview
SELECT * FROM humanresources LIMIT 10;  

-- Distribución de Género de los Empleados
-- Gender Breakdown of Employees
SELECT 
	gender, 
	COUNT(*) as genderBreakdown
FROM humanresources
WHERE term_date IS NULL
GROUP BY gender
ORDER BY genderBreakdown DESC;


-- Distribución Racial de los Empleados
-- Race Breakdown of Employees
SELECT 	
	race, 
    COUNT(*) AS raceBreakdown
FROM humanresources
WHERE term_date IS NULL
GROUP BY race
ORDER BY raceBreakdown DESC;


-- Distribución de Edad de los Empleados
-- Age Distribution of Employees
SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
		WHEN age >= 25 AND age <= 34 THEN '25-34'
		WHEN age >= 35 AND age <= 44 THEN '35-44'
		WHEN age >= 45 AND age <= 54 THEN '45-54'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
		ELSE '65+'
	END AS ageGroup,
    COUNT(*) AS cnt
FROM humanresources
WHERE term_date IS NULL
GROUP BY ageGroup
ORDER BY ageGroup DESC;


-- Sedes Principales vs. Ubicaciones Remotas
-- Headquarters vs. Remote Locations
SELECT 
	location, 
    COUNT(*) as jobLocation
FROM humanresources
WHERE term_date IS NULL
group by location
order by jobLocation DESC;


-- Promedio de Duración del Empleo para Empleados Terminados
-- Average Length of Employment for Terminated Employees
SELECT 
	ROUND(AVG(DATEDIFF(term_date, hire_date)) / 365) AS avg_length_employment
FROM humanresources
WHERE term_date IS NOT NULL;


-- Distribución de Género en Departamentos y Puestos de Trabajo
-- Gender Distribution Across Departments and Job Titles
SELECT 
	gender, 
    department, 
    count(*) AS cnt
FROM humanresources
WHERE term_date IS NULL
GROUP BY gender, department
ORDER BY gender, cnt DESC;

SELECT 
	gender, 
	job_title, 
    count(*) AS cnt
FROM humanresources
WHERE term_date IS NULL
GROUP BY gender, job_title
ORDER BY gender, cnt DESC;


-- Distribución de Puestos de Trabajo
-- Distribution of Job Titles
SELECT 
	job_title, 
    count(*) AS cnt
FROM humanresources
WHERE term_date IS NULL
GROUP BY job_title
ORDER BY cnt DESC;


-- Departamento con la Mayor Tasa de Rotación
-- Department with the Highest Turnover Rate
WITH EmployeeCounts AS (
    SELECT 
        department,
        COUNT(*) AS total_employees,
        COUNT(CASE WHEN term_date IS NOT NULL THEN 1 END) AS terminated_employees
    FROM humanresources
    GROUP BY department
)
SELECT 
    department,
    total_employees,
    terminated_employees,
    ROUND(terminated_employees * 100.0 / total_employees, 2) AS `turnover_rate(%)`
FROM EmployeeCounts
ORDER BY `turnover_rate(%)` DESC;


-- Distribución de Empleados en Ubicaciones por Ciudad y Estado
-- Distribution of Employees Across Locations by City and State
SELECT 
	location_city, 
    count(*) AS cnt
FROM humanresources
WHERE term_date IS NULL
GROUP BY location_city
ORDER BY cnt DESC;

SELECT 
    location_state, 
    COUNT(*) AS cnt
FROM humanresources
WHERE term_date IS NULL
GROUP BY location_state
ORDER BY cnt DESC;


-- Distribución de Género y Edad de los Empleados
-- Gender and Age Distribution of Employees
SELECT 
    gender,
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS ageGroup,
    COUNT(*) AS cnt
FROM
    humanresources
WHERE
    term_date IS NULL
GROUP BY gender , ageGroup
ORDER BY ageGroup ASC , cnt DESC;


-- Promedio de Tenencia por Departamento para Empleados Terminados
-- Average Tenure by Department for Terminated Employees
SELECT 
    department,
    ROUND(AVG(DATEDIFF(term_date, hire_date)) / 365, 2) AS avg_tenure_years
FROM humanresources
WHERE term_date IS NOT NULL
GROUP BY department
ORDER BY avg_tenure_years DESC;


-- Crear Índices para mejorar el rendimiento de las consultas
-- Create Indexes to improve the performance of queris
CREATE INDEX idx_term_date ON humanresources(term_date);
CREATE INDEX idx_department ON humanresources(department);


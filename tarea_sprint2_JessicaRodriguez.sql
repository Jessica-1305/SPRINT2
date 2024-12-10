SELECT * from company;
SELECT * from transaction;
DESCRIBE company;
DESCRIBE transaction;


						-- NIVEL 1--

-- Ejercicio2 Listado de los países que están realizando compras.
SELECT DISTINCT company.country AS pais
FROM company
JOIN transaction
ON company.id = transaction.company_id;


-- Ejercicio2: Desde cuántos países se realizan las compras.
SELECT COUNT(DISTINCT company.country) AS numero_paises
FROM company
JOIN transaction
ON company.id = transaction.company_id;

-- Ejercicio2: Identifica la compañía con el promedio más alto de ventas.
SELECT 
	company_name as compania,
    AVG(amount) as cantidad_media
FROM company
JOIN transaction
ON company.id = transaction.company_id
WHERE declined = false
GROUP BY compania
ORDER BY cantidad_media DESC
LIMIT 1;


-- Ejercicio 3: Muestra todas las transacciones realizadas por empresas de Alemania.
SELECT * FROM transaction
WHERE company_id IN (
	SELECT id FROM company WHERE country = 'Germany'
);

-- Ejercicio3: Lista las empresas que han realizado transacciones por un monto
-- superior al promedio de todas las transacciones.
SELECT id, company_name
FROM company 
WHERE id IN (
	SELECT company_id 
	FROM transaction 
	WHERE amount > (
		SELECT AVG(amount) 
		FROM transaction
	)
);


-- Ejercicio3: Se eliminarán del sistema las empresas que no tienen transacciones registradas,
-- entrega el listado de estas empresas.  
-- hago un select antes del delete para ver cuantas filas seran las afectadas
SELECT * FROM company
WHERE id NOT IN (
	SELECT DISTINCT company_id FROM transaction
);






					-- NIVEL 2 --
-- Ejercicio1: Identifica los cinco días en los que se generó la mayor cantidad de ingresos en la empresa por ventas. 
-- Muestra la fecha de cada transacción junto con el total de las ventas.
SELECT DATE(timestamp) AS transaction_date, SUM(amount) AS total
FROM transaction
WHERE declined = false
GROUP BY transaction_date
ORDER BY total DESC
LIMIT 5;



-- Ejercicio2: ¿Cuál es el promedio de ventas por país?
-- Presenta los resultados ordenados de mayor a menor promedio.
SELECT company.country, AVG(transaction.amount) AS average_sales
FROM transaction
JOIN company ON transaction.company_id = company.id
GROUP BY company.country
ORDER BY average_sales DESC;

-- Ejercicio3: 
-- Muestra el listado aplicando JOIN y subconsultas.
SELECT transaction.id, company.company_name, transaction.timestamp, transaction.amount
FROM transaction
INNER JOIN company ON transaction.company_id = company.id
WHERE company.country = (
	SELECT country
	FROM transactions.company
	WHERE company_name = 'Non Institute'
);

-- Muestra el listado aplicando únicamente subconsultas.
SELECT *
FROM transaction
WHERE company_id IN (
	SELECT id
	FROM transactions.company
	WHERE country = (
		SELECT country
		FROM transactions.company
		WHERE company_name = 'Non Institute'
	)
);

			-- NIVEL 3 --
-- Ejercicio1
/*
Presenta el nombre, teléfono, país, fecha y monto de aquellas empresas que realizaron
transacciones con un valor comprendido entre 100 y 200 euros y en alguna de estas fechas: 
29 de abril de 2021, 20 de julio de 2021 y 13 de marzo de 2022. 
Ordena los resultados de mayor a menor cantidad.
*/
SELECT company_name, phone, country, timestamp, amount
FROM transaction
INNER JOIN company ON transaction.company_id = company.id
WHERE transaction.amount BETWEEN 100 AND 200
AND DATE(transaction.timestamp) IN ('2021-04-29', '2021-07-20', '2022-03-13')
ORDER BY transaction.amount DESC;



-- Ejercicio 1_Nivel 1
SELECT * FROM company;
SELECT * FROM TRANSACTION; 

-- Ejercicio 2_Nivel 1
-- Llistat dels països que estan fent compres.
SELECT DISTINCT country AS Pais
FROM transaction
JOIN company ON company_id = company.id;

-- Ejercicio 2_Nivel 1
-- Des de quants països es realitzen les compres.
SELECT COUNT(DISTINCT country) AS Total_Paisos
FROM transaction
JOIN company ON company_id = company.id;

-- Ejercicio 2_Nivel 1
-- Identifica la companyia amb la mitjana més gran de vendes.
SELECT 
    company_name AS Companyia, 
   round(AVG(amount),2) AS Mitjana_Vendes
FROM transaction
JOIN company ON company_id = company.id
WHERE declined = FALSE
GROUP BY company_name
ORDER BY Mitjana_Vendes DESC
LIMIT 1;

-- Ejercicio 3_Nivel 1
-- Mostra totes les transaccions realitzades per empreses d'Alemanya

SELECT *
FROM transaction
WHERE company_id IN 
		(SELECT id FROM company WHERE country = 'Germany');

-- Ejercicio 3_Nivel 1
-- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.

SELECT DISTINCT company_id, amount 
FROM transaction
WHERE amount > (SELECT avg(amount) from transaction)
ORDER BY amount ASC;

-- Ejercicio 3_ Nivel 1
-- Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.

SELECT company_name
FROM company
WHERE NOT exists (SELECT * FROM transaction);



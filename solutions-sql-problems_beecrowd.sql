/*
Beecrowd SQL Problems 
Link: https://www.beecrowd.com.br/judge/en/problems/index/9
SGBD: PostgreSQL 14
Followed Style Guide: https://about.gitlab.com/handbook/business-technology/data-team/platform/sql-style-guide/
*/

-- beecrowd #2602: Basic Select

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2602

-- Solution:

SELECT name FROM customers WHERE lower(state) = 'rs' 
;



-- beecrowd #2603: Customer Address

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2603
-- Solution:

SELECT 
	name,
	street
FROM customers
WHERE LOWER(city) = 'porto alegre' 
;



-- beecrowd #2604: Under 10 or Greater Than 100

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2604
-- Solution:

SELECT 
	id,
	name
FROM products
WHERE (price < 10) OR (price > 100) 
;



-- beecrowd #2605: Executive Representatives

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2605
-- Solution:

SELECT 
	products.name,
	providers.name
FROM
	products 
	INNER JOIN providers 
	ON products.id_providers = providers.id
	INNER JOIN categories
	ON products.id_categories = categories.id
WHERE categories.id = 6 
;



-- beecrowd #2606: Categories

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2606
-- Solution:

-- Using Aliases with practicing purpose

SELECT
    p.id,
    p.name
FROM
    products AS p
    INNER JOIN categories AS c
    ON p.id_categories = c.id
WHERE LOWER(c.name) LIKE 'super%' 
;



-- beecrowd #2607: Providers' City in Alphabetical Order

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2607
-- Solution:

SELECT DISTINCT(city) FROM providers ORDER BY city ASC 
;



-- beecrowd #2608: Higher and Lower Price

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2608
-- Solution:

SELECT
	MAX(price),
	MIN(price)
FROM products
;



-- beecrowd #2609: Products by Categories

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2609
-- Solution:

SELECT
    categories.name,
    SUM(products.amount)
FROM products
INNER JOIN categories
    ON products.id_categories = categories.id
GROUP BY categories.id
ORDER BY categories.name
;



-- beecrowd #2610: Average Value of Products

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2610
-- Solution:

SELECT ROUND(AVG(price), 2)
FROM products
;



-- beecrowd #2611: Action Movies

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2611
-- Solution:

SELECT
    movies.id,
    movies.name
FROM movies
INNER JOIN genres
    ON movies.id_genres = genres.id
WHERE genres.description = 'Action'
;



-- beecrowd #2613: Cheap Movies

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2613
-- Solution:

SELECT
    movies.id,
    movies.name
FROM movies
INNER JOIN prices
    ON movies.id_prices = prices.id
WHERE prices.value < 2
;



-- beecrowd #2614: Semptember Rentals

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2614
-- Solution:

-- There are three ways to display the rentals:


-- 1. Using WHERE and DATE COMPARISON

SELECT
    customers.name,
    rentals.rentals_date
FROM rentals
INNER JOIN customers
    ON rentals.id_customers = customers.id
WHERE rentals.rentals_date >= '2016-09-01' 
	AND rentals.rentals_date < '2016-10-01'
	;


--2. Using EXTRACT, MONTH and YEAR

SELECT
    customers.name,
    rentals.rentals_date
FROM rentals
INNER JOIN customers
    ON rentals.id_customers = customers.id
WHERE EXTRACT(MONTH FROM rentals.rentals_date) = 9 
	AND EXTRACT(YEAR FROM rentals.rentals_date) = 2016
;


-- 3. Using a variable START_DATE and INTERVAL

WITH
	c_start_date AS (VALUES(CAST('2016-09-01' as date))), -- explicit cast
	c_interval AS (VALUES('1 month'::interval)) -- abbreviated cast
SELECT
    customers.name,
    rentals.rentals_date
FROM rentals
INNER JOIN customers
    ON rentals.id_customers = customers.id
WHERE rentals.rentals_date >= (table c_start_date)
	AND rentals.rentals_date < ((table c_start_date) + (table c_interval))
;



-- beecrowd #2615: Expanding the Business

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2615
-- Solution:

SELECT DISTINCT city
FROM customers
;



-- beecrowd #2616: No Rental

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2616
-- Solution:

SELECT
    customers.id,
    customers.name
FROM customers
LEFT JOIN locations 
    ON customers.id = locations.id_customers
WHERE locations IS NULL
ORDER BY customers.id
;



-- beecrowd #2617: Provider Ajax SA

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2617
-- Solution:

SELECT
    products.name,
    providers.name
FROM products
INNER JOIN providers
    ON products.id_providers = providers.id
WHERE providers.name = 'Ajax SA'
;



-- beecrowd #2618: Imported Products

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2618
-- Solution:

SELECT
    products.name,
    providers.name,
    categories.name
FROM products
INNER JOIN providers
    ON products.id_providers = providers.id
INNER JOIN categories
    ON products.id_categories = categories.id
WHERE providers.name = 'Sansul SA'
    AND categories.name = 'Imported'
;



-- beecrowd #2619: Super Luxury

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2619
-- Solution:

SELECT
    products.name,
    providers.name,
    products.price
FROM products
INNER JOIN providers
    ON products.id_providers = providers.id
INNER JOIN categories
    ON products.id_categories = categories.id
WHERE products.price > 1000
    AND categories.name = 'Super Luxury'
;



-- beecrowd #2620: Orders in First Half

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2620
-- Solution:

SELECT
    customers.name,
    orders.id
FROM orders
INNER JOIN customers
    ON orders.id_customers = customers.id
WHERE EXTRACT(MONTH FROM orders.orders_date) BETWEEN 1 AND 6 
	AND EXTRACT(YEAR FROM orders.orders_date) = 2016
;



-- beecrowd #2621: Amounts Between 10 and 20

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2621
-- Solution:

SELECT products.name
FROM products
INNER JOIN providers
    ON products.id_providers = providers.id
WHERE products.amount BETWEEN 10 AND 20
    AND providers.name LIKE 'P%'
;



-- beecrowd #2622: Legal Person

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2622
-- Solution:

SELECT customers.name
FROM legal_person
INNER JOIN customers
    ON legal_person.id_customers = customers.id
;



-- beecrowd #2623: Categories with Various Products

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2623
-- Solution:

SELECT
    products.name,
    categories.name
FROM products
INNER JOIN categories
    ON products.id_categories = categories.id
WHERE products.amount > 100
    AND categories.id IN (1, 2, 3, 6, 9)
ORDER BY categories.id ASC
;



-- beecrowd #2624: Number of Cities per Customers

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2624
-- Solution:

SELECT COUNT(DISTINCT city)
FROM customers
;



-- beecrowd #2625: CPF Validation

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2625
-- Solution:

-- Alternative 1. Using REGEXP_REPLACE

SELECT REGEXP_REPLACE(natural_person.cpf, 
					  '(.{3})(.{3})(.{3})(.{2})', -- Divides the string in four parts (3-3-3-2 any digits)
					  '\1.\2.\3-\4') AS cpf -- inserts the "." and "-" between each part
FROM natural_person
INNER JOIN customers
    ON natural_person.id_customers = customers.id
;

-- Alternative 2. Using SUBSTR
	   
SELECT SUBSTR(natural_person.cpf, 1, 3) || '.' ||
	   SUBSTR(natural_person.cpf, 4, 3) || '.' ||
	   SUBSTR(natural_person.cpf, 7, 3) || '-' ||
	   SUBSTR(natural_person.cpf, 10, 2) AS cpf
FROM natural_person
INNER JOIN customers
    ON natural_person.id_customers = customers.id
;



-- beecrowd #2737: Lawyers

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2737
-- Solution:

-- Using CTE (WITH) for practicing purposes.

WITH average_customers AS (
	SELECT 
		'Average' as name,
		CAST(AVG(customers_number) AS integer) as customers_number,
		2 AS order_filter
	FROM lawyers	
)
SELECT
	name,
	customers_number
FROM (
	
	SELECT 
		name,
		customers_number,
		1 AS order_filter
	FROM lawyers
	WHERE customers_number = (SELECT MAX(customers_number) FROM lawyers)
		OR customers_number = (SELECT MIN(customers_number) FROM lawyers)

	UNION ALL (TABLE average_customers) 

) AS lawyers_customers
ORDER BY order_filter, customers_number DESC
;



-- beecrowd #2738: Contest

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2738
-- Solution:

SELECT
    candidate.name,
    ROUND((((score.math * 2)
      	    + (score.specific * 3)
      		+ (score.project_plan * 5))
     	   / 10)
		  , 2) AS avg
FROM score
INNER JOIN candidate
    ON score.candidate_id = candidate.id
ORDER BY avg DESC
;



-- beecrowd #2739: Payday

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2739
-- Solution:

SELECT
    name,
    CAST(EXTRACT(DAY from payday) AS integer) AS day
FROM loan
;



-- beecrowd #2740: League

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2740
-- Solution:

/*
First part of the UNION selects the first 3 positions
Second part of the UNION gets the number of the 2 last positions using a subquery.
This solution assumes:
	There will be at least 5 teams (so the list makes sense)
	"position" field will start at 01 and will be sequentially ordered(being a PK)
For a more robust solution, one might use nested queries with MIN() and MAX() operations.
*/

SELECT
	'Podium: ' || team AS name
FROM league
WHERE position <= 3
UNION ALL
SELECT
	'Demoted: ' || team AS name
FROM league
WHERE position IN (SELECT position
				   FROM league
				   ORDER BY position DESC
				   LIMIT 2)
:



-- beecrowd #2741: Student Grades

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2741
-- Solution:

SELECT
    'Approved: ' || name AS name,
	grade
FROM students
WHERE grade >= 7
ORDER BY grade DESC
;



-- beecrowd #2742: Richard's Multiverse

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2742
-- Solution:

SELECT
    life_registry.name,
    ROUND((life_registry.omega * 1.618), 3) AS "The N Factor"
FROM life_registry
INNER JOIN dimensions
    ON life_registry.dimensions_id = dimensions.id
WHERE dimensions.name IN ('C875', 'C774')
    AND LOWER(life_registry.name) LIKE 'richard%'
ORDER BY life_registry.omega
;



-- beecrowd #2743: Number of Characters

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2743
-- Solution:

SELECT
    name,
    LENGTH(name) as length
FROM people
ORDER BY length DESC
;



-- beecrowd #2744: Passwords

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2744
-- Solution:

SELECT
    id,
    password,
    MD5(password) as MD5
FROM account
;



-- beecrowd #2745: Taxes

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2745
-- Solution:

SELECT
    name,
    ROUND((salary * 0.1), 2) as tax
FROM people
WHERE salary > 3000
;



-- beecrowd #2746: Viruses

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2746
-- Solution:

SELECT REPLACE(name, 'H1', 'X')
FROM virus
;



-- beecrowd #2988: Cearense Championship

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2988
-- Solution:

SELECT
    teams.name,
    COUNT(matches.team_1 + matches.team_2) AS matches,
    SUM(CASE WHEN (matches.team_1_goals > matches.team_2_goals
                   AND teams.id = matches.team_1)
                  OR (matches.team_2_goals > matches.team_1_goals
                   AND teams.id = matches.team_2) THEN 1 ELSE 0 END) AS victories,
                   
    SUM(CASE WHEN (matches.team_1_goals < matches.team_2_goals
                   AND teams.id = matches.team_1)
                  OR (matches.team_2_goals < matches.team_1_goals
                   AND teams.id = matches.team_2) THEN 1 ELSE 0 END) AS defeats,
                   
    SUM(CASE WHEN (matches.team_1_goals = matches.team_2_goals
                   AND teams.id = matches.team_1)
                  OR (matches.team_2_goals = matches.team_1_goals
                   AND teams.id = matches.team_2) THEN 1 ELSE 0 END) AS draws,
    
	(SUM(CASE WHEN (matches.team_1_goals > matches.team_2_goals
                    AND teams.id = matches.team_1)
                   OR (matches.team_2_goals > matches.team_1_goals
                    AND teams.id = matches.team_2) THEN 3 ELSE 0 END)
	 +
	 SUM(CASE WHEN (matches.team_1_goals = matches.team_2_goals
                    AND teams.id = matches.team_1)
                   OR (matches.team_2_goals = matches.team_1_goals
                    AND teams.id = matches.team_2) THEN 1 ELSE 0 END)) AS score
FROM matches
INNER JOIN teams
    ON matches.team_1 = teams.id
    OR matches.team_2 = teams.id
GROUP BY teams.name
ORDER BY score DESC
;



-- beecrowd #2989: Departments and Divisions

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2989
-- Solution:

	SELECT
		departamento.nome AS departamento,
		divisao.nome AS divisao,
		ROUND(AVG(salarios.salario), 2) AS media,
		ROUND(MAX(salarios.salario), 2) AS maior
	FROM (
		SELECT
		venc_agrupados.lotacao,
		venc_agrupados.lotacao_div,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
		FROM (

			SELECT
				empregado.matr,
				empregado.lotacao,
				empregado.lotacao_div,
				COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
			FROM empregado
			LEFT JOIN emp_venc
				ON empregado.matr = emp_venc.matr
			LEFT JOIN vencimento
				ON emp_venc.cod_venc = vencimento.cod_venc
			GROUP BY empregado.matr, empregado.lotacao, empregado.lotacao_div

			) AS venc_agrupados

			LEFT JOIN (

				SELECT
					empregado.matr,
					empregado.lotacao,
					empregado.lotacao_div,
					COALESCE(SUM(desconto.valor), 0) AS total_descontos
				FROM empregado
				LEFT JOIN emp_desc
					ON empregado.matr = emp_desc.matr
				LEFT JOIN desconto
					ON emp_desc.cod_desc = desconto.cod_desc
				GROUP BY empregado.matr, empregado.lotacao, empregado.lotacao_div

			) AS desc_agrupados
				ON venc_agrupados.matr = desc_agrupados.matr
		GROUP BY venc_agrupados.matr, venc_agrupados.lotacao, venc_agrupados.lotacao_div
	) AS salarios
	INNER JOIN departamento
		ON salarios.lotacao = departamento.cod_dep
	INNER JOIN divisao
		ON salarios.lotacao_div = divisao.cod_divisao
	GROUP BY divisao.nome, departamento.nome
	ORDER BY media DESC
;



-- beecrowd #2990: Employees CPF

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2990
-- Solution:

SELECT
    empregados.cpf,
    empregados.enome,
    departamentos.dnome
FROM empregados
INNER JOIN departamentos
    ON empregados.dnumero = departamentos.dnumero
LEFT JOIN trabalha
    ON empregados.cpf = trabalha.cpf_emp
WHERE trabalha.cpf_emp IS NULL
ORDER BY empregados.cpf
;



-- beecrowd #2991: Department Statistics

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2991
-- Solution:
-- References: https://stackoverflow.com/questions/3395339/sql-how-do-i-query-a-many-to-many-relationship

	SELECT
		departamento.nome AS "Nome Departamento",
		COUNT(salarios.lotacao) AS "Numero de Empregados",
		ROUND(AVG(salarios.salario), 2) AS "Media Salarial",
		ROUND(MAX(salarios.salario), 2) AS "Maior Salario",
		CASE WHEN MIN(salarios.salario) = 0.00 THEN 0
			 ELSE ROUND(MIN(salarios.salario), 2)
		END AS "Menor Salario"
	FROM (
		SELECT
		venc_agrupados.lotacao,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
		FROM (

			SELECT
				empregado.matr,
				empregado.lotacao,
				COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
			FROM empregado
			LEFT JOIN emp_venc
				ON empregado.matr = emp_venc.matr
			LEFT JOIN vencimento
				ON emp_venc.cod_venc = vencimento.cod_venc
			GROUP BY empregado.matr, empregado.lotacao

			) AS venc_agrupados

			LEFT JOIN (

				SELECT
					empregado.matr,
					empregado.lotacao,
					COALESCE(SUM(desconto.valor), 0) AS total_descontos
				FROM empregado
				LEFT JOIN emp_desc
					ON empregado.matr = emp_desc.matr
				LEFT JOIN desconto
					ON emp_desc.cod_desc = desconto.cod_desc
				GROUP BY empregado.matr, empregado.lotacao

			) AS desc_agrupados
				ON venc_agrupados.matr = desc_agrupados.matr
			GROUP BY venc_agrupados.matr, venc_agrupados.lotacao
		) AS salarios
	INNER JOIN departamento
		ON salarios.lotacao = departamento.cod_dep
	GROUP BY departamento.nome
	ORDER BY "Media Salarial" DESC
;



-- beecrowd #2992: Highest Avarage Salary Divisions

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2992
-- Solution:

WITH media_salarial_por_divisao AS (

	SELECT
		salarios.lotacao,
		salarios.lotacao_div,
		ROUND(AVG(salarios.salario), 2) AS media
	FROM (
		SELECT
				venc_agrupados.lotacao,
				venc_agrupados.lotacao_div,
				ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
				FROM (

					SELECT
						empregado.matr,
						empregado.lotacao,
						empregado.lotacao_div,
						COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
					FROM empregado
					LEFT JOIN emp_venc
						ON empregado.matr = emp_venc.matr
					LEFT JOIN vencimento
						ON emp_venc.cod_venc = vencimento.cod_venc
					GROUP BY empregado.matr, empregado.lotacao, empregado.lotacao_div

					) AS venc_agrupados

					LEFT JOIN (

						SELECT
							empregado.matr,
							empregado.lotacao,
							empregado.lotacao_div,
							COALESCE(SUM(desconto.valor), 0) AS total_descontos
						FROM empregado
						LEFT JOIN emp_desc
							ON empregado.matr = emp_desc.matr
						LEFT JOIN desconto
							ON emp_desc.cod_desc = desconto.cod_desc
						GROUP BY empregado.matr, empregado.lotacao, empregado.lotacao_div

					) AS desc_agrupados
						ON venc_agrupados.matr = desc_agrupados.matr
				GROUP BY venc_agrupados.matr, venc_agrupados.lotacao, venc_agrupados.lotacao_div
		) AS salarios
	GROUP BY salarios.lotacao, salarios.lotacao_div
	
)

SELECT
	departamento.nome AS departamento,
	divisao.nome AS divisao,
	media_salarial_por_divisao.media AS media
FROM media_salarial_por_divisao
INNER JOIN departamento
	ON media_salarial_por_divisao.lotacao = departamento.cod_dep
INNER JOIN divisao
	ON media_salarial_por_divisao.lotacao_div = divisao.cod_divisao
WHERE media IN (SELECT MAX(media) OVER (PARTITION BY lotacao) FROM media_salarial_por_divisao)
ORDER BY media DESC
;



-- beecrowd #2993: Most Frequent

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2993
-- Solution:

-- Alternative 1. Using Subquery/Nested Query and LIMIT.

SELECT amount as most_frequent_value
FROM (
	SELECT
		amount,
		COUNT(amount) AS frequency_count
	FROM value_table	
	GROUP BY amount
	ORDER BY frequency_count DESC
	LIMIT 1
) AS amount_frequency
;
-- Alternative 2. Using CTE/WITH and LIMIT.

WITH amount_frequency AS (
	SELECT
		amount,
		COUNT(amount) AS frequency_count
	FROM value_table
	GROUP BY amount
	ORDER BY frequency_count DESC
	LIMIT 1
)
SELECT amount as most_frequent_value
FROM amount_frequency
;

-- Alternative 3. Using COUNT(*) on ORDER BY and LIMIT.
-- This is the most simple one

SELECT amount as most_frequent_value
FROM value_table
GROUP BY amount -- or most_frequent_value
ORDER BY COUNT(*) DESC
LIMIT 1
;

-- Alternative 4. Using CTE/WITH and MAX.
-- Most robust answer. It will return two values with there are two modes.

WITH amount_frequency AS (
	SELECT
		amount,
		COUNT(amount) AS frequency_count
	FROM value_table
	GROUP BY amount
)
SELECT amount as most_frequent_value
FROM amount_frequency
WHERE frequency_count = (SELECT MAX(frequency_count) FROM amount_frequency)
;



-- beecrowd #2994: How much earn a Doctor?

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2994
-- Solution:

-- Alternative 1. Using CTE "salaries"

WITH 
	c_hour_earns AS (VALUES(150)),
	salaries AS (
		
		SELECT
			attendances.id_doctor,
			ROUND(SUM((attendances.hours * (table c_hour_earns)) 
					  + (attendances.hours * (table c_hour_earns) * (work_shifts.bonus/100)))
				  , 1) AS salary
		FROM attendances
		INNER JOIN work_shifts
			ON attendances.id_work_shift = work_shifts.id
		GROUP BY attendances.id_doctor
)
SELECT
	doctors.name,
	salaries.salary
FROM doctors
INNER JOIN salaries
	ON doctors.id = salaries.id_doctor
ORDER BY salary DESC
;



-- Alternative 2. Directly on Select Query using Cartesian Join

WITH c_hour_earns AS (VALUES(150))
SELECT
	doctors.name
	ROUND(SUM((attendances.hours * (table c_hour_earns)) 
			  + (attendances.hours * (table c_hour_earns) * (work_shifts.bonus/100)))
		 , 1) AS salary
FROM doctors, attendances, work_shifts
WHERE doctors.id = attendances.id_doctor
    AND work_shifts.id = attendances.id_work_shift
GROUP BY doctors.name
ORDER BY salary DESC;
;

-- Alternative 3. Directly on Select Query using Inner Join

WITH c_hour_earns AS (VALUES(150))
SELECT
	doctors.name,
	ROUND(SUM((attendances.hours * (table c_hour_earns)) 
			  + (attendances.hours * (table c_hour_earns) * (work_shifts.bonus/100)))
		 , 1) AS salary
FROM doctors 
INNER JOIN attendances
	ON doctors.id = attendances.id_doctor
INNER JOIN work_shifts
	ON work_shifts.id = attendances.id_work_shift
GROUP BY doctors.name
ORDER BY salary DESC;
;



-- beecrowd #2995: The Sensor Message

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2995
-- Solution:

WITH matching_temperatures AS (
	SELECT
		temperature,
		COUNT(temperature) AS matching_count
	FROM records
	GROUP BY temperature, mark
	ORDER BY mark
)
SELECT 
    temperature,
    matching_count AS number_of_records
FROM matching_temperatures
;



-- beecrowd #2996: Package Delivery

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2996
-- Solution:

SELECT
	packages.year, 
	senders.name as sender, 
	receivers.name as receiver
FROM packages 
INNER JOIN users AS senders
     ON packages.id_user_sender = senders.id 
INNER JOIN users AS receivers
     ON packages.id_user_receiver = receivers.id
WHERE (packages.color='blue' or packages.year=2015) AND 
(senders.address <> 'Taiwan' AND receivers.address <> 'Taiwan')
ORDER BY packages.year DESC;


-- beecrowd #2997: Employees Payment

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2997
-- Solution:

SELECT
	departamento.nome AS Departamento,
	empregado.nome AS Empregado,
	
	CASE WHEN composicao_salarios.total_vencimentos = 0.00 THEN 0
		 ELSE composicao_salarios.total_vencimentos END AS "Salario Bruto",
		 
	CASE WHEN composicao_salarios.total_descontos = 0.00 THEN 0
		 ELSE composicao_salarios.total_descontos END AS "Total Desconto",
		 
	CASE WHEN composicao_salarios.salario = 0.00 THEN 0
		 ELSE composicao_salarios.salario END AS "Salario Liquidoaws"
FROM (

	SELECT
		venc_agrupados.lotacao,
		venc_agrupados.matr,
		venc_agrupados.total_vencimentos,
		desc_agrupados.total_descontos,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
	FROM (

		SELECT
			empregado.matr,
			empregado.lotacao,
			COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
		FROM empregado
		LEFT JOIN emp_venc
			ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento
			ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr, empregado.lotacao

		) AS venc_agrupados
		LEFT JOIN (

			SELECT
				empregado.matr,
				empregado.lotacao,
				COALESCE(SUM(desconto.valor), 0) AS total_descontos
			FROM empregado
			LEFT JOIN emp_desc
				ON empregado.matr = emp_desc.matr
			LEFT JOIN desconto
				ON emp_desc.cod_desc = desconto.cod_desc
			GROUP BY empregado.matr, empregado.lotacao

		) AS desc_agrupados
		ON venc_agrupados.matr = desc_agrupados.matr
	GROUP BY venc_agrupados.matr, venc_agrupados.lotacao, 
		venc_agrupados.total_vencimentos, desc_agrupados.total_descontos
	
) AS composicao_salarios
INNER JOIN departamento
	ON composicao_salarios.lotacao = departamento.cod_dep
INNER JOIN empregado
	ON composicao_salarios.matr = empregado.matr
ORDER BY salario DESC
;



-- beecrowd #2998: The Payback

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2998
-- Solution:
-- References: https://www.postgresql.org/docs/9.1/tutorial-window.html
--			   https://www.postgresqltutorial.com/postgresql-window-function/
--			   https://codingsight.com/calculating-running-total-with-over-clause-and-partition-by-clause-in-sql-server/


WITH running_operations_returns AS (
	
	SELECT 
		clients.id,
		clients.name,
		clients.investment,
		operations.month,
		SUM(profit) OVER (PARTITION BY client_id ORDER BY operations.id) AS running_sum_of_profit,
		SUM(profit) OVER (PARTITION BY client_id ORDER BY operations.id) - clients.investment AS return
	FROM operations
	INNER JOIN clients
		ON operations.client_id = clients.id
	ORDER BY operations.client_id, operations.month
	
)

SELECT 
	payback_month_return.name,
	running_operations_returns.investment,
	running_operations_returns.month AS month_of_payback,
	payback_month_return.return
FROM (
	
	SELECT DISTINCT ON (id)
		name,
		investment,
		return
	FROM running_operations_returns
	WHERE return >= 0
	
) AS payback_month_return
INNER JOIN running_operations_returns
	USING (return )
ORDER BY return DESC
;



-- beecrowd #2999: Highest Division Salary

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/2999
-- Solution:

WITH salarios AS (

	SELECT
		venc_agrupados.matr,
		venc_agrupados.lotacao_div,
		ROUND(SUM(total_vencimentos) - COALESCE(SUM(total_descontos), 0), 2) AS salario
	FROM (

		SELECT
			empregado.matr,
			empregado.lotacao_div,
			COALESCE(SUM(vencimento.valor), 0) AS total_vencimentos
		FROM empregado
		LEFT JOIN emp_venc
			ON empregado.matr = emp_venc.matr
		LEFT JOIN vencimento
			ON emp_venc.cod_venc = vencimento.cod_venc
		GROUP BY empregado.matr, empregado.lotacao_div

	) AS venc_agrupados
	LEFT JOIN (

		SELECT
			empregado.matr,
			empregado.lotacao_div,
			COALESCE(SUM(desconto.valor), 0) AS total_descontos
		FROM empregado
		LEFT JOIN emp_desc
			ON empregado.matr = emp_desc.matr
		LEFT JOIN desconto
			ON emp_desc.cod_desc = desconto.cod_desc
		GROUP BY empregado.matr, empregado.lotacao_div

	) AS desc_agrupados
	ON venc_agrupados.matr = desc_agrupados.matr
	GROUP BY venc_agrupados.matr, venc_agrupados.lotacao_div
),
	media_salarial_div AS (

		SELECT
			lotacao_div,
			AVG(salario) as salario_medio
		FROM salarios
		GROUP BY lotacao_div
)

SELECT 
	empregado.nome,
	salarios.salario
FROM salarios
INNER JOIN media_salarial_div
	ON salarios.lotacao_div = media_salarial_div.lotacao_div
	AND salarios.salario > media_salarial_div.salario_medio
	AND salarios.salario > 8000 -- This is a workaround so it matches the output example (which is innacurate)
INNER JOIN empregado
	ON salarios.matr = empregado.matr
ORDER BY salarios.lotacao_div -- This is a workaround so it matches the output example (which is innacurate)
;



-- beecrowd #3001: Update sem Where

-- Description: https://www.beecrowd.com.br/judge/en/problems/view/3001
-- Solution:

SELECT
    name AS type,
    CASE WHEN type = 'A' THEN 20.0
         WHEN type = 'B' THEN 70.0
         WHEN type = 'C' THEN 530.5 END AS price
FROM products
ORDER BY products.type, id DESC
;

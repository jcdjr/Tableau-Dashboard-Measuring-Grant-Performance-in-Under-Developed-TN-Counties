-- How many counties are represented in the ecd table?
SELECT COUNT(DISTINCT (county))
FROM ecd;

-- How many companies did not have Economic Development grants (ed)? Alias as ed_companies.

SELECT ed AS ed_companies
FROM ecd
WHERE ed IS NULL

SELECT COUNT(ed) AS ed_companies,
SUM(CASE WHEN ed IS NULL THEN 1 END) AS sum_of_null
FROM ecd
WHERE ed IS null;

SELECT COUNT(DISTINCT(company))AS ed_companies
FROM ecd
WHERE ed IS NULL

--What is the total capital_investment, in millions, when there is an fjtap? Call the column fjtap_cap_invest_mil.
SELECT SUM(capital_investment)/1000000 AS fjtap_cap_invest_mil
FROM ecd
WHERE fjtap IS NOT NULL;


SELECT SUM(capital_investment)/1000000 AS fjtap_cap_invest_mil
FROM ecd
WHERE fjtap IS NOT NULL;

-- What is the average number of new jobs for each county_tier?
SELECT county_tier, ROUND(AVG(new_jobs))
FROM ecd
GROUP BY county_tier
ORDER BY county_tier;

-- How many companies are LLCs (combine COUNT() and DISTINCT())? Call this value llc_companies.
SELECT COUNT (DISTINCT company) AS llc_companies
FROM ecd
WHERE company LIKE '%LLC%';

SELECT COUNT (DISTINCT company) AS llc_companies
FROM ecd
WHERE LOWER(company)LIKE '%llc%'

SELECT COUNT (DISTINCT company) AS llc_companies
FROM ecd
WHERE company ILIKE '%llc%'

-- CASE STATEMENTS

SELECT *
FROM population

/* Using the population table in the ecd database, write a query that selects the county, 2017 population, 
and uses a case statement to characterize the 2017 population (pop_category) according to the following business rule:
Greater than or equal to 500,000 - high population. Between 100,000 and 500,000 - medium population.
Less than or equal to 100,000 - low population*/

SELECT DISTINCT county, population,
	CASE WHEN population >= 500000 THEN 'high population'
		WHEN population >= 100000 and population < 500000 THEN 'medium population'
		ELSE 'low population' END AS pop_category
FROM population
WHERE year = '2017'
ORDER BY county;

/*Using the ecd table in the ecd database, write a query that selects the company, landed date,
number of new jobs, and a case statement to classify observations (rows) in the table where
the project type is ‘New Startup’ according to the following business rule:
Fewer than 50 new jobs – small startup
Between 50 and 100 new jobs – midsize startup
More than 100 new jobs – large startup*/

SELECT company, landed, new_jobs,
	CASE WHEN new_jobs < 50 THEN 'small startup'
		 WHEN new_jobs >=50 AND new_jobs <= 100 THEN 'midsize startup'
		 ELSE 'large startup' END AS startup_size
FROM ecd
WHERE project_type = 'New Startup'
ORDER BY company;

--with filter
SELECT company, landed, new_jobs, project_type
 CASE WHEN new_jobs < 50 THEN 'small_startup'
	WHEN new_jobs >= 50 AND new_jobs < 100 THEN 'midsize startup' END AS startup_size
FROM ecd
WHERE project_type LIKE '%New Startup%'
 CASE WHEN new_jobs < 50 THEN 'small_startup'
	WHEN new_jobs >= 50 AND new_jobs < 100 THEN 'midsize startup'
	END IS NOT null;

/*3. Using the population table in the ecd database, write a query that uses a case statement to
find the total population for 2010 and 2017. Call these Total_Pop_2010 and Total_Pop_2017.*/

SELECT 
	SUM(CASE WHEN year = 2010 THEN population END) AS population_2010,
	SUM(CASE WHEN year = 2017 THEN population END) AS population_2017
FROM population;

---SUB QUERIES---
/*Write a subquery in the WHERE clause to select the top 5 capital investment amounts from the ecd table. Be
sure to exclude NULL capital investments in the subquery. Next write an outer query to return the company,
landed date, county, and capital investment for the top 5 investment amounts.*/

SELECT company,landed, county, capital_investment
FROM ecd
WHERE capital_investment IN
	(SELECT capital_investment 
	 FROM ecd 
	 WHERE capital_investment IS NOT NULL
	 ORDER BY capital_investment DESC
	LIMIT 5)
ORDER BY

SELECT company, landed, county, capital_investment
FROM ecd
WHERE capital_investment IN 
	(SELECT capital_investment
	FROM ecd
	WHERE capital_investment IS NOT null
	ORDER BY capital_investment DESC
	LIMIT 5)
ORDER BY capital_investment DESC;

SELECT company, capital_investment
FROM ecd
WHERE capital_investment IS NOT NULL
ORDER BY capital_investment DESC
LIMIT 5;


/*Use a subquery in the FROM section to find observations in county tier 4 with capital investment greater
than $10,000,000 in the ecd database. Remember to alias your subquery! Next write an outer query to find
the average number of new jobs and the average amount of total grants where an economic development
grant is included in the total for this group.*/

SELECT
	ROUND(AVG(new_jobs)) as avg_new_jobs,
	CAST(AVG(CAST(grants_total as decimal)) as money) as avg_grants_total
FROM (SELECT * FROM ecd
	  WHERE county_tier ='4'
	  AND CAST(capital_investment as decimal) > 10000000
	  AND ed IS NOT NULL) as tier_4;

SELECT AVG(new_jobs) AS avg_new_jobs, AVG(CAST(grants_total as decimal)) AS avg_grants_total
FROM (
	  SELECT new_jobs, grants_total, ed
	  FROM ecd
	  WHERE county_tier = 4 AND capital_investment > ‘10000000’) as subquery
WHERE ed IS NOT NULL;

---WINDOWS FUNCTIONS---

/* For each Tennessee county in the population table in the ecd database:
a. create a partition to find the maximum population(max_pop) values in the
table.
b. Also find the minimum population (min_pop) for each county.*/

SELECT DISTINCT county,
	MAX(population) OVER(PARTITION BY county) AS max_pop,
	MIN(population) OVER(PARTITION BY county) AS min_pop
FROM population
GROUP BY county, population
ORDER BY max_pop DESC;


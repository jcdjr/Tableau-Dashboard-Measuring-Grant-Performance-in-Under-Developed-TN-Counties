SELECT SUM(grants_total)
FROM ecd

--count of project type
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier, fjtap, fidp, ed, grants_total
			FROM ecd)
SELECT project_type, SUM(grants_total) AS total_grants, COUNT(project_type), year
FROM ecd_year
WHERE year = 2019 
GROUP BY project_type, year
ORDER BY new_jobs DESC;

-- order by project type in____
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier, fjtap, fidp, ed, grants_total
			FROM ecd)
SELECT project_type, SUM(new_jobs) AS count_new_jobs
FROM ecd_year
WHERE year = 2018
GROUP BY project_type

--master
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT DISTINCT(county), county_tier
FROM ecd_year
WHERE year = 2017 

--grants per county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT year, county_tier, COUNT(company) AS grant_count
FROM ecd_year
WHERE year = 2019 
GROUP BY county_tier,year

--jobs by county tier
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT year, county_tier, SUM(new_jobs)AS count_new_jobs
FROM ecd_year
WHERE year = 2011 
GROUP BY county_tier,year

-- count grant types
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT COUNT(job_training) AS total_job_training, COUNT(infrastructure) AS total_inf, COUNT(econ_dev) AS total_econ_dev
FROM ecd_year
WHERE year = 2017 

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT job_training, infrastructure, econ_dev
FROM ecd_year
WHERE year = 2017 

--number of tier 4 overtime
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2017 
GROUP BY county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2016
GROUP BY county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2015
GROUP BY county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2014
GROUP BY county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2013
GROUP BY county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2012
GROUP BY county_tier

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT county_tier, COUNT(county_tier) AS tier_count
FROM ecd_year
WHERE year = 2011
GROUP BY county_tier



SELECT *
FROM unemployment


SELECT DISTINCT(county), ROUND(AVG(value),2) as unemployment_rate
FROM unemployment
WHERE year = 2017
GROUP BY county
ORDER BY county;

LIMIT 5;

SELECT *
FROM unemployment
WHERE year = 2018
LIMIT 5;

--by total dollar amount by grant type
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT SUM(job_training) AS total_job_training, SUM(infrastructure) AS inf_total, SUM(econ_dev) AS econ_dev_total
FROM ecd_year
WHERE year = 2017 

--
WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT SUM(job_training) AS total_job_training, SUM(infrastructure) AS inf_total, SUM(econ_dev) AS econ_dev_total
FROM ecd_year
WHERE year = 2018


--min and max year

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT MIN(year), MAX(year)
FROM ecd_year
WHERE year = 2017

--sub query

WITH ecd_year AS (SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, new_jobs, project_type, county, county_tier,
				  fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
					FROM ecd)
SELECT SUM(job_training) AS total_job_training, SUM(infrastructure) AS inf_total, SUM(econ_dev) AS econ_dev_total
FROM ecd_year
WHERE year = 2017

SELECT company, landed, CAST(DATE_PART('year',landed::date)AS integer) AS year, 
new_jobs, project_type, county, county_tier,
fjtap AS job_training, fidp AS infrastructure, ed AS econ_dev, grants_total
FROM ecd


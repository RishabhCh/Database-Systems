-- Part j
SELECT t4.city_name as capital,
       t5.name
FROM
(SELECT count(*),t1.city_name as city_name,t1.province_name,t1.country_code as country_code
FROM airport t1,
     country t2
WHERE t1.city_name = t2.capital AND
      t1.country_code = t2.code AND
      t1.province_name = t2.province_name
GROUP BY t1.city_name,t1.province_name,t1.country_code 
HAVING count(*) > 1) t4,
country t5
WHERE t4.country_code = t5.code;

CREATE INDEX id_airport_city ON airport (city_name,province_name,country_code)

-- Part h
SELECT COUNT(country_code)/100 AS proportion_of_commonwealth_countries
FROM 
(SELECT country_code,gdp FROM economy
 WHERE gdp IS NOT NULL 
 ORDER BY gdp DESC
 FETCH FIRST 100 ROWS ONLY) T1
 WHERE T1.COUNTRY_CODE IN 
 (SELECT country_code FROM
  is_member WHERE 
  organization_abbreviation IN (SELECT abbreviation FROM organization WHERE name = 'Commonwealth'));	

-- Part g
CREATE INDEX id_economy_country ON economy(gdp)

SELECT t3.name,
       t4.name
FROM
(SELECT MAX(t1.religion_count) AS max_religion_count
FROM
(SELECT count(name) AS religion_count,
             country_code
      FROM religion
      GROUP BY country_code) t1) t2,
      country t3,
      religion t4
WHERE t3.code = t4.country_code AND
      t4.country_code IN (SELECT country_code FROM 
      (SELECT count(name) AS religion_count,
             country_code
      FROM religion
      GROUP BY country_code) t5 WHERE t5.religion_count = t2.max_religion_count );

-- Part f
SELECT t1.name,
       t2.gdp,
       t3.infant_mortality
FROM country t1,
     economy t2,
     country_population t3
WHERE t1.code = t2.country_code AND
      t2.country_code = t3.country_code
      AND t2.gdp IS NOT NULL
ORDER BY t2.gdp DESC
FETCH FIRST 10 ROWS ONLY;

-- Part e
SELECT COUNT(*) AS number_of_countries_equal_ethnic_language
FROM
(SELECT COUNT(ethnic_group_name) AS ethnic_group_count,
       country_code
FROM ethnic_group
GROUP BY country_code) t1,
(SELECT COUNT(language) language_count,
       country_code
FROM language
GROUP BY country_code) t2
WHERE t1.country_code = t2.country_code AND
      t1.ethnic_group_count = t2.language_count;

-- Part d
SELECT t2.name,
       t1.ethnic_diversity,
       t1.percentage_of_major_ethnicity
FROM(
SELECT count(ethnic_group_name) as ethnic_diversity,
       country_code,
       max(ethnic_group_percentage) as percentage_of_major_ethnicity
FROM ethnic_group
GROUP BY country_code) t1 ,
country t2
WHERE t1.country_code = t2.code
ORDER BY t1.ethnic_diversity DESC;

-- Part c
SELECT c.name,
       e.gdp,
       e.agriculture_percentage,
       e.inflation
FROM economy e,
     country c
WHERE e.agriculture_percentage > e.industry_percentage AND
      e.agriculture_percentage > e.service_percentage AND
      c.code = e.country_code;



-- Part a
SELECT name
FROM country
where code IN
(SELECT country_code_1
FROM borders b 
where length >= (select max(b1.length) from borders b1)
UNION ALL
SELECT country_code_2
FROM borders b 
where length >= (select max(b2.length) from borders b2));

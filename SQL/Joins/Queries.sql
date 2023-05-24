use master;
select * 
from cities;
select * 
from countries;

-- 1. Utiliza un INNER JOIN para cruzar la tablas cities y countries.
-- Selecciona el nombre de la ciudad (con alias 'city'), el código de país, el nombre del país (con alias 'country') y la columna city_prop_population (población propia de la ciudad). Finalmente, ordena en orden descendente por la columna que ambas tablas tienen en común.
select ci.name as city, ci.country_code as code, co.country_name as country, co.region, ci.city_proper_pop
from cities as ci
inner join countries as co
on ci.country_code = co.code
ORDER BY ci.country_code DESC;

/* 
2. Utiliza un LEFT JOIN para cruzar la tablas countries y languages.

Selecciona el país (con alias 'country'), el nombre local del país (local_name), el nombre del idioma y, finalmente, el porcentaje del idioma hablado en cada país
*/
SELECT * 
FROM Languages;
SELECT co.country_name as country, co.local_name, la.name, la.percent 
FROM Countries AS co
LEFT JOIN Languages AS la
ON co.code = la.code
ORDER BY country DESC;

/*
3. Utiliza nuevamente un LEFT JOIN (o RIGHT JOIN si quiere alocarte un poco 🤓) para cruzar las tablas countries y economies.

Selecciona el nombre del país, región y GDP per cápita (de economies). Finalmente, filtra las filas para obtener solo los resultados del año 2010.
*/
SELECT co.country_name, co.region, eco.gdp_percapita
FROM economies as eco
LEFT JOIN countries as co
ON eco.code = co.code
WHERE year = 2010;

/*
4. Haz una subconsulta en WHERE donde calcules el promedio de la expectativa de vida en la tabla populations, filtrando solo para el año 2015.
*/
SELECT round(AVG(life_expectancy),2) average_life_expectancy
FROM populations
WHERE year = 2015;
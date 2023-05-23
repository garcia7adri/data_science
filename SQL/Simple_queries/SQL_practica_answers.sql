use master;
show tables;
-- 1
select type, title, director, country
from master.netflix_titles
-- 2
select type, count(type) AS Count
from master.netflix_titles
group by type
-- 3
select country, max(release_year)
from master.netflix_titles
group by country
-- 4
select country, director, min(release_year)
from master.netflix_titles
group by director, country

-- 5
select  title, cast, rating, duration
from master.netflix_titles
where type = "TV show" and duration = "1 Season";

-- 6
select  title, duration, description, country
from master.netflix_titles
where listed_in = "comedies";

-- 7

select  title, duration, description, release_year
from master.netflix_titles
where release_year >=2020
order by release_year desc
limit 30;



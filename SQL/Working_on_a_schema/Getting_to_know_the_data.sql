-- use sakila schema
use sakila;

-- all from actor table
select *
from actor;

-- to know time
select now();

-- to check version, user and database been used
SELECT version(),
	user(),
    database();
    
-- more complex queries and renaming the columns
SELECT language_id,
	"COMMON" language_usage,
	language_id * 3.1415927 lang_pi_value,
	upper(name) language_name
	FROM language;
    
-- distinct function, for unique values
SELECT DISTINCT actor_id
	FROM film_actor
    ORDER BY actor_id;
    
-- using a table from a subquery
SELECT concat(cust.last_name,", ", cust.first_name) full_name
	FROM 
    (SELECT first_name, last_name, email
    FROM customer
    WHERE first_name ="JESSIE"
    ) cust;
    
-- using temporary tables
CREATE TEMPORARY TABLE actors_j
	(actor_id smallint(5),
    first_name varchar (45),
    last_name varchar(45)
    );
    
INSERT INTO actors_j
	SELECT actor_id, first_name, last_name
    FROM actor
    WHERE last_name LIKE "J%";
    
SELECT * 
	FROM actors_j;

-- a view
CREATE VIEW cust_vw AS
	SELECT customer_id, first_name, last_name, active
    FROM customer;
    
SELECT first_name, last_name
	FROM cust_vw
    WHERE active = 0;
    
-- table links
SELECT customer.first_name, customer.last_name,
	time(rental.rental_date) rental_time
	FROM customer
    INNER JOIN rental
    ON customer.customer_id = rental.customer_id
    WHERE date(rental.rental_date) ="2005-06-14";
    

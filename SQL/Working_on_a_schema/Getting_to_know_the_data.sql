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
    
-- where criteria
SELECT title
	FROM film
    WHERE rating= "G" AND rental_duration >= 7;
    
SELECT title, rating, rental_duration
	FROM film
	WHERE (rating = 'G' AND rental_duration >= 7)
	OR (rating = 'PG-13' AND rental_duration < 4);
    
-- group by and having clauses

SELECT c.first_name, c.last_name, count(*)
	FROM customer c
	INNER JOIN rental r
	ON c.customer_id = r.customer_id
	GROUP BY c.first_name, c.last_name
	HAVING count(*) >= 40;
    
SELECT c.first_name, c.last_name,
	time(r.rental_date) rental_time
	FROM customer c
	INNER JOIN rental r
	ON c.customer_id = r.customer_id
	WHERE date(r.rental_date) = '2005-06-14'
	ORDER BY c.last_name;
    
-- sort by descending, third element in select
SELECT c.first_name, c.last_name,
	time(r.rental_date) rental_time
	FROM customer c
	INNER JOIN rental r
	ON c.customer_id = r.customer_id
	WHERE date(r.rental_date) = '2005-06-14'
	ORDER BY 3 desc;

/* Exercise 3-1
Retrieve the actor ID, first name, and last name for all actors. Sort by last
name and then by first name.*/

SELECT actor_id, first_name, last_name
	FROM actor
    ORDER BY last_name, first_name;
    
/*Exercise 3-2
Retrieve the actor ID, first name, and last name for all actors whose last
name equals 'WILLIAMS' or 'DAVIS'. */

SELECT actor_id, first_name, last_name
	FROM actor
    WHERE last_name = "WILLIAMS" OR last_name ="DAVIS";
    
/*Exercise 3-3
Write a query against the rental table that returns the IDs of the
customers who rented a film on July 5, 2005 (use the
rental.rental_date column, and you can use the date() function to
ignore the time component). Include a single row for each distinct
customer ID.
*/
select distinct rental.customer_id
	from customer 
	inner join rental
    on rental.customer_id = customer.customer_id
    where date(rental.rental_date ) ="2005-07-05";
    
/* Exercise 
Write a query against rental, return the email and return_date, filter by rental_date = "2005-06-14"
*/
SELECT c.email, r.return_date
	FROM customer c
	INNER JOIN rental r
	ON c.customer_id = r.customer_id
	WHERE date(r.rental_date) = '2005-06-14'
	ORDER BY r.return_date DESC;
    
-- Condition types
-- Equality conditions
-- film_id = (select film_id from film where title = "RIVER OUTLAW")

-- Every customer who rented a film on June 14, 2005.
select c.email
	from customer c
	inner join rental r
	on c.customer_id = r.customer_id
	where date(r.rental_date) = "2005-06-14";

-- INEQUALITY CONDITIONS
-- All email addresses for films rented on any other date than June 14, 2005.
SELECT c.email
	FROM customer c
	inner join rental r
	on c.customer_id = r.customer_id
	where date(r.rental_date) <> "2005-06-14";
    
-- Data modification using equality conditions

/*
delete from rental
where year(renta_date) = 2004;

delete from rental
where year(rental_date) <> 2005 and year(rental_date) <> 2006;
*/

-- Range conditions

select customer_id, rental_date
	from rental
    where rental_date < "2005-05-25";
    
select customer_id, rental_date
	from rental 
    where rental_date <= "2005-06-16"  -- first comes higher
    and rental_date >= "2005-06-14";	-- then comes lower
    
-- THE BETWEEN OPERATOR
select customer_id, rental_date
	from rental
    where rental_date between "2005-06-14" and "2005-06-16"; -- first comes lower then higher
    
-- always specify the lower limit of the range first (after between) and the upper limit of the range second (after and).

-- range with numbers   
select customer_id, payment_date, amount
	from payment
	where amount between 10.0 and 11.99;
    
-- STRING RANGES
-- query that returns customers whose last name falls between FA and FR

select last_name, first_name
	from customer
    where last_name between "FA" AND "FR";

-- extending the righthand range to FRB

select last_name, first_name
	from customer
    where last_name between "FA" and "FRB";
    
-- MEMBERSHIP CONDITIONS

-- using or
select title, rating
from film
where rating = "G" or rating = "PG";

-- using in
select title, rating
from film
where rating in ("G", "PG");

-- USING SUBQUERIES
select title, rating
	from film
    where rating in (select rating from film where title like "%PET%");

-- USING NOT IN 

-- all accounts that are not rated 'PG-13' ,'R', or 'NC-17'
select title, rating
	from film
    where rating not in ("PG-13", "R", "NC-17");
    
-- MATCHING CONDITIONS
-- built-in function to strip off the first letter of the last_name column

select last_name, first_name
from customer
where left(last_name, 1) = "Q"; -- build-in function left() does not give much flexibility, another option is wildcard characters
 
-- USING WILDCARDS

/*
- Exactly one character
% Any number of characters (including 0)
*/

-- strings containing an A in the second position and a T in the fourth position, followed by any number of characters and ending in S.
select last_name, first_name
	from customer
    where last_name like "_A_T%S";
    
select last_name, first_name
	from customer
	where last_name like "Q%" or last_name like "Y%";
        
-- USING REGULAR EXPRESSIONS
-- Regular expressions to build search expressions

SELECT last_name, first_name
	FROM customer
    WHERE last_name REGEXP "^[QY]";
    
-- NULL: not applicable, value not yet known, value undefined.
-- An expression can be null, but it can never equal null.
-- Two nulls are never equal to each other.
-- To test whether an expression is null
select rental_id, customer_id
	from rental
    where return_date is null;
    
select rental_id, customer_id, return_date
	from rental
    where return_date IS NOT NULL;
    
-- all rentals that were not returned during May through August of 2005. 

 select rental_id, customer_id, return_date
	from rental
    where return_date is null
     or return_date not between "2005-05-01" and "2005-09-01";
     
-- EXERCISE
-- Based on the following subset of rows from the payment table

create view table_101_120 as
SELECT payment_id, customer_id, amount, date(payment_date)
	from payment
    where payment_id between 101 and 120;
    
select *
	from table_101_120
     where customer_id <> 5 AND amount > 8;
     
select *
	from table_101_120
    where customer_id = 5 AND NOT amount > 6;
    
-- all rows from the payment table where the amount is either 1.98, 7.98, or 9.98.   
 
SELECT *
	from payment
    where amount in (1.98, 7.98, 9.98);
 
-- all customers whose last name contains an A in the second position and a W anywhere after the A
 
select first_name, last_name
	from customer
    where last_name like "_A%W%";

-- QUERYING MULTIPLE TABLES

-- definitions for the customer and address tables

desc customer;

desc address;

-- Inner join

select c.first_name, c.last_name, a.address
from customer c inner join address a
on c.address_id = a.address_id;

-- If the names of the columns used to join the two tables are identical we can use "using"

select c.first_name, c.last_name, a.address
from customer c inner join address a
using (address_id);


SELECT c.first_name, c.last_name, a.address
	FROM customer c inner join address a
	on  c.address_id = a.address_id
	where a.postal_code = 52137;
    
-- Joining three or more tables

SELECT c.first_name, c.last_name, ct.city
	FROM customer c
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id;
    
-- Subqueries as tables

-- The subquery, which starts on line 4 and is given the alias addr, finds all addresses that are in California.
 
select c.first_name, c.last_name, addr.address, addr.city
	from customer c
    inner join 
    (select a.address_id, a.address, ct.city
    from address a
    inner join city ct
    on a.city_id = ct.city_id
    where a.district = "California"
    ) addr
    on c.address_id = addr.address_id;
    
-- using the same table twice

select f.title
from film f
inner join film_actor fa
on f.film_id = fa.film_id
inner join actor a 
on fa.actor_id = a.actor_id
where ((a.first_name = " CATE" AND a.last_name = "MCQUEEN") 
OR (a.first_name = "CUBA" AND a.last_name = "BIRCH"));


-- query that requires the use of table aliases, since the same tables are used multiple times.
SELECT f.title
	FROM film f
	INNER JOIN film_actor fa1
	ON f.film_id = fa1.film_id
	INNER JOIN actor a1
	ON fa1.actor_id = a1.actor_id
	INNER JOIN film_actor fa2
	ON f.film_id = fa2.film_id
	INNER JOIN actor a2
	ON fa2.actor_id = a2.actor_id
	WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
	AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');
    
-- EXERCISE
-- Find name, last name, address and city = California
SELECT c.first_name, c.last_name, a.address, ct.city
	FROM customer c
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id
	WHERE a.district = 'California';
    
/* Write a query that returns the title of every film in which an actor with the first  
name JOHN appeared
*/
select f.title
from film f 
inner join film_actor fa
on f.film_id = fa.film_id
inner join actor a
on fa.actor_id = a.actor_id
where a.first_name = "John";

/*
Construct a query that returns all addresses that are in the same city. You
will need to join the address table to itself, and each row should include
two different addresses.
*/
-- SELF JOIN

select a.address, ad.address, a.city_id
from address a
inner join address ad
on a.city_id = ad.city_id
and a.address_id <> ad.address_id;

-- WORKING WITH SETS

SELECT c.first_name, c.last_name
	FROM customer c
	WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
	UNION
	SELECT a.first_name, a.last_name
	FROM actor a
	WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';
    
-- Sorting Compound Query Results

SELECT a.first_name fname, a.last_name lname
	FROM actor a
	WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
	UNION ALL
	SELECT c.first_name, c.last_name
	FROM customer c
	WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
	ORDER BY lname, fname;

-- Set Operation Precedence

SELECT a.first_name, a.last_name
	FROM actor a
	WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
	UNION ALL
	SELECT a.first_name, a.last_name
	FROM actor a
	WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
	UNION
	SELECT c.first_name, c.last_name
	FROM customer c
	WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';


/* Write a compound query that finds the first and last names of all actors
and customers whose last name starts with L  and sort by last name*/
SELECT a.first_name, a.last_name
	FROM actor a
	WHERE a.last_name LIKE 'L%'
	UNION ALL
	SELECT c.first_name, c.last_name
	FROM customer c
	WHERE c.last_name LIKE 'L%'
    order by last_name;


    
    
    


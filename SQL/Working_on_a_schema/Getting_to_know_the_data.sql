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
    
-- Data Generation, Manipulation, and Conversion

CREATE TABLE string_tbl
(char_fld CHAR(30),
vchar_fld VARCHAR(30),
text_fld TEXT
);

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
	VALUES ('This is char data',
	'This is varchar data',
	'This is text data');

SELECT vchar_fld
	FROM string_tbl;
    
-- String Manipulation 


INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
	VALUES ('This string is 28 characters',
	'This string is 28 characters',
	'This string is 28 characters');
    
SELECT *
from  string_tbl;

-- STRING FUNCTIONS THAT RETURN NUMBERS

-- length() function, which returns the number of characters in the string

SELECT LENGTH(char_fld) char_length,
	LENGTH(vchar_fld) varchar_length,
	LENGTH(text_fld) text_length
	FROM string_tbl;
    
 -- find the location of a substring within a string   
 
SELECT POSITION('characters' IN vchar_fld)
	FROM string_tbl;

-- start the search at something other than the first character of the target string   
  
SELECT LOCATE('is', vchar_fld, 5)
	FROM string_tbl;

-- string comparison function strcmp(). strcmp()
/*
−1 if the first string comes before the second string in sort order
0 if the strings are identical
1 if the first string comes after the second string in sort order*/


INSERT INTO string_tbl(vchar_fld)
	VALUES ('abcd'),
	('xyz'),
	('QRSTUV'),
	('qrstuv'),
	('12345');    

SELECT vchar_fld
	FROM string_tbl
	ORDER BY vchar_fld;

SELECT STRCMP('12345','12345') 12345_12345,
	STRCMP('abcd','xyz') abcd_xyz,
	STRCMP('abcd','QRSTUV') abcd_QRSTUV,
	STRCMP('qrstuv','QRSTUV') qrstuv_QRSTUV,
	STRCMP('12345','xyz') 12345_xyz,
	STRCMP('xyz','qrstuv') xyz_qrstuv;
    
-- like and regexp operators to compare strings in the select clause. Such comparisons will yield 1 (for true) or 0 (for false). 

SELECT name, name LIKE '%y' ends_in_y
	FROM category;
    
SELECT name, name REGEXP 'y$' ends_in_y
	FROM category;
    
-- STRING FUNCTIONS THAT RETURN STRINGS
select *
from string_tbl;

truncate string_tbl;
delete from string_tbl;

INSERT INTO string_tbl (text_fld)
VALUES ('This string was 29 characters');

-- contat() function

UPDATE string_tbl
	SET text_fld = CONCAT(text_fld, ', but now it is longer');

SELECT text_fld
	FROM string_tbl;
    
SELECT concat(first_name, ' ', last_name,
	' has been a customer since ', date(create_date)) cust_narrative
	FROM customer;
    
-- insert() function
/* takes four arguments: the
original string, the position at which to start, the number of characters to
replace, and the replacement string. */

SELECT INSERT('goodbye world', 9, 0, 'cruel ') string;

SELECT INSERT('goodbye world', 1, 7, 'hello') string;

-- extract a substring from a string
SELECT SUBSTRING('goodbye cruel world', 9, 5);

-- WORKING WITH NUMERICAL DATA

SELECT (37 * 59) / (78 - (8 * 6));

-- Performing Arithmetic Functions

/*
acos( x ) Calculates the arc cosine of x
asin( x ) Calculates the arc sine of x
atan( x ) Calculates the arc tangent of x
cos( x ) Calculates the cosine of x
cot( x ) Calculates the cotangent of x
exp( x ) Calculates e^x
ln( x ) Calculates the natural log of x
sin( x ) Calculates the sine of x
sqrt( x ) Calculates the square root of x
tan( x ) Calculates the tangent of x
*/

SELECT MOD(10,4);

SELECT MOD(22.75, 5);

SELECT POW(2,8);

SELECT POW(2,10) kilobyte, POW(2,20) megabyte,
POW(2,30) gigabyte, POW(2,40) terabyte;

-- Controlling Number Precision

-- ceil(), floor(), round(), and truncate()
SELECT CEIL(72.445), FLOOR(72.445);

SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);

SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2),
	TRUNCATE(72.0909, 3);
    
-- Handling Signed Data

create table account 
(account_id int,
acct_type varchar(100),
balance decimal);

insert into account (account_id, acct_type, balance )
values (123 , "MONEY MARKET" , 785.22);

insert into account (account_id, acct_type, balance )
values (456, "SAVINGS" , 0.00);

insert into account (account_id, acct_type, balance )
values (789, "CHECKING", -324.22);

select *
from account;

/* report showing the current status of a set of bank accounts
using the following data from the account table*/

SELECT account_id, SIGN(balance), ABS(balance)
	FROM account;
/* Output of table above. 
Second column: −1 if the account balance is negative, 0 if the account balance is zero, and 1 if the account
balance is positive. 
Third column: returns the absolute value of the account balance via the abs() function. */

-- Working with Temporal Data

-- Dealing with Time Zones
-- a global time zone and a session time zone

SELECT @@global.time_zone, @@session.time_zone;

-- STRING REPRESENTATIONS OF TEMPORAL DATA

-- STRING-TO-DATE CONVERSIONS
-- returns a datetime value using the cast() function
SELECT CAST('2019-09-17 15:30:00' AS DATETIME);
-- cast() function to generate a date value and a time value

SELECT CAST('2019-09-17' AS DATE) date_field,
	CAST('108:17:57' AS TIME) time_field;
    
-- FUNCTIONS FOR GENERATING DATES

-- str_to_date(), allows to provide a format string along with the date string

UPDATE rental
SET return_date = STR_TO_DATE('September 17, 2019', '%M %d, %Y')
WHERE rental_id = 99999;

-- generate the current date/time

SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

-- Manipulating Temporal Data
-- TEMPORAL FUNCTIONS THAT RETURN DATES
-- date_add() function allows to add any kind of interval

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

-- to add 9 years and 11 months to employee's birth date
UPDATE employee
SET birth_date = DATE_ADD(birth_date, INTERVAL '9-11' YEAR_MONTH)
WHERE emp_id = 4789;

-- find the last day of September 

SELECT LAST_DAY('2019-09-17');

-- TEMPORAL FUNCTIONS THAT RETURN STRINGS

-- determine which day of the week a certain date falls on

SELECT DAYNAME('2019-09-18');

-- to extract just the year portion of a datetime value using extract()
SELECT EXTRACT(YEAR FROM '2019-09-18 22:19:05');

-- TEMPORAL FUNCTIONS THAT RETURN NUMBERS
-- datediff() returns the number of full days between two dates

SELECT DATEDIFF('2019-09-03', '2019-06-21');

-- Conversion Functions
-- string to an integer
SELECT CAST('1456328' AS SIGNED INTEGER);

-- when finding a non-number character in the string
SELECT CAST('999ABC111' AS UNSIGNED INTEGER);
show warnings;

-- Exercise

/* Write a query that returns the 17th through 25th characters of the string
'Please find the substring in this string'. */

select substring('Please find the substring in this string', 17,9);

/* Write a query that returns the absolute value and sign (−1, 0, or 1) of the
number −25.76823. Also return the number rounded to the nearest
hundredth. */
select abs(-25.76823), sign(-25.76823), round( -25.76823);

/* Write a query to return just the month portion of the current date. */
select extract(month from current_date());

create table test (
id int,
nombre varchar(50),
parent int)

-- delete from test;

insert into test (id, nombre, parent)
values ("1", "manzana", "3");

insert into test (id, nombre, parent)
values ("2", "pera", "1");

insert into test (id, nombre, parent)
values ("3", "cereza", "2");

select t.id, t.nombre as child, t.parent as id_of_parent, tt.nombre as parent, tt.id
from test t
inner join test tt
where tt.id = t.parent;

-- Grouping by aggregate

SELECT customer_id
	FROM rental
	GROUP BY customer_id;

SELECT customer_id, count(*)
	FROM rental
	GROUP BY customer_id;
    
SELECT customer_id, count(*)
	FROM rental
	GROUP BY customer_id
	ORDER BY 2 DESC;
    
SELECT customer_id, count(*)
	FROM rental
	GROUP BY customer_id
	HAVING count(*) >= 40;
    
SELECT MAX(amount) max_amt,
	MIN(amount) min_amt,
	AVG(amount) avg_amt,
	SUM(amount) tot_amt,
	COUNT(*) num_payments
	FROM payment;
    
-- Implicit Versus Explicit Groups

SELECT customer_id,
	MAX(amount) max_amt,
	MIN(amount) min_amt,
	AVG(amount) avg_amt,
	SUM(amount) tot_amt,
	COUNT(*) num_payments
	FROM payment
	GROUP BY customer_id;
    
    -- Counting Distinct Values
SELECT COUNT(customer_id) num_rows,
	COUNT(DISTINCT customer_id) num_customers
	FROM payment;
    
-- Using Expressions
-- the maximum number of days between when a film was rented and subsequently returned
SELECT MAX(datediff(return_date,rental_date))
	FROM rental;
    
-- How Nulls Are Handled

/* count(*) counts the number of rows, whereas count(column) counts
the number of values contained in the val column and ignores any null
values encountered.*/

-- Generating Groups

-- Single-Column Grouping

-- number of films associated with each actor
SELECT actor_id, count(*)
	FROM film_actor
	GROUP BY actor_id;
    
-- Multicolumn Grouping
-- number of films for each film rating (G, PG, ...) for each actor

SELECT fa.actor_id, f.rating, count(*)
	FROM film_actor fa
	INNER JOIN film f
	ON fa.film_id = f.film_id
	GROUP BY fa.actor_id, f.rating
	ORDER BY 1,2;
    
-- Grouping via Expressions
-- rentals by year

SELECT extract(YEAR FROM rental_date) year,
	COUNT(*) how_many
	FROM rental
	GROUP BY extract(YEAR FROM rental_date);
    
-- Generating Rollups

SELECT fa.actor_id, f.rating, count(*)
	FROM film_actor fa
	INNER JOIN film f
	ON fa.film_id = f.film_id
	GROUP BY fa.actor_id, f.rating WITH ROLLUP
	ORDER BY 1,2;
    
-- Group Filter Conditions

SELECT fa.actor_id, f.rating, count(*)
	FROM film_actor fa
	INNER JOIN film f
	ON fa.film_id = f.film_id
	WHERE f.rating IN ('G','PG')
	GROUP BY fa.actor_id, f.rating
	HAVING count(*) > 9;
    
-- EXERCISE

-- Construct a query that counts the number of rows in the payment table.
SELECT COUNT(*)
FROM payment;

/* Modify your query to count the number of payments
made by each customer. Show the customer ID and the total amount paid
for each customer.*/

select customer_id, count(amount), sum(amount)
	from payment
    group by customer_id;
    
/* Modify your query, include only those customers who
have made at least 40 payments.*/

select customer_id, count(*), sum(amount)
	from payment
    group by customer_id
    having count(*)>=40;
    
-- SUBQUERIES

SELECT customer_id, first_name, last_name
	FROM customer
	WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

SELECT customer_id, first_name, last_name
	FROM customer
	WHERE customer_id = 599;
    
-- Subquery Types:
-- Noncorrelated Subqueries

SELECT city_id, city
	FROM city
	WHERE country_id <>
	(SELECT country_id FROM country WHERE country = 'India');

-- Multiple-Row, Single-Column Subqueries
-- THE IN AND NOT IN OPERATORS
SELECT country_id
	FROM country
	WHERE country IN ('Canada','Mexico');

-- all cities that are in Canada or Mexico
SELECT city_id, city
	FROM city
	WHERE country_id IN
	(SELECT country_id
	FROM country
	WHERE country IN ('Canada','Mexico'));

-- all cities that are NOT in Canada or Mexico
SELECT city_id, city
	FROM city
	WHERE country_id NOT IN
	(SELECT country_id
	FROM country
	WHERE country IN ('Canada','Mexico'));
    
-- THE ALL OPERATOR
-- all customers who have never gotten a free film rental

SELECT first_name, last_name
	FROM customer
	WHERE customer_id <> ALL
	(SELECT customer_id
	FROM payment
	WHERE amount = 0);
    
-- Same query as before but using NOT IN
SELECT first_name, last_name
	FROM customer
	WHERE customer_id NOT IN
	(SELECT customer_id
	FROM payment
	WHERE amount = 0);
/* The subquery returns the total number of film rentals for
all customers in North America, and the containing query returns all
customers whose total number of film rentals exceeds any of the North
American customers.*/
   
SELECT customer_id, count(*)
	FROM rental
	GROUP BY customer_id
	HAVING count(*) > ALL
	(SELECT count(*)
	FROM rental r
	INNER JOIN customer c
	ON r.customer_id = c.customer_id
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id
	INNER JOIN country co
	ON ct.country_id = co.country_id
	WHERE co.country IN ('United States','Mexico','Canada')
	GROUP BY r.customer_id
	);
    
-- THE ANY OPERATOR

/* all customers whose total film rental
payments exceed the total payments for all customers in Bolivia,
Paraguay, or Chile */

SELECT customer_id, sum(amount)
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > ANY
	(SELECT sum(p.amount)
	FROM payment p
	INNER JOIN customer c
	ON p.customer_id = c.customer_id
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id
	INNER JOIN country co
	ON ct.country_id = co.country_id
	WHERE co.country IN ('Bolivia','Paraguay','Chile')
	GROUP BY co.country
	);

SELECT co.country, sum(p.amount)
	FROM payment p
	INNER JOIN customer c
	ON p.customer_id = c.customer_id
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id
	INNER JOIN country co
	ON ct.country_id = co.country_id
	WHERE co.country IN ('Bolivia','Paraguay','Chile')
	GROUP BY co.country;
    
-- Multicolumn Subqueries

/*identify all actors with the last name
Monroe and all films rated PG*/

SELECT fa.actor_id, fa.film_id
	FROM film_actor fa
	WHERE fa.actor_id IN
	(SELECT actor_id FROM actor WHERE last_name = 'MONROE')
	AND fa.film_id IN
	(SELECT film_id FROM film WHERE rating = 'PG');
    
-- Correlated Subqueries
-- customers who have rented exactly 20 films

select first_name, last_name
from customer c
where 20 = (
select count(*) from rental r where c.customer_id=r.customer_id);

-- all customers whose total payments for all film rentals are between $180 and $240

select first_name, last_name
from customer c
where (select sum(amount) from payment p 
where c.customer_id = p.customer_id)
between 180 and 240;

-- The exists Operator

SELECT c.first_name, c.last_name
	FROM customer c
	WHERE EXISTS
	(SELECT 1 FROM rental r
	WHERE r.customer_id = c.customer_id
	AND date(r.rental_date) < '2005-05-25');

-- Q1-2. Using Sakila DB
SELECT * FROM actor;
SELECT last_name FROM actor;
SELECT film_id, title, release_year FROM film;
SELECT DISTINCT lasnt_name FROM actor;
SELECT DISTINCT postal_code FROM address;
SELECT DISTINCT ratings FROM film;

-- Q3 USING WHERE
SELECT title, description, rating, length FROM film WHERE length > 180;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date > '2005-05-27';
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date BETWEEN '2005-05-27 00:00:00' AND '2005-05-27 23:59:59';
SELECT * FROM customer WHERE last_name LIKE 's%' AND first_name LIKE 'n%';
SELECT * FROM customer WHERE active = 0 AND last_name LIKE 'm%';
SELECT * FROM category WHERE category_id > 4 AND name LIKE 'C%' OR name LIKE 'T%' OR name LIKE 'S%';
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NOT NULL;
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff WHERE password IS NULL;

-- Q4 USING IN
SELECT phone, district FROM address WHERE district IN ('California', 'England', 'Taipei', 'West Java');
SELECT payment_id, amount, payment_date FROM payment WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');
SELECT * FROM film WHERE rating IN('G', 'PG-13', 'NC-17');

-- Q5 USING BETWEEN
SELECT * FROM payment WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-26 12:59:59';
SELECT film_id, title, description FROM film WHERE LENGTH(description) BETWEEN 100 AND 120;

-- Q6 USING LIKE
SELECT * FROM film WHERE description LIKE 'A Thoughtful%';
SELECT * FROM film WHERE description LIKE '% Boat';
SELECT * FROM film WHERE description LIKE '%Database%' AND length > 180;

-- Q7 USING LIMIT
SELECT * FROM payment LIMIT 20;
SELECT payment_id, payment_date, amount FROM payment WHERE amount > 5 AND payment_id BETWEEN 1000 AND 2000;
SELECT * FROM customer LIMIT 100 OFFSET 100;

-- Q8 USING ORDER BY
SELECT * FROM film ORDER BY length ASC;
SELECT DISTINCT rating FROM film ORDER BY rating DESC;
SELECT payment_date, amount FROM payment ORDER BY amount DESC LIMIT 20;
SELECT title, description, special_features, length, rental_duration FROM film WHERE special_features LIKE '%Behind the Scenes%' AND length < 120 AND rental_duration BETWEEN  5 AND 7 ORDER BY length DESC LIMIT 10;

-- Q9 JOINS
SELECT c.first_name, c.last_name, a.first_name, a.last_name FROM customer AS c
LEFT JOIN actor AS a
	USING(last_name);
SELECT c.first_name, c.last_name, a.first_name, a.last_name FROM customer AS c
RIGHT JOIN actor AS a
	USING(last_name);
SELECT c.first_name, c.last_name, a.first_name, a.last_name FROM customer AS c
JOIN actor AS a
	USING(last_name);
SELECT ci.city, c.country FROM city AS ci
LEFT JOIN country AS c
	USING(country_id);
SELECT title, description, release_year, l.name AS language FROM film
LEFT JOIN language AS l
	USING(language_id);
SELECT s.first_name, s.last_name, a.address, a.address2, c.city, a.district, a.postal_code FROM staff AS s
LEFT JOIN address AS a
	USING(address_id)
LEFT JOIN city AS c
	USING(city_id);

-- NEXT QUESTION SET
SELECT LOWER(first_name), LOWER(last_name) FROM actor;

SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

SELECT * FROM actor WHERE last_name LIKE '%gen%';

SELECT * FROM actor WHERE last_name LIKE '%li%' ORDER BY last_name, first_name;

SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

SELECT last_name, COUNT(last_name) AS count FROM actor GROUP BY last_name;

SELECT last_name, COUNT(last_name) AS count FROM actor GROUP BY last_name HAVING count > 1;

CREATE TABLE address;

SELECT CONCAT(first_name, ' ', last_name, ' ', a.address) AS n_a FROM staff
	JOIN address AS a
		USING(address_id);

SELECT staff_id, SUM(amount) AS  money FROM payment WHERE payment_date BETWEEN '2005-08-01 00:00:00' AND '2005-08-31 23:59:59' GROUP BY staff_id;


SELECT f.title, COUNT(fa.actor_id) FROM film AS f
JOIN film_actor AS fa
	USING(film_id)
GROUP BY f.title;

SELECT f.title, COUNT(i.film_id) FROM film AS f
JOIN inventory AS i
	USING(film_id)
WHERE f.title = 'Hunchback Impossible';

SELECT title FROM
(SELECT l.name, f.title FROM language AS l 
JOIN film AS f
	USING(language_id)
WHERE l.name = 'English') AS e
WHERE title LIKE 'k%' OR title LIKE 'q%';

SELECT a.first_name, a.last_name FROM (SELECT first_name, last_name, film.title FROM actor
JOIN film_actor
	USING(actor_id)
JOIN film
	USING(film_id)) AS a
WHERE title = 'Alone Trip';

SELECT first_name, last_name, email, address_id, district FROM customer AS c
JOIN address AS a
	USING(address_id)
JOIN city AS ci
	USING(city_id)
JOIN country AS cr
	USING(country_id)
WHERE cr.country = 'Canada';

SELECT title, c.name FROM film
JOIN film_category AS fc
	USING(film_id)
JOIN category AS c
	USING(category_id)
WHERE name = 'Family';	

SELECT SUM(amount) AS total, store_id
FROM payment AS p
JOIN customer AS c USING(customer_id)
JOIN store AS s USING(store_id)
GROUP BY store_id;

SELECT store_id, city, country
FROM store AS s
JOIN address AS a USING(address_id)
JOIN city AS c USING(city_id)
JOIN country AS ctry USING(country_id);

SELECT SUM(p.amount) AS total, c.name AS genre
FROM payment AS p
JOIN rental AS r USING(rental_id)
JOIN inventory AS i USING(inventory_id)
JOIN film_category AS f USING(film_id)
JOIN category AS c USING(category_id)
GROUP BY genre
ORDER BY total DESC LIMIT 5;

SELECT AVG(replacement_cost), rating FROM film
GROUP BY rating;

SELECT name, COUNT(title) FROM film
JOIN film_category
	USING(film_id)
JOIN category
	USING(category_id)
GROUP BY name;


SELECT title, COUNT(rental_id) AS times_rented
FROM rental r
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GR OUP BY title
ORDER BY times_rented DESC LIMIT 5;


SELECT title, SUM(amount) AS total
FROM payment p
JOIN rental r USING(rental_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY title
ORDER BY total DESC LIMIT 5;


SELECT CONCAT(first_name, ' ', last_name) AS full_name, SUM(amount) AS total
FROM payment p
JOIN customer c USING(customer_id)
GROUP BY full_name
ORDER BY total DESC LIMIT 1;


SELECT CONCAT(first_name, ' ', last_name) AS full_name, COUNT(film_id) AS times_cast
FROM actor a
JOIN film_actor fa USING(actor_id)
JOIN film f USING(film_id)
GROUP BY actor_id
ORDER BY times_cast DESC LIMIT 5;


SELECT SUBSTR(payment_date, 1, 7) AS month, store_id, SUM(amount)
FROM payment p
JOIN staff sf USING(staff_id)
JOIN store s USING(store_id)
WHERE payment_date LIKE '2005-%-%' 
GROUP BY month, store_id
ORDER BY month;


SELECT title, CONCAT(first_name, ' ', last_name) AS customer_name, phone, address 
FROM customer c
JOIN address a USING(address_id)
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
WHERE return_date IS NULL;


SELECT dept_name, (MAX(salary) - avg_dept_salary) AS salary_diff
FROM salaries s
JOIN dept_manager dm USING(emp_no)
JOIN departments d USING(dept_no)
JOIN (
SELECT dept_name, ROUND(AVG(salary), 2) AS avg_dept_salary
FROM salaries s
JOIN dept_emp de USING(emp_no)
JOIN departments d USING(dept_no)
GROUP BY dept_name) AS ads USING(dept_name)
GROUP BY dept_name; 


SELECT language, percentage FROM city
JOIN countrylanguage USING(countrycode)
WHERE name = 'Santa Monica';


SELECT region, COUNT(name) AS num_countries
FROM country 
GROUP BY region
ORDER BY num_countries;


SELECT region, SUM(population) AS total_pop
FROM country 
GROUP BY region
ORDER BY total_pop DESC;


SELECT continent, SUM(population) AS total_pop
FROM country 
GROUP BY continent
ORDER BY total_pop DESC;


SELECT AVG(lifeExpectancy)
FROM country;


SELECT continent, AVG(lifeExpectancy)
FROM country
GROUP BY continent
ORDER BY AVG(lifeExpectancy);

SELECT region, AVG(lifeExpectancy)
FROM country
GROUP BY region
ORDER BY AVG(lifeExpectancy);


SELECT country FROM country
WHERE country LIKE '%(%' OR '%,%';
SELECT * FROM country;

SELECT COUNT(lifeExpectancy) FROM country
WHERE lifeExpectancy < x;


SELECT district FROM city
WHERE name = 'x';


SELECT region FROM country ctry
JOIN city c ON c.countrycode = ctry.code
WHERE c.name = 'x';


SELECT ctry.name FROM country ctry
JOIN city c ON c.countrycode = ctry.code
WHERE c.name = 'x';


SELECT lifeExpectancy FROM country ctry
JOIN city c ON c.countrycode = ctry.code
WHERE c.name = 'x';


-- topping_id, topping_name, topping_price
-- pizza_id, order_id, crust_type_id, size_id (no correlation)


-- modifier_id, modifier_name, modifier_price
-- no correlation


-- they both share size_id


-- crust_types, pizza_modifiers, pizza_toppings, 


SELECT DISTINCT topping_name FROM toppings;



SELECT DISTINCT order_id FROM pizzas;



SELECT size_name, COUNT(size_id)
FROM sizes s
JOIN pizzas p USING(size_id)
GROUP BY size_name;



SELECT COUNT(order_id) FROM pizzas;


SELECT size_name, COUNT(size_id)
FROM sizes s
JOIN pizzas p USING(size_id)
GROUP BY size_name;


SELECT AVG(num_pizzas) FROM (
SELECT order_id, COUNT(pizza_id) AS num_pizzas FROM pizzas
GROUP BY order_id) AS p;


SELECT order_id, ROUND(SUM(new_topping_price + new_modifier_price + size_price), 2) AS total_price 
FROM (
SELECT order_id, size_price,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
ORDER BY order_id) AS np
GROUP BY order_id;


SELECT ROUND(AVG(new_topping_price + new_modifier_price + size_price), 2) AS total_price 
FROM (
SELECT order_id, size_price,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
ORDER BY order_id) AS np;


SELECT size_name, COUNT(size_id) 
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
ORDER BY order_id) AS np
GROUP BY size_name;


SELECT topping_name, COUNT(topping_id) 
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
ORDER BY order_id) AS np
GROUP BY topping_name
ORDER BY COUNT(topping_id) DESC;


SELECT COUNT(pizza_id) 
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
WHERE topping_amount = 0
ORDER BY order_id) AS np;


SELECT ROUND(AVG(new_topping_price + new_modifier_price + size_price), 2)
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
WHERE topping_amount = 0
ORDER BY order_id) AS np;


SELECT size_name, COUNT(size_id)
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
WHERE topping_amount = 0
ORDER BY order_id) AS np
GROUP BY size_name
ORDER BY COUNT(size_id) DESC;


SELECT COUNT(pizza_id)
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
WHERE topping_name = 'olives' AND size_name = 'large'
ORDER BY order_id) AS np;


SELECT AVG(num_of_toppings)
FROM (
SELECT pizza_id, COUNT(topping_id) AS num_of_toppings
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
GROUP BY pizza_id) AS np;



SELECT AVG(num_of_pizzas)
FROM (
SELECT order_id, COUNT(pizza_id) AS num_of_pizzas
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)
GROUP BY order_id) AS np;

SELECT ROUND(AVG(new_topping_price + new_modifier_price + size_price), 2)
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)) AS np;

SELECT AVG(order_total) FROM (
SELECT order_id, ROUND(AVG(new_topping_price + new_modifier_price + size_price), 2) AS order_total
FROM (
SELECT *,
	CASE 
		WHEN topping_amount = 'extra' THEN (topping_price * 1.5)
		WHEN topping_amount = 'double' THEN (topping_price * 2)
		WHEN topping_amount = 'light' THEN (topping_price * .5)
		WHEN topping_amount IS NULL THEN 0
		ELSE topping_amount 
END AS new_topping_price,
	CASE
		WHEN modifier_price IS NULL THEN 0
		ELSE modifier_price
END AS new_modifier_price
FROM pizzas p
JOIN sizes s USING(size_id)
JOIN crust_types c USING(crust_type_id)
LEFT JOIN pizza_toppings pt USING(pizza_id)
LEFT JOIN toppings t USING(topping_id)
LEFT JOIN pizza_modifiers pm USING(pizza_id)
LEFT JOIN modifiers m USING(modifier_id)) AS np
GROUP BY order_id) AS ot;
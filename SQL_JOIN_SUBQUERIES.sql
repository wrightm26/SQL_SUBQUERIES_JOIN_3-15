--1. List all customers who live in Texas (use JOINs)
SELECT c.first_name, c.last_name, a.district
FROM customer c
JOIN address a
ON c.address_id = a.address_id
WHERE district LIKE 'Texas';

--2. List all payments of more than $7.00 with the customer’s first and last name
SELECT c.first_name, c.last_name, p.amount
FROM payment p
JOIN customer c 
ON c.customer_id = p.customer_id 
WHERE p.amount IN (
	SELECT amount 
	FROM payment 
	WHERE amount > 7.00
)
ORDER BY first_name, last_name, amount;

--3. Show all customer names who have made over $175 in payments (use
--subqueries)
SELECT*
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM (
		SELECT SUM(amount), customer_id
		FROM payment
		GROUP BY customer_id
		HAVING SUM(amount) > 175
		ORDER BY SUM(amount) DESC
	)AS customer_info
)

--4. List all customers that live in Argentina (use the city table)


SELECT cu.first_name, cu.last_name, a.district, c.city, co.country
FROM customer cu 
JOIN address a
ON cu.address_id = a.address_id
JOIN city c
ON c.city_id = a.city_id
JOIN country co
ON c.country_id = co.country_id
WHERE country =  'Argentina'
ORDER BY c.city;

--5. Show all the film categories with their count in descending order

SELECT category_id, SUM(category_id)
FROM film_category
GROUP BY category_id, category_id
ORDER BY SUM(category_id) DESC;

--6. What film had the most actors in it (show film info)?
SELECT f.film_id, f.title, COUNT(fa.film_id)
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.film_id, fa.film_id
ORDER BY COUNT(fa.film_id) DESC
LIMIT 1

--7. Which actor has been in the least movies?

SELECT a.actor_id, a.first_name, a.last_name, SUM(fa.actor_id)
FROM film_actor fa
JOIN actor a
ON fa.actor_id = a.actor_id 
GROUP BY a.actor_id, fa.actor_id
ORDER BY fa.actor_id ASC 
LIMIT 1
 
--8. Which country has the most cities?

SELECT COUNT(c.country_id), c.country_id, co.country
FROM country co
JOIN city c 
ON c.country_id = co.country_id
GROUP BY c.country_id, co.country_id
ORDER BY COUNT(c.country_id) DESC
LIMIT 1

--9. List the actors who have been in between 20 and 25 films.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS count_
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(*) BETWEEN 20 AND 25 
ORDER BY actor_id  ASC;


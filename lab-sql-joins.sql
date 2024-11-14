-- Challenge - Joining on multiple tables
-- Write SQL queries to perform the following tasks using the Sakila database:

USE sakila;

-- List the number of films per category.
SELECT COUNT(film_id) AS number_of_films, c.name as film_category FROM sakila.film_category AS f
JOIN category as c
ON f.category_id = c.category_id
GROUP by film_category 
ORDER by number_of_films desc;

-- Retrieve the store ID, city, and country for each store.
SELECT s.store_id AS store_id, c.country AS country, ct.city AS city FROM sakila.store AS s
JOIN address AS a
ON s.address_id = a.address_id 
JOIN city as ct
ON a.city_id = ct.city_id
JOIN country as c
ON ct.country_id = c.country_id
GROUP by store_id, country, city;

-- Calculate the total revenue generated by each store in dollars.
SELECT 
CONCAT('$', FORMAT(SUM(p.amount), 2)) AS total_revenue,
i.store_id AS store_id
FROM payment AS p
JOIN rental as r
ON p.rental_id = r.rental_id
JOIN inventory as i 
ON r.inventory_id = i.inventory_id
GROUP by store_id;

-- Determine the average running time of films for each category.
SELECT c.name AS category, AVG(f.length) AS average_running_time
FROM film AS f
JOIN film_category AS fc 
ON f.film_id = fc.film_id
JOIN category AS c 
ON fc.category_id = c.category_id
GROUP BY category
ORDER by average_running_time;


-- Bonus:
-- Identify the film categories with the longest average running time.
SELECT c.name AS category, AVG(f.length) AS average_running_time
FROM film AS f
JOIN film_category as fc 
ON f.film_id = fc.film_id
JOIN category as c 
ON fc.category_id = c.category_id
GROUP BY category
ORDER by average_running_time
LIMIT 5;

-- Display the top 10 most frequently rented movies in descending order.
SELECT f.title as movie_title, COUNT(r.rental_id) as num_of_rentals FROM rental as r
JOIN inventory as i 
ON r.inventory_id = i.inventory_id
JOIN film as f
ON i.film_id = f.film_id
GROUP by movie_title
ORDER by num_of_rentals desc
LIMIT 10;


-- Determine if "Academy Dinosaur" can be rented from Store 1.
-- Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
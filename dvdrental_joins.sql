-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT first_name,last_name,district
FROM address
JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full
--Name
SELECT first_name,last_name,amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount ASC;


--3. Show all customers names who have made payments over $175(use
--subqueries)
SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC
);


--4. List all customers that live in Nepal (use the city
--table)
SELECT customer.first_name,customer.last_name,country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--5. Which staff member had the most
--transactions?
SELECT COUNT(last_name),last_name,first_name
FROM rental
FULL JOIN staff
ON rental.staff_id = staff.staff_id
GROUP BY last_name,first_name
ORDER BY last_name;

--6. How many movies of each rating are
--there?
SELECT COUNT(rating),rating
FROM film
GROUP BY rating
ORDER BY rating;

--7.Show all customers who have made a single payment
--above $6.99 (Use Subqueries)
SELECT store_id,first_name,last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM payment
GROUP BY customer_id,amount
HAVING amount > 6.99 AND COUNT(payment_id) = 1	
ORDER BY amount DESC
);

--8. How many free rentals did our stores give away?
SELECT COUNT(customer.customer_id)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount = 0;

USE sakila;

#1a  Display the first and last names of all actors from the table `actor`. 
SELECT first_name, last_name FROM actor;

#1b Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 
SELECT CONCAT(first_name, '  ', last_name) as 'Actor Name' FROM actor;

#2a find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";

#2b Find all actors whose last name contain the letters `GEN`:
SELECT actor_id, first_name, last_name FROM actor WHERE last_name like ('%GEN%');

#2c Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name:
SELECT actor_id, first_name, last_name FROM actor WHERE last_name like ('%LI%') ORDER BY last_name, first_name;

#2d Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
#SELECT country_id, country FROM country WHERE country in ('Afghanistan', 'Bangladesh', 'China');

#3a Add a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`:
#ALTER TABLE actor DROP COLUMN middle_name;
ALTER TABLE actor ADD COLUMN middle_name VARCHAR(20) AFTER first_name;

#3b Change the data type of the `middle_name` column to `blobs`.
ALTER TABLE actor ALTER COLUMN middle_name TYPE blobs;

#3c Now delete the `middle_name` column.
ALTER TABLE actor DROP COLUMN middle_name;
SELECT * FROM actor;

#4a List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT() FROM actor GROUP BY last_name;

#4b List last names of actors and the number of actors who have that last name, for names that are shared by at least two actors
SELECT last_name, COUNT() FROM actor GROUP BY last_name HAVING COUNT() >= 2;

#4c The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE actor SET first_name = 'HARPO' WHERE last_name = 'WILLIAMS' and first_name = 'GROUCHO';

#4d In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. Otherwise, change the first name to `MUCHO GROUCHO`,
UPDATE actor SET first_name = 
CASE WHEN first_name = 'GROUCHO' THEN 'MUNCHO GROUCHO' 
WHEN first_name = 'HARPO' THEN 'GROUCHO' END WHERE first_name IN ('HARPO' 'GROUCHO');


#5a You cannot locate the schema of the `address` table. Which query would you use to re-create it? 
DESCRIBE sakila.address;

#6a Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT s.first_name, s.last_name, a.address
FROM staff s LEFT JOIN address a ON s.address_id = a.address_id;

#6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL'
FROM staff s LEFT JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join
SELECT f.title, COUNT(a.actor_id) AS 'TOTAL'
FROM film f LEFT JOIN film_actor a ON f.film_id = a.film_id
GROUP BY f.title;

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, COUNT(inv.invetory_id) AS 'TOTAL'
FROM inventory inv LEFT JOIN film f ON f.film_id = inv.film_id
WHERE f.title = ('Hunchback Impossible') GROUP BY f.title;


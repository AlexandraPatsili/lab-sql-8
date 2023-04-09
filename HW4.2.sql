USE sakila;

-- 1 Write a query to display for each store its store ID, city, and country.

SELECT * from store as st
JOIN address as ad
ON st.address_id=ad.address_id;

SELECT * from address as ad
JOIN city as ct
ON ad.city_id=ct.city_id;

SELECT * from city as ct
JOIN country as cu
on ct.country_id=cu.country_id;

SELECT store_id, city, country from store as st
JOIN address as ad
on st.address_id=ad.address_id
JOIN city as ct
ON ad.city_id=ct.city_id
JOIN country as cu
on ct.country_id=cu.country_id;

-- 2 Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id, SUM(amount) from store as st 
JOIN staff sf
on st.store_id=sf.store_id
JOIN payment pa
on sf.staff_id=pa.staff_id
GROUP BY st.store_id;

-- 3 Which film categories are longest?

SELECT c.name, avg(length) from film as f
JOIN film_category as fc
on f.film_id=fc.film_id
JOIN category as c
on fc.category_id=c.category_id
GROUP BY c.name
HAVING avg(length) > (select avg(length) from film)
ORDER BY avg(length) desc;

-- 4 Display the most frequently rented movies in descending order.
SELECT ft.title, count(rental_id) FROM film as ft
JOIN inventory as i
ON ft.film_id=i.film_id
JOIN rental as r
on i.inventory_id=r.inventory_id
GROUP BY ft.title 
ORDER BY COUNT(rental_id) DESC;

-- 5 List the top five genres in gross revenue in descending order.

SELECT name, SUM(amount) from category as c
JOIN film_category fc
on c.category_id=fc.category_id
JOIN inventory as i
ON fc.film_id=i.film_id
JOIN rental as r
on i.inventory_id=r.inventory_id
JOIN payment as p
on r.rental_id=p.rental_id
GROUP by name
ORDER BY SUM(amount) DESC
LIMIT 5;


-- 6 Is "Academy Dinosaur" available for rent from Store 1? -- YES
SELECT title, st.store_id from film as f
JOIN inventory as i
on f.film_id=i.film_id
JOIN store  as st
ON i.store_id=st.store_id
HAVING title='Academy Dinosaur' AND store_id=1;


-- 7 Get all pairs of actors that worked together.
SELECT DISTINCT a1.actor_id, a2.actor_id from film_actor as fa
JOIN actor as a1
ON fa.actor_id=a1.actor_id
JOIN actor as a2 
ON fa.actor_id <> a2.actor_id
WHERE fa.film_id in (SELECT DISTINCT film_id from film_actor);

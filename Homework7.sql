select * from customer;
select last_name, first_name from customer where last_name like 'T%'
order by first_name;

select * from rental
where return_date between '2005-05-28' and '2005-06-02';

select film.title, count(*) as rental_total
from rental
join inventory  
on rental.inventory_id = inventory.inventory_id
join film
on inventory.film_id = film.film_id
group by film.title
order by rental_total desc
limit 10;
# There are a combination of queries to use to determine
which movies are rented the most. First would be the select
query to select the titles and count the films. Then, it would be to 
join the different columns by similar attributes and grouping by the film 
title. Finally, order by query determines which 10 movies are rented the most
in descending order.

select customer.first_name, customer.last_name, customer.customer_id, sum(payment.amount) as spent_films
from customer
join payment on customer.customer_id = payment.customer_id
join rental on payment.rental_id = rental.rental_id
join inventory on rental.inventory_id = inventory.inventory_id
group by customer.first_name, customer.last_name, customer.customer_id
order by spent_films ASC;

explain analyze select customer.first_name, customer.last_name, customer.customer_id, sum(payment.amount) as spent_films
from customer
join payment on customer.customer_id = payment.customer_id
join rental on payment.rental_id = rental.rental_id
join inventory on rental.inventory_id = inventory.inventory_id
group by customer.first_name, customer.last_name, customer.customer_id
order by spent_films ASC;
# This query also showcases the startup cost, estimated time, and number of rows. 
The output of this query results in how much each customer spent on movies in ascending
order. There are 4 sequential scans for this query as well as a planning time of 
1.350 ms and an execution time of 25.883 ms.


select actor.first_name, actor.last_name, actor.actor_id, count(film_actor.film_id) as actor_total
from actor
left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film_actor.film_id = film.film_id
where film.release_year = 2006
group by actor.first_name, actor.last_name, actor.actor_id
order by actor_total desc;

explain analyze select actor.first_name, actor.last_name, actor.actor_id, count(film_actor.film_id) as actor_total
from actor
left join film_actor on actor.actor_id = film_actor.actor_id
left join film on film_actor.film_id = film.film_id
where film.release_year = 2006
group by actor.first_name, actor.last_name, actor.actor_id
order by actor_total desc;
# In this query, there are 3 sequential scans which showcase
the startup cost, the estimated time, and the number of rows.
Also, this query outputs which actor was in the most movies in 2006
from greatest to least. The planning time was 0.737 ms and the execution
time was 8.138 ms.



select category.name, avg(film.rental_rate) as genre_rental_rate
from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
group by category.name
order by genre_rental_rate asc;

select category.name, count(rental.rental_id) as total_rental, sum(payment.amount) as total_sales
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by category.name
order by total_rental desc
limit 5;

select category.name, rental.rental_date, count(rental.rental_id)
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by category.name, rental.rental_date
order by rental.rental_date asc;
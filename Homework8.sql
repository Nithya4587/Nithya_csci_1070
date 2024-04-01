alter table rental
add status varchar(10);
select rental.rental_date, rental.return_date, film.rental_duration
from rental
group by
(case
	when rental.return_date > rental.rental_date + film.rental_duration then 'Late'
	when rental.return_date < rental.rental_date + film.rental_duration then 'Early'
	else 'On Time'
end);

select customer.customer_id, customer.first_name, customer.last_name, address.address_id, address.city_id, city.city_id, city.city, sum(payment.amount) as total_payment
from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join payment on customer.customer_id = payment.customer_id
where city.city in ('Saint Louis', 'Kansas City')
group by customer.customer_id, customer.first_name, customer.last_name, city.city, address.address_id, city.city_id;

select category.name, count(film_category.film_id) as total_count
from category
join film_category on category.category_id = film_category.category_id
group by category.name
order by total_count desc;

# There is a table for film category and category as the film category table
# showcases the film id and its corresponding category id while the category 
# table showcase the category id and the actual name of the category.

select film.film_id, film.title, film.length
from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
where rental.return_date between '2005-05-15' and '2005-05-31';

select film_id, title, rental_rate
from film
where rental_rate < 
(select avg(rental_rate) from film);

select count(*)
from rental
group by status

select film_id, 
	title, 
	length,
	ntile(100) over (order by length) as percentile
from film
order by percentile;

explain analyze select film_id, 
	title, 
	length,
	ntile(100) over (order by length) as percentile
from film
order by percentile;
# The planning time on this query was 0.121 ms and the 
# execution time was 1.808 ms. There is one seq scan on this query with the
# startup cost as 147.83, the actual time as 0.020..., and 1000 rows.
# This query also says it is a sort.
explain analyze select film.film_id, film.title, film.length
from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
where rental.return_date between '2005-05-15' and '2005-05-31';
# The second query is a nested loop. There are 2 seq scans that show
# a startup cost of 0.00.. and 0.00.., an actual time of 0.031.. and 
# 0.011.., and rows of 4581 and 295 respectively. As for the query itself,
# the planning time was 0.680 ms and the execution time was 4.795 ms.
# When comparing the two queries, they are different types as the first is a
# sort while the second is a nested loop. Also, the planning and execution times
# of the two queries are different as the first one had a shorter planning and
# execution time compared to the second one. Therefore, this means that 
# the server needed more time to plan and execute the nested loop query compared
# to the sort query.

# Set based programming is more about telling the machine what to do. This would
# include things like subqueries, join, etc. Procedural programming is 
# more about telling the machine how to get the results along with 
# what to do. Examples of this would be loops or functions
# Therefore, python would be considered procedural programming while 
# SQL would be considered as set based programming.
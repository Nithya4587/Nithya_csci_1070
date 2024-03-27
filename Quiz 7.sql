select * from payment; 
select amount from payment where amount > 9.99;

select * from payment;
select customer_id, amount, rental_id
from payment
where amount = ( select
max(amount)
from payment);
select * from rental;
select inventory_id from rental where rental_id = 14759;
select inventory_id from rental where rental_id = 15415;
select inventory_id from rental where rental_id = 14763;
select inventory_id from rental where rental_id = 16040;
select inventory_id from rental where rental_id = 11479;
select inventory_id from rental where rental_id = 4383;
select inventory_id from rental where rental_id = 3973;
select inventory_id from rental where rental_id = 8831;
select * from inventory;
select film_id from inventory where inventory_id = 3871;
select film_id from inventory where inventory_id = 4176;
select film_id from inventory where inventory_id = 1480;
select film_id from inventory where inventory_id = 3524;
select film_id from inventory where inventory_id = 4077;
select film_id from inventory where inventory_id = 2649;
select film_id from inventory where inventory_id = 2625;
select film_id from inventory where inventory_id = 3520;
select * from film;
select title from film where film_id = 846;
select title from film where film_id = 908;
select title from film where film_id = 324;
select title from film where film_id = 771;
select title from film where film_id = 889;
select title from film where film_id = 580;
select title from film where film_id = 575;
select title from film where film_id = 771;

select staff.first_name, staff.last_name, staff.email, address.address, city.city, country.country
from staff
left join address 
on staff.address_id = address.address_id
left join city
on address.city_id = city.city_id
left join country
on city.country_id = country.country_id;

I am in interested in working in computer forensics or a program more 
rooted in statistical analysis.

The crow's foot notation between city and country would be one and 
only one because the only common attribute between the two is
country_id.
-- Types of join:
-- LEFT JOIN
-- RIGHT JOIN
-- INNER JOIN
-- FULL OUTER JOIN
-- CROSS JOIN


select *
from pixar.pixar_films as f
inner join pixar.box_office as bo
	on f.film = bo.film;


select *
from pixar.pixar_films as f
left join pixar.box_office_earnings as bo
	on f.film = bo.film

select *
from pixar.pixar_films as f
right join pixar.box_office_earnings as bo
	on f.film = bo.film;


select *
from pixar.pixar_films as f
full outer join pixar.box_office_earnings as bo
	on f.film = bo.film;



select
	film,
	nullif(budget, 'NA')::numeric as budget,
	box_office_us_canada::numeric as box_office_us_canada,
	box_office_other::numeric as box_office_other,
	box_office_worldwide::numeric as box_office_worldwide
from pixar.box_office;


-- CTAS
create table pixar.box_office_earnings
as
select
	film,
	nullif(budget, 'NA')::numeric as budget,
	box_office_us_canada::numeric as box_office_us_canada,
	box_office_other::numeric as box_office_other,
	box_office_worldwide::numeric as box_office_worldwide
from pixar.box_office;

select * from pixar.pixar_films
where film not ilike 'Toy Story%';


insert into pixar.pixar_films values
(33, 'ABC', '2010-10-10', 93, 'G', 'Test another movie'),
(34, 'ABC 1', '2010-11-10', 83, 'G', 'Test another movie 1'),
(35, 'ABC 2', '2012-10-10', 105, 'PG', 'Test another movie 2')

insert into pixar.pixar_films (id, film) values
(36, 'WXZ')



select * from pixar.box_office_earnings



insert into pixar.box_office_earnings;
select
	concat(film, ' extra'),
	budget*1.5,
	box_office_us_canada * 1.39,
	box_office_other * 0.7,
	box_office_us_canada * 1.39 + box_office_other * 0.7
from pixar.box_office_earnings
where film not ilike '% %'
limit 5;




select
	film,
	budget*1.5,
	box_office_us_canada * 1.39,
	box_office_other * 0.7,
	box_office_us_canada * 1.39 + box_office_other * 0.7
from pixar.box_office_earnings
where film ilike '% %'


select film
from pixar.pixar_films
order by film
limit 10
offset 3


select * from pixar.pixar_films

update pixar.pixar_films
set film = 'Self', release_date = '2024-02-02', run_time = 6, plot = 'A wooden puppet who desperately wants to fit in makes an ill-fated wish upon a star, sparking a journey of self-discovery.',
film_rating = 'PG'
where id = '30';


update pixar.pixar_films
set release_date = '2024-02-02', run_time = 6, plot = 'A wooden puppet who desperately wants to fit in makes an ill-fated wish upon a star, sparking a journey of self-discovery.',
film_rating = 'PG'
where id = '29';



delete from pixar.pixar_films
where id = '34';

delete from pixar.pixar_films
where id in ('36', '31');


select * from pixar.pixar_films
where film ilike '%self%';





select
	f.film_rating,
	sum(b.box_office_worldwide) as total_earnings
from pixar.pixar_films as f
inner join pixar.box_office_earnings as b
	on f.film = b.film
group by 1;


select film_rating
from (
	select
		f.film_rating,
		sum(b.box_office_worldwide) as total_earnings
	from pixar.pixar_films as f
	inner join pixar.box_office_earnings as b
		on f.film = b.film
	group by 1
	order by total_earnings desc
	limit 1
)
;

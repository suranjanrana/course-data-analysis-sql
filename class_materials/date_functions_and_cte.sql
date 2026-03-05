select e.film, f.release_date, f.run_time, e.budget, e.box_office_worldwide
from pixar.box_office_earnings as e
inner join pixar.pixar_films as f
	on e.film = f.film;



select film, release_date, run_time, budget, box_office_worldwide
from pixar.box_office_earnings as e
left join pixar.pixar_films as f
	using (film)
where release_date < '2015-01-01';



select film, release_date, run_time, budget, box_office_worldwide
from pixar.box_office_earnings as e
left join pixar.pixar_films as f
	using (film)
where release_date between '2001-11-02' and '2013-06-21';



select film, release_date, run_time, budget, box_office_worldwide
from pixar.box_office_earnings as e
left join pixar.pixar_films as f
	using (film)
where release_date >= '2001-11-02' and release_date <= '2013-06-21';

-- DATEADD (datepart, number, date)

select
	film,
	release_date,
	release_date + interval '10 years 2 months 15 days' as release_after_10y,
	run_time,
	budget,
	box_office_worldwide,
	box_office_worldwide - 0.1 * box_office_worldwide as box_office_earning_after_10y
from pixar.box_office_earnings as e
left join pixar.pixar_films as f
	using (film)
where release_date >= '2001-11-02' and release_date <= '2013-06-21';




-- How many movies were released 10 years from now?

select *
from pixar.pixar_films as f
where release_date >= current_date - interval '10 years';

select *
from pixar.pixar_films as f
where extract(year from release_date) >= extract(year from current_date - interval '10 years');




select
	film,
	release_date,
	current_date - interval '10 years' as ten_yrs_frm_now,
	release_date >= current_date - interval '10 years'
from pixar.pixar_films



select (now() - interval '10 years')::date;


select extract(day from '2024-02-11'::date);

select '2025-01-01' = '2025-01-01';


select CURRENT_DATE;









with films as (
	select
		film,
		release_date,
		run_time,
		budget,
		box_office_worldwide
	from pixar.box_office_earnings as e
	left join pixar.pixar_films as f
		using (film)
),

films_released_after_10_yrs as (
	select
		film,
		release_date + interval '10 yrs 2 months 3 days' as released_date_after_10yrs,
		run_time,
		budget,
		box_office_worldwide - 0.174 * box_office_worldwide as box_office_after_10yrs
	from pixar.box_office_earnings as e
	left join pixar.pixar_films as f
		using (film)
	where release_date >= '2001-11-02' and release_date <= '2013-06-21'
),

rows_combined as (
	select *, 'film' as _src_cte from films
	union all
	select *, 'films_release_after_10_yrs' as _src_cte from films_released_after_10_yrs
)

select * from rows_combined
order by 1, 2;





with films as (
	select
		film,
		release_date,
		run_time,
		budget,
		box_office_worldwide
	from pixar.box_office_earnings as e
	left join pixar.pixar_films as f
		using (film)
),

films_released_after_10_yrs as (
	select
		film,
		release_date + interval '10 yrs 2 months 3 days' as released_date_after_10yrs,
		run_time,
		budget,
		box_office_worldwide - 0.174 * box_office_worldwide as box_office_after_10yrs
	from films
	where release_date >= '2001-11-02' and release_date <= '2013-06-21'
),

rows_combined as (
	select *, 'film' as _src_cte from films
	union all
	select *, 'films_release_after_10_yrs' as _src_cte from films_released_after_10_yrs
)

select * from rows_combined
order by 1, 2;





-- Create table and store the result
create table pixar.pixar_films_test as
with films as (
	select
		film,
		release_date,
		run_time,
		budget,
		box_office_worldwide
	from pixar.box_office_earnings as e
	left join pixar.pixar_films as f
		using (film)
),

films_released_after_10_yrs as (
	select
		film,
		release_date + interval '10 yrs 2 months 3 days' as released_date_after_10yrs,
		run_time,
		budget,
		box_office_worldwide - 0.174 * box_office_worldwide as box_office_after_10yrs
	from films
	where release_date >= '2001-11-02' and release_date <= '2013-06-21'
),

rows_combined as (
	select * from films
	union all
	select * from films_released_after_10_yrs
)

select * from rows_combined
;




select * from pixar.pixar_films_test
order by 1;



select film
from pixar.box_office_earnings
where box_office_worldwide = (select max(box_office_worldwide) from pixar.box_office_earnings);



select film
from pixar.box_office_earnings
order by box_office_worldwide desc
limit 1;




select film
from pixar.pixar_films_test
where box_office_worldwide = (select max(box_office_worldwide) from pixar.pixar_films_test);



select
	film,
	sum(box_office_worldwide) as total_box_office_worldwide
from pixar.pixar_films_test
where film ilike 't%'
group by 1
order by total_box_office_worldwide desc
limit 1;



select
	film,
	sum(box_office_worldwide) as total_box_office_worldwide
from pixar.pixar_films_test
where sum(box_office_worldwide) = (select max(box_office_worldwide) from pixar.pixar_films_test)
group by 1;



select
	film,
	sum(box_office_worldwide) as total_box_office_worldwide
from pixar.pixar_films_test
where film ilike 't%'
group by 1
having sum(box_office_worldwide) = (select max(box_office_worldwide) from pixar.pixar_films_test);





-- Film with maxmimun earning using cte and subquery
with earnings_of_films_starting_with_t as (
	select
		film,
		sum(box_office_worldwide) as total_box_office_worldwide
	from pixar.pixar_films_test
	where film ilike 't%'
	group by 1
),

max_earning as (
	select max(total_box_office_worldwide) as max_box_office_worldwide from earnings_of_films_starting_with_t
)

select film from earnings_of_films_starting_with_t
where total_box_office_worldwide = (select max_box_office_worldwide from max_earning);





-- Film with maxmimun earning using cte and subquery (cleaner)
with earnings_of_films_starting_with_t as (
	select
		film,
		sum(box_office_worldwide) as total_box_office_worldwide
	from pixar.pixar_films_test
	where film ilike 't%'
	group by 1
)

select film from earnings_of_films_starting_with_t
where total_box_office_worldwide = (select max(total_box_office_worldwide) from earnings_of_films_starting_with_t);




-- Film with maxmimun earning using cte and subquery (using sort)
with earnings_of_films_starting_with_t as (
	select
		film,
		sum(box_office_worldwide) as total_box_office_worldwide
	from pixar.pixar_films_test
	where film ilike 't%'
	group by 1
	order by total_box_office_worldwide desc
)
select film from earnings_of_films_starting_with_t
limit 1;
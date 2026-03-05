with pixar_films as (
	select
		*,
		(budget / 10000000.0000)::numeric(5, 2) as budget_in_millions
	from pixar.pixar_films_test
	where budget is not null and release_date is not null
),

budget_round_down_to_nearest_million as (
	select
		*,
		floor(budget_in_millions / 5) * 5 as budget_round_down
	from pixar_films
),

budget_category as (
	select
		*,
		budget_round_down || 'M - ' || budget_round_down + 5 || 'M' as budget_range
	from budget_round_down_to_nearest_million
),

film_earnings_by_budget as (
	select
		budget_range,
		film,
		sum(box_office_worldwide) as total_earning
	from budget_category
	group by 1, 2
),

film_ranking as (
	select
		*,
		rank() over (partition by budget_range order by total_earning desc) as film_rank
	from film_earnings_by_budget
)

select
	budget_range,
	film,
	total_earning
from film_ranking
where film_rank = 1
order by budget_range;





select round(2503.75, -1), round(2507.75, -1);


select floor(2507.75 / 10) * 10, ceil(2507.75 / 10) * 10;






-- Storing a logic in view
create view pixar.pixar_film_cleaned_data as
with pixar_films as (
	select
		*,
		(budget / 10000000.0000)::numeric(5, 2) as budget_in_millions
	from pixar.pixar_films_test
	where budget is not null and release_date is not null
),

budget_round_down_to_nearest_million as (
	select
		*,
		floor(budget_in_millions / 5) * 5 as budget_round_down
	from pixar_films
),

budget_category as (
	select
		*,
		budget_round_down || 'M - ' || budget_round_down + 5 || 'M' as budget_range
	from budget_round_down_to_nearest_million
)

select * from budget_category;




-- select data using view
select * from pixar.pixar_film_cleaned_data;





-- using view for further transformations
with film_earnings_by_budget as (
	select
		budget_range,
		film,
		sum(box_office_worldwide) as total_earning
	from pixar.pixar_film_cleaned_data -- using view instead of table
	group by 1, 2
),

film_ranking as (
	select
		*,
		rank() over (partition by budget_range order by total_earning desc) as film_rank,
		max(total_earning) over () as max_earning
	from film_earnings_by_budget
),

is_earning_greater_than_max_earning as (
	select
		budget_range,
		film,
		total_earning,
		not(total_earning < max_earning) as is_max_earning
	from film_ranking
	where film_rank = 1
)

select * from is_earning_greater_than_max_earning;





-- Find the budget category which has earnings higher than the average earning
with film_earnings_by_budget as (
	select
		budget_range,
		film,
		sum(box_office_worldwide) as total_earning
	from pixar.pixar_film_cleaned_data -- using view instead of table
	group by 1, 2
),

film_ranking as (
	select
		*,
		rank() over (partition by budget_range order by total_earning desc) as film_rank,
		avg(total_earning) over () as average_earning
	from film_earnings_by_budget
),

is_earning_greater_than_avg_earning as (
	select
		budget_range,
		film,
		to_char(total_earning, 'L999G999G999G000D00') as total_earning,
		to_char(average_earning, 'L999G999G999G000D00') as average_earning,
		total_earning >= average_earning as is_avg_earning,
		to_char(total_earning - average_earning, 'L999G999G999G000D00') as diff_from_avg
	from film_ranking
	where film_rank = 1
)

select * from is_earning_greater_than_avg_earning;




-- Display views stored in postgres
SELECT definition
FROM pg_views
WHERE viewname = 'pixar_film_cleaned_data'
	and schemaname='pixar';

select count(distinct film)
from pixar.pixar_films_test
where release_date >= '2005-01-01' and release_date <= '2010-12-31';


select count(distinct film)
from pixar.pixar_films_test
where extract(year from release_date) >= 2005 and extract(year from release_date) <= 2010;



-- Data transformation and cleaning
with budgets as (
	select distinct (budget / 10000000.0000)::numeric(5, 2) as budget_in_millions
	from pixar.pixar_films_test
	order by 1
),
budget_round_down_to_nearest_million as (
	select budget_in_millions, floor(budget_in_millions / 10) * 10 as budget_round_down from budgets
)
select budget_in_millions, budget_round_down || 'M - ' || budget_round_down + 10 || 'M' from budget_round_down_to_nearest_million
;



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

budget_catagory as (
	select
		*,
		budget_round_down || 'M - ' || budget_round_down + 5 || 'M' as budget_range
	from budget_round_down_to_nearest_million
)

select
	budget_range,
	count(distinct film) as film_count
from budget_catagory
group by 1;
select fil
from pixar.box_office
limit 10;


-- ist of countries
-- No. of sales by country
-- Age group with the highest number of sales
-- Highest selling product for that age group
-- Find the total profit
-- Find the calculated cost. Calculated cost = Order qty * unit cost
-- Is the calculated_cost equal to the cost column?
-- On which day did we have the highest number of sales?
-- Did we have any sale where we lost money? If yes, how many?
-- What is the most profitable product?
-- Calculate the profit percentage for each category. % profit = profit / cost * 100%

-- Questions:
-- 1. Find the most popular product in each country
-- 2. Calculate the yearly revenue
-- 3. Find the sales trend
-- 4. Do we have more male customers or female customers?
-- 5. What are the top 5 products for each gender?





create table sales.sales_data (
sn varchar,
date varchar (50),
Day varchar,
Month varchar (50),
Year varchar,
Customer_Age varchar,
Age_Group varchar(50),
Customer_Gender varchar (50),
Country	varchar (50),
State varchar (50),
Product_Category varchar (50),
Sub_Category varchar (50),
Product varchar (50),
Order_Quantity varchar,
Unit_Cost varchar,
Unit_Price varchar,
Profit varchar,
Cost varchar,
Revenue varchar
);


-- What are the top 5 products for each gender?
select * from (
	select
		Customer_Gender,
		product,
		count(*) as sales_count
	from sales.sales_data
	where customer_gender = 'M'
	group by 1, 2
	limit 5
)
union all
select * from (
	select
		Customer_Gender,
		product,
		count(*) as sales_count
	from sales.sales_data
	where customer_gender = '5'
	group by 1, 2
	limit 5
);




select 'A' as col1, 'B' as col2
union all
select 'A' as col1, 'C' as col2
union all
select 'A' as col1, 'B' as col2;



copy sales.sales_data from '/home/suranjanrana/Downloads/Datasets/FreeCodeCamp-Pandas-Real-Life-Example-master/data/sales_data.csv'
delimiter ','
csv header;






-- Common table expression (CTE)


with cte1 as (
	select 'A' as col1, 'B' as col2
	union all
	select 'A' as col1, 'C' as col2
	union all
	select 'A' as col1, 'B' as col2
),
cte2 as (
	select 'A1' as col1, 'B' as col2
	union all
	select 'A1' as col1, 'C' as col2
	union all
	select 'A1' as col1, 'B' as col2
)
select * from cte1;



select film, run_time from pixar.pixar_films;

with film as (
	select film, run_time from pixar.pixar_films
),
box_office as (
	select film, box_office_worldwide from pixar.box_office_earnings
)
select * from film
le;
;






with sales_by_gender as (
	select
		Customer_Gender,
		product,
		count(*) as sales_count
	from sales.sales_data
	group by 1, 2
),
male_sales as (
	select * from sales_by_gender
	where Customer_Gender = 'M'
	order by sales_count desc
	limit 5
),
female_sales as (
	select * from sales_by_gender
	where Customer_Gender = 'F'
	order by sales_count desc
	limit 5
)
select * from male_sales
union all
select * from female_sales;






select * from pixar.pixar_films;


select * from pixar.box_office_earnings;



select
	film,
	sum(budget) as total_budget
from pixar.box_office_earnings
group by 1
order by 1 desc;



select film
from pixar.box_office_earnings
where box_office_worldwide 
select max(box_office_worldwide) from pixar.box_office_earnings;









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


select * from pixar.pixar_films;

select * from pixar.box_office_earnings;

select * from pixar.pixar_films_test;



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



select * from pixar.pixar_films_test;

select * from pixar.pixar_film_cleaned_data;




select
	*,
	sum(box_office_worldwide) over ()
from pixar.pixar_film_cleaned_data;

select sum(box_office_worldwide) from pixar.pixar_film_cleaned_data;

-- 23007011549.834



select *, rank() over (partition by budget_range order by box_office_worldwide desc)
from pixar.pixar_film_cleaned_data;

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



with pixar_films as (
	select * from pixar.pixar_film_cleaned_data
),
films_row_numbered as (
	select
		*,
		row_number() over (partition by film order by release_date) as rn
	from pixar_films
)
select * from films_row_numbered where rn = 1
;




with pixar_films as (
	select * from pixar.pixar_film_cleaned_data
),
films_row_numbered as (
	select
		film,
		row_number() over (order by film) as rn,
		rank() over (order by film) as ranked,
		dense_rank() over (order by film) as dense_ranked
	from pixar_films
)
select * from films_row_numbered
;




-- Display views stored in postgres
SELECT definition
FROM pg_views
WHERE viewname = 'pixar_film_cleaned_data'
	and schemaname='pixar';




select * FROM pg_views;








-- Find the budget category which has earnings higher than the average earning
with films_row_numbered as (
	select
		*,
		row_number() over (partition by film order by release_date) as rn
	from pixar.pixar_film_cleaned_data
),

film_earnings_by_budget as (
	select
		budget_range,
		film,
		sum(box_office_worldwide) as total_earning
	from films_row_numbered
	where rn = 1
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






-- cte: common table expression

-- with <name_of_cte> as ( select query ),
-- <name of 2nd cte> as ( select query ),
-- .......
-- <name of nth cte> as ( select query )
-- select * from name_of_nth_cte



with pixar_films as (
	select
		film,
		release_date,
		run_time
	from pixar.pixar_films
),
film_earning as (
	select
		film as film_name,
		budget,
		box_office_worldwide as box_office_earning
	from pixar.box_office_earnings
),
film_detail as (
	select
		pixar_films.film,
		pixar_films.release_date,
		pixar_films.run_time,
		film_earning.budget,
		film_earning.box_office_earning
	from pixar_films
	inner join film_earning
		on pixar_films.film = film_earning.film_name
)
select * from film_detail;






select
	*,
	sum(box_office_worldwide) over ()
from pixar.pixar_film_cleaned_data;

select sum(box_office_worldwide) from pixar.pixar_film_cleaned_data;



select *
from pixar.pixar_film_cleaned_data
cross join (select sum(box_office_worldwide) from pixar.pixar_film_cleaned_data);




select *
from pixar.pixar_film_cleaned_data,
(select sum(box_office_worldwide) from pixar.pixar_film_cleaned_data);



select pixar_films.id, pixar_films.film, box_office_earnings.film, box_office_earnings.budget
from pixar.pixar_films, pixar.box_office_earnings;




select avg(days_diff) / 365 from (
	select
		film,
		release_date,
		lead(release_date) over (order by release_date) as next_release_date,
		lead(release_date) over (order by release_date) - release_date as days_diff
	from pixar.pixar_films
	where release_date is not null
)
;



with next_film_release_date as (
	select
		film,
		release_date,
		lead(release_date) over (order by release_date) as next_release_date
	from pixar.pixar_films
	where release_date is not null
),

date_diff_in_days as (
	select
		*,
		(next_release_date - release_date) as days_diff
	from next_film_release_date
),

average_days as (
	select avg(days_diff) from date_diff_in_days
)

select * from average_days;





with next_film_release_date as (
	select
		film,
		release_date,
		lead(release_date) over (order by release_date) as next_release_date
	from pixar.pixar_films
	where release_date is not null
),

date_diff_in_days as (
	select
		*,
		(next_release_date - release_date) as days_diff
	from next_film_release_date
),

running_total as (
	select
		*,
		sum(days_diff) over () as total_days,
		sum(days_diff) over (order by release_date)
	from date_diff_in_days
)

select * from running_total;





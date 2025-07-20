-- This query calculates the profit and profit percentage for Pixar films
-- Since the budget and other columns are stored as varchar, we need to convert it to numeric.
-- The handling of 'NA' values and data type conversion is done in a subquery.
-- For the data type conversion, we have used the numeric data type instead of float.
    -- numeric can store a larger range of values and is suitable for financial calculations.
    -- numeric data type is like float but is more precise.
    -- Syntax: numeric(percision, scale). Example: numeric(6, 4) can store numbers up to 6 digits with 4 digits after the decimal point like 23.1234.
    -- The data type float / double precision is inexact while the data type numeric is exact.
    -- Inexact means that some values cannot be converted exactly to the internal format and are stored as approximations which can lead to rounding errors in financial calculations.
    -- Documentation: https://www.postgresql.org/docs/8.1/functions-math.html
    -- Documentation: https://www.postgresql.org/docs/current/datatype-numeric.html
-- The box office columns are also converted to numeric for consistency.
-- The profit percentage is calculated as (profit / budget) * 100 where, profit = box_office_worldwide - budget
-- The results are rounded to 2 decimal places for better readability
-- Here, we are selecting all columns from the subquery and calculating the profit and profit percentage.
select
    *,
    box_office_worldwide - budget as profit,
    round((box_office_worldwide - budget) / budget, 2) as profit_percentage -- rounding to 2 decimal places
-- this is a subquery
from (
    select
        film,
        nullif(budget, 'NA')::numeric as budget,
        box_office_us_canada::numeric as box_office_us_canada,
        box_office_other::numeric as box_office_other,
        box_office_worldwide::numeric as box_office_worldwide
    from pixar.box_office
);


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Q: Top 10 films with the highest profit percentage
-- The films are ordered by profit percentage in descending order
-- Since we only require the film names, we select only the film column and the profit percentage is calculated in the order by clause.
-- When the values are ordered in descending order, the nulls values appear at the top so, we use nulls last to place them at the end.
-- The limit is set to 10 to get the top 10 films.
select film
from (
    -- selecting only the required columns in the subquery
    select
        film,
        nullif(budget, 'NA')::numeric as budget, -- using nullif to convert the text value 'NA' to null
        box_office_worldwide::numeric as box_office_worldwide
    from pixar.box_office
)
order by ((box_office_worldwide - budget) / budget) desc nulls last -- using nulls last to place null values at the end
limit 10; -- limiting the results to get the top 10 films


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Q: Find films with a budget greater than $100 million and a profit percentage greater than 500%.
-- The profit percentage is calculated in the where clause to get the films that meet the criteria.
select
    film,
    round((box_office_worldwide - budget) / budget * 100, 2) as profit_percentage
from (
    select
        film,
        nullif(budget, 'NA')::numeric as budget,
        box_office_worldwide::numeric as box_office_worldwide
    from pixar.box_office
)
where budget > 100000000 and ((box_office_worldwide - budget) / budget) > 5;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Q: How many films earned profit more then 3 times their budget in box office revenue worldwide?
-- Here, profit = box_office_worldwide - budget
-- The count(*) function is used to count the number of films that meet the criteria.
-- The order order of execution is
    -- 1. the subquery is executed
    -- 2. then where clause filters the results
    -- 3. and finally the count() function calculates the number of films
select count(*) as films_with_high_profit
from (
    select
        film,
        nullif(budget, 'NA')::numeric as budget,
        box_office_worldwide::numeric as box_office_worldwide
    from pixar.box_office
)
where (box_office_worldwide - budget) > 3 * budget; -- filtering films with profit more than 3 times their budget

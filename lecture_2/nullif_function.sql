-- Using nullif() function to handle 'NA' values in budget column
-- The nullif() function returns NULL if the two arguments are equal, otherwise it returns the first argument
-- Syntax: nullif(expression1, expression2). If expression1 is equal to expression2, it returns NULL, otherwise it returns expression1.
-- In this case, if the budget is 'NA', it will return NULL, otherwise it will return the budget value.
-- This is useful to avoid errors when performing calculations on the budget column.
select *, nullif(budget, 'NA')::int from pixar.box_office;

-- Calculating profit
select
    *,
    cast(box_office_worldwide as float) - cast(nullif(budget, 'NA') as float) as profit
from pixar.box_office;

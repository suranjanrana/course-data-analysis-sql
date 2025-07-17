-- Using nullif() function to handle 'NA' values in budget column
-- The nullif() function returns NULL if the two arguments are equal, otherwise it returns the first argument
select *, nullif(budget, 'NA')::int from pixar.box_office;

-- Calculating profit
select
	*,
	cast(box_office_worldwide as float) - cast(nullif(budget, 'NA') as float) as profit
from pixar.box_office;

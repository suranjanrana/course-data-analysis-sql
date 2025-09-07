-- Type cast example
SELECT 25.65, CAST(25.65 AS int);

-- Changing the type of the columns from int to float by using CAST and :: operator
-- The first example uses CAST function, the second uses the :: operator
-- The result is the same, but the syntax is different
select
    film,
    cast(box_office_us_canada as float) as box_office_us_canada,
    box_office_other::float as box_office_other
from pixar.box_office;

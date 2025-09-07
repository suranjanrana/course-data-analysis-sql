-- This filters the Pixar box office data to show only the records where the budget is 'NA'
select * from pixar.box_office
where budget = 'NA';

-- This filters the Pixar box office data to show only the records where the box office from US/Canada is less than 20 million and budget is not 'NA'
select * from pixar.box_office
where box_office_us_canada < 20000000 and budget != 'NA';

-- This sorts the Pixar box office data by budget in descending order and then by film name in ascending order
select * from pixar.box_office
order by budget desc, film

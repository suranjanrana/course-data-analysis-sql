-- select all columns from the pixar_films table and limit the result to 10 rows
select * from pixar.pixar_films limit 10;

-- select columns film, run_time, film_rating from the pixar_films table and limit the result to 10 rows
select film, run_time, film_rating from pixar.pixar_films limit 10;

-- Top 10 movies with the longest run_time
select film from pixar.pixar_films order by run_time desc limit 10;


-- SQL Aggregation Functions
-- Total rows in the table
-- The count(*) function counts the total number of rows in the pixar_films table.
select count(*) from pixar.pixar_films;

-- Total run time of the films in the table
-- The sum(run_time) function sums up all the values in the run_time column of the pixar_films table.
select sum(run_time) from pixar.pixar_films;

-- Minimum run time
-- The min(run_time) function finds the minimum value in the run_time column of the pixar_films table.
select min(run_time) from pixar.pixar_films;

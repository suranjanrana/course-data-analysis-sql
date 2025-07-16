-- select all columns from the pixar_films table and limit the result to 10 rows
select * from pixar.pixar_films limit 10;

-- select columns film, run_time, film_rating from the pixar_films table and limit the result to 10 rows
select film, run_time, film_rating from pixar.pixar_films limit 10;

-- Top 10 movies with the longest run_time
select film from pixar.pixar_films order by run_time desc limit 10;


-- SQL Aggregation Functions
-- Total rows in the table
select count(*) from pixar.pixar_films;

-- Total run time of the films in the table
select sum(run_time) from pixar.pixar_films;

-- Minimum run time
select min(run_time) from pixar.pixar_films;

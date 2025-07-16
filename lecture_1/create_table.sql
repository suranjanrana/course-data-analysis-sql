-- create schema (Creates a new schema in the database)
create schema pixar;


-- Description:
-- create table (Creates a new table in the database)
-- The table is created in the 'pixar' schema
-- The table has columns for id, film, release_date, run_time, film_rating, and plot, with appropriate data types
-- The 'id' column is set as the primary key (optional)

-- Syntax for creating a table in SQL
-- CREATE TABLE schema_name.table_name (
--     column_name data_type,
--     column_name data_type,
--     ...
--     CONSTRAINT constraint_name PRIMARY KEY (column_name)
-- );
create table pixar.pixar_films (
    id integer,
    film varchar(100),
    release_date date,
    run_time integer,
    film_rating varchar(10),
    plot varchar(500),
    primary key (id) -- optional
);


-- drop table (Deletes the table from the database and all its data)
drop table pixar.pixar_films;

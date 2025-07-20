-- Here, GROUP BY is used to aggregate the results by the film category.
-- The count(*) function counts the total number of rows for each category.
-- The result will show the category and the total number of rows for each category in the pixar.genres table.
select
    category,
    count(*) as total_row_count
from pixar.genres
group by category;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Here, we are counting the distinct values in the 'value' column for each category.
-- The count(distinct value) function counts the number of unique values in the 'value' column for each category.
-- The result will show the category and the total number of distinct values for each category in the pixar.genres table.
-- This is useful to understand how many unique genres or categories exist in the dataset.
select
    category,
    count(distinct value) as total_categories
from pixar.genres
group by category;


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Here, we are counting the total number of films for each genre.
-- The category column contains the values 'Genre' and 'Sub-Genre' and the 'value' column contains the genre names and the sub-genre names respectively.
-- So, by filtering the category 'Genre' using the WHERE clause, we get only the rows that belong to the genre category
-- i.e., only the names of the genres in the value column.
-- The count(film) function counts the number of films for each genre.
-- The result will show the genre and the total number of films for each genre in the pixar.genres table.
-- This is useful to understand how many films belong to each genre.
select
	value,
	count(film) as total_films
from pixar.genres
where category = 'Genre'
group by 1 -- group by 1 denotes grouping by the first column in the select statement, which is 'value'
order by total_films desc; -- ordering the results by total_films in descending order to see the most popular genres first


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Grouping by multiple columns allows us to see the total number of films for each genre and sub-genre.
-- Grouping by both category and value to get the total number of films for each genre and sub-genre.
select
    category,
    value,
    count(film) as total_films
from pixar.genres
group by 1, 2 -- group by 1 and 2 denotes grouping by the first and second columns in the select statement, which are 'category' and 'value'
order by 1, 3 desc; -- ordering the results by category and total_films in descending order to see the most popular genres first within each category

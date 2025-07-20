-- Q: How much did the movie "The Incredibles" made worldwide? (Only display the amount)
select box_office_worldwide
from pixar.box_office
where film = 'The Incredibles'; -- filtering the film by name to get the worldwide box office revenue


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Here we are using the LIKE operator to perform a case-sensitive search for films that contain the text 'Incredibles' in their name.
-- LIKE allows for pattern matching, where '%' is a wildcard that matches any sequence of characters.
-- The wildcard '%' means any sequence of character or no character at all. By adding '%' before and after 'Incredibles', any characters can appear before or after 'Incredibles' in the film name.
-- Case-sensitive means that it distinguishes between uppercase and lowercase letters; for example, 'Incredibles' and 'incredibles' would be treated as different strings.
-- Case-sensitive search is useful when you want to find exact matches that respect the case of the letters in the text.
select *
from pixar.box_office
where film like '%Incredibles%'; -- using LIKE to find films that contains the text 'Incredibles' in their name


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


-- Here, we are using the ILIKE operator to perform a case-insensitive search for films that contain the text 'INCREDIBLES' in their name.
-- ILIKE allows for case-insensitive pattern matching.
-- Case-insensitive means that it does not matter whether the letters are uppercase or lowercase; the search will match 'INCREDIBLES', 'incredibles', 'InCrEdIbLeS', etc.
-- Case-insensitive search is useful when you want to find matches regardless of the case of the letters in the text.
select *
from pixar.box_office
where film ilike '%INCREDIBLES%'; -- using ILIKE to find films that contains the text 'INCREDIBLES' in their name, case-insensitive

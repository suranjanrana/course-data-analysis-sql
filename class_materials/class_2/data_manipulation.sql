-- Here, we calculate the box office percentages and total box office
-- We also check if the total box office from US/Canada and other regions equals the worldwide
select
    *,
    cast(box_office_us_canada as float) / cast(box_office_worldwide as float) as box_office_us_canada_percentage,
    cast(box_office_other as float) / cast(box_office_worldwide as float) as box_office_other_percentage,
    box_office_us_canada + box_office_other as box_office_total, -- calculate total box office from US/Canada and other regions
    (box_office_us_canada + box_office_other)::float - box_office_worldwide::float as diff -- check if the total box office from US/Canada and other regions equals worldwide box office
from pixar.box_office;

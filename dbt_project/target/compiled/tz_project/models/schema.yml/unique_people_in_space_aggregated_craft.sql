
    
    

select
    craft as unique_field,
    count(*) as n_records

from `default_default`.`people_in_space_aggregated`
where craft is not null
group by craft
having count(*) > 1



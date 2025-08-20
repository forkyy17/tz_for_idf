
  
    
    
    
        
        insert into `default_default`.`people_in_space_aggregated`
        ("craft", "people_count")select 
craft, count() as people_count
from default.people
group by craft
order by people_count desc
  
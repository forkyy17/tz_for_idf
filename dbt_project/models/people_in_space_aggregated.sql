select 
craft, count() as people_count
from default.people
group by craft
order by people_count desc
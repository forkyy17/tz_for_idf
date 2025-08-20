
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select people_count
from `default_default`.`people_in_space_aggregated`
where people_count is null



    ) dbt_internal_test
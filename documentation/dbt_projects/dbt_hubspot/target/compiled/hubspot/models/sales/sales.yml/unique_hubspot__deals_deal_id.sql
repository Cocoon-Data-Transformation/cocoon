
    
    

select
    deal_id as unique_field,
    count(*) as n_records

from (select * from TEST.PUBLIC_hubspot.hubspot__deals where not coalesce(is_deal_deleted, false)) dbt_subquery
where deal_id is not null
group by deal_id
having count(*) > 1




    
    

select
    contact_id as unique_field,
    count(*) as n_records

from (select * from TEST.PUBLIC_hubspot.hubspot__contacts where not coalesce(is_contact_deleted, false)) dbt_subquery
where contact_id is not null
group by contact_id
having count(*) > 1



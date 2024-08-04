
    
    

select
    contact_list_id as unique_field,
    count(*) as n_records

from (select * from TEST.PUBLIC_hubspot.hubspot__contact_lists where not coalesce(is_contact_list_deleted, false)) dbt_subquery
where contact_list_id is not null
group by contact_list_id
having count(*) > 1



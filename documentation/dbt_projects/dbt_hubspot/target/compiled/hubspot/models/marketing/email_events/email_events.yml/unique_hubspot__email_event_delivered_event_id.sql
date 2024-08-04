
    
    

select
    event_id as unique_field,
    count(*) as n_records

from (select * from TEST.PUBLIC_hubspot.hubspot__email_event_delivered where not coalesce(is_contact_deleted, false)) dbt_subquery
where event_id is not null
group by event_id
having count(*) > 1




    
    

select
    contact_list_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_hubspot.int_hubspot__email_metrics__by_contact_list
where contact_list_id is not null
group by contact_list_id
having count(*) > 1



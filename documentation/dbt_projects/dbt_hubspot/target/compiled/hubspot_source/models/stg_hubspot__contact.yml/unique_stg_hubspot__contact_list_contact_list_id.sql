
    
    

select
    contact_list_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact_list
where contact_list_id is not null
group by contact_list_id
having count(*) > 1



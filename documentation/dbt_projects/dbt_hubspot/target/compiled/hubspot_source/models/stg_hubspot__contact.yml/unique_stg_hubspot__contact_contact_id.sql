
    
    

select
    contact_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact
where contact_id is not null
group by contact_id
having count(*) > 1



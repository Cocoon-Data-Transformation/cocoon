
    
    

select
    id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_hubspot.hubspot__contact_history
where id is not null
group by id
having count(*) > 1



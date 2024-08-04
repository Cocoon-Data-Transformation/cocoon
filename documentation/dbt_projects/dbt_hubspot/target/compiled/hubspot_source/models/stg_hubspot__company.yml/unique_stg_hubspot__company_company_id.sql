
    
    

select
    company_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__company
where company_id is not null
group by company_id
having count(*) > 1




    
    

select
    _fivetran_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__property
where _fivetran_id is not null
group by _fivetran_id
having count(*) > 1



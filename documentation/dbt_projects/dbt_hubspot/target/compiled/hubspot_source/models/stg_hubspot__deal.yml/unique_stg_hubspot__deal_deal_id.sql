
    
    

select
    deal_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal
where deal_id is not null
group by deal_id
having count(*) > 1




    
    

select
    company_id as unique_field,
    count(*) as n_records

from (select * from TEST.PUBLIC_hubspot.hubspot__companies where not coalesce(is_company_deleted, false)) dbt_subquery
where company_id is not null
group by company_id
having count(*) > 1



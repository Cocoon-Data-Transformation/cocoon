





with validation_errors as (

    select
        company_id, deal_id, type_id
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_company
    group by company_id, deal_id, type_id
    having count(*) > 1

)

select *
from validation_errors



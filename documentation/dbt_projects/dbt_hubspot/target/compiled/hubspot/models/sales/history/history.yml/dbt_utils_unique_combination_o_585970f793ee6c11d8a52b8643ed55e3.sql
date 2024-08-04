





with validation_errors as (

    select
        company_id, field_name, valid_to
    from TEST.PUBLIC_hubspot.hubspot__company_history
    group by company_id, field_name, valid_to
    having count(*) > 1

)

select *
from validation_errors



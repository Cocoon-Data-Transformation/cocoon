





with validation_errors as (

    select
        deal_id, field_name, valid_to
    from TEST.PUBLIC_hubspot.hubspot__deal_history
    group by deal_id, field_name, valid_to
    having count(*) > 1

)

select *
from validation_errors



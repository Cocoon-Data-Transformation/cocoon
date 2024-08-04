





with validation_errors as (

    select
        contact_id, field_name, valid_to
    from TEST.PUBLIC_hubspot.hubspot__contact_history
    group by contact_id, field_name, valid_to
    having count(*) > 1

)

select *
from validation_errors



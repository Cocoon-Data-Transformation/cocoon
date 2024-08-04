





with validation_errors as (

    select
        property_id, property_option_label
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__property_option
    group by property_id, property_option_label
    having count(*) > 1

)

select *
from validation_errors



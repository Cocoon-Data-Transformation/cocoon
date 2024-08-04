





with validation_errors as (

    select
        location_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__location
    group by location_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



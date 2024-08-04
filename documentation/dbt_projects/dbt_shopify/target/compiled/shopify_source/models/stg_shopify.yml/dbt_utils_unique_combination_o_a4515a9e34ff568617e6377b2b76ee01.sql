





with validation_errors as (

    select
        fulfillment_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__fulfillment
    group by fulfillment_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



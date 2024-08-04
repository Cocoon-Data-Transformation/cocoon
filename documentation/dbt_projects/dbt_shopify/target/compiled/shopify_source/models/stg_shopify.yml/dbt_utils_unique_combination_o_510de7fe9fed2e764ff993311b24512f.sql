





with validation_errors as (

    select
        checkout_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout
    group by checkout_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



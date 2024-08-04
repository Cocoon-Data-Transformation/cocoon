





with validation_errors as (

    select
        checkout_id, code, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout_discount_code
    group by checkout_id, code, source_relation
    having count(*) > 1

)

select *
from validation_errors



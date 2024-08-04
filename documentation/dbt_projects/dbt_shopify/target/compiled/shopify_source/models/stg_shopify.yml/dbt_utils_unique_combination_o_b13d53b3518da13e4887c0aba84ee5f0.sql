





with validation_errors as (

    select
        order_id, index, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_discount_code
    group by order_id, index, source_relation
    having count(*) > 1

)

select *
from validation_errors



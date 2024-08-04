





with validation_errors as (

    select
        shop_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__shop
    group by shop_id, source_relation
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        product_id, source_relation
    from TEST.PUBLIC_shopify.shopify__products
    group by product_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



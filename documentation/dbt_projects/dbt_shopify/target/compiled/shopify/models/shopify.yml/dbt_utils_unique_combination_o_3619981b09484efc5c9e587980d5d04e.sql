





with validation_errors as (

    select
        code, source_relation
    from TEST.PUBLIC_shopify.shopify__discounts
    group by code, source_relation
    having count(*) > 1

)

select *
from validation_errors



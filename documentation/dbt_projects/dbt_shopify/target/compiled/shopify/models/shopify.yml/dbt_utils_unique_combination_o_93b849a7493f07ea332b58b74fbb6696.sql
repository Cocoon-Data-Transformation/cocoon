





with validation_errors as (

    select
        customer_id, source_relation
    from TEST.PUBLIC_shopify.shopify__customers
    group by customer_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



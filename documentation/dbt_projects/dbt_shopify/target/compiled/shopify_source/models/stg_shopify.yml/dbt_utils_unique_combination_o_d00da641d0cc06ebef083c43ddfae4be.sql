





with validation_errors as (

    select
        customer_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__customer
    group by customer_id, source_relation
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        order_id, source_relation
    from TEST.PUBLIC_shopify.shopify__orders__order_line_aggregates
    group by order_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



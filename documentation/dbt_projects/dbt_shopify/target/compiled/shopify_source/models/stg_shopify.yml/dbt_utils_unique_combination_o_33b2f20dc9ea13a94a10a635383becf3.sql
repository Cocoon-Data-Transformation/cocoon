





with validation_errors as (

    select
        order_line_refund_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line_refund
    group by order_line_refund_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



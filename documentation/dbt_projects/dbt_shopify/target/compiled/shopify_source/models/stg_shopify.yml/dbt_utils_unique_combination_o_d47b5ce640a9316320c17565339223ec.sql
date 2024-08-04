





with validation_errors as (

    select
        order_line_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line
    group by order_line_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



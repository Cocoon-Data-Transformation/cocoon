





with validation_errors as (

    select
        order_id, key, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_url_tag
    group by order_id, key, source_relation
    having count(*) > 1

)

select *
from validation_errors



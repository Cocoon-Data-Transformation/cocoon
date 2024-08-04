





with validation_errors as (

    select
        refund_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__refund
    group by refund_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



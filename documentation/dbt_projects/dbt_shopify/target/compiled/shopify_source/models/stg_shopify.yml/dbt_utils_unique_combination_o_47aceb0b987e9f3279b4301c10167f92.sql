





with validation_errors as (

    select
        transaction_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__transaction
    group by transaction_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



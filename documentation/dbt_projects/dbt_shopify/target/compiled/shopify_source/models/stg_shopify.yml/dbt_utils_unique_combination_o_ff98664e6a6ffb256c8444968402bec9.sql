





with validation_errors as (

    select
        discount_code_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__discount_code
    group by discount_code_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



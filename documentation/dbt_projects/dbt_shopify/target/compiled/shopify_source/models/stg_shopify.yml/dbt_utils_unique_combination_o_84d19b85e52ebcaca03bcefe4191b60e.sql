





with validation_errors as (

    select
        variant_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_variant
    group by variant_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



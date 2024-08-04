





with validation_errors as (

    select
        collection_id, product_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__collection_product
    group by collection_id, product_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



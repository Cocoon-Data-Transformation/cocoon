





with validation_errors as (

    select
        collection_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__collection
    group by collection_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



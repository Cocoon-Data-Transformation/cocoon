





with validation_errors as (

    select
        inventory_item_id, location_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__inventory_level
    group by inventory_item_id, location_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



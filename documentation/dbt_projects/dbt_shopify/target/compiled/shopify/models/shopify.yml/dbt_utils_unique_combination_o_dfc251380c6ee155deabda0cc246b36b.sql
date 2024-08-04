





with validation_errors as (

    select
        inventory_item_id, location_id, source_relation
    from TEST.PUBLIC_shopify.shopify__inventory_levels
    group by inventory_item_id, location_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



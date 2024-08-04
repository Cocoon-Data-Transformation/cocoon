with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_variant_tmp

),

fields as (

    select
    
        
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as numeric(28,6)) as 
    
    product_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    inventory_item_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    image_id
    
 , 
    cast(null as TEXT) as 
    
    title
    
 , 
    cast(null as float) as 
    
    price
    
 , 
    cast(null as TEXT) as 
    
    sku
    
 , 
    cast(null as numeric(28,6)) as 
    
    position
    
 , 
    cast(null as TEXT) as 
    
    inventory_policy
    
 , 
    cast(null as float) as 
    
    compare_at_price
    
 , 
    cast(null as TEXT) as 
    
    fulfillment_service
    
 , 
    cast(null as TEXT) as 
    
    inventory_management
    
 , 
    cast(null as boolean) as 
    
    taxable
    
 , 
    cast(null as TEXT) as 
    
    barcode
    
 , 
    cast(null as float) as 
    
    grams
    
 , 
    cast(null as numeric(28,6)) as 
    
    old_inventory_quantity
    
 , 
    cast(null as numeric(28,6)) as 
    
    inventory_quantity
    
 , 
    cast(null as float) as 
    
    weight
    
 , 
    cast(null as TEXT) as 
    
    weight_unit
    
 , 
    cast(null as TEXT) as 
    
    option_1
    
 , 
    cast(null as TEXT) as 
    
    option_2
    
 , 
    cast(null as TEXT) as 
    
    option_3
    
 , 
    cast(null as TEXT) as 
    
    tax_code
    
 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (

    select
        id as variant_id,
        product_id,
        inventory_item_id,
        image_id,
        title,
        price,
        sku,
        position,
        inventory_policy,
        compare_at_price,
        fulfillment_service,
        inventory_management,
        taxable as is_taxable,
        barcode,
        grams,
        coalesce(inventory_quantity, old_inventory_quantity) as inventory_quantity,
        weight,
        weight_unit,
        option_1,
        option_2,
        option_3,
        tax_code,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

        





    from fields
)

select * 
from final
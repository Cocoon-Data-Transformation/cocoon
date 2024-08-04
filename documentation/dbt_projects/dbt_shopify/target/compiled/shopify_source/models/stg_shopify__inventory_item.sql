with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__inventory_item_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as float) as 
    
    cost
    
 , 
    cast(null as TEXT) as 
    
    country_code_of_origin
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    province_code_of_origin
    
 , 
    cast(null as boolean) as 
    
    requires_shipping
    
 , 
    cast(null as TEXT) as 
    
    sku
    
 , 
    cast(null as boolean) as 
    
    tracked
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as inventory_item_id,
        sku,
        _fivetran_deleted as is_deleted, -- won't filter out for now
        cost,
        country_code_of_origin,
        province_code_of_origin,
        requires_shipping as is_shipping_required,
        tracked as is_inventory_quantity_tracked,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
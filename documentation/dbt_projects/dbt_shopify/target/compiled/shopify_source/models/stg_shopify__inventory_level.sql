with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__inventory_level_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    available
    
 , 
    cast(null as integer) as 
    
    inventory_item_id
    
 , 
    cast(null as integer) as 
    
    location_id
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        inventory_item_id,
        location_id,
        available as available_quantity,
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
with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_image_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as integer) as 
    
    height
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    position
    
 , 
    cast(null as integer) as 
    
    product_id
    
 , 
    cast(null as TEXT) as 
    
    src
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    variant_ids
    
 , 
    cast(null as integer) as 
    
    width
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as product_image_id,
        product_id,
        height,
        position,
        src,
        variant_ids,
        width,
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
    where not coalesce(_fivetran_deleted, false)
)

select *
from final
with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_tmp

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
    cast(null as TEXT) as 
    
    handle
    
 , 
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    product_type
    
 , 
    cast(null as timestamp) as 
    
    published_at
    
 , 
    cast(null as TEXT) as 
    
    published_scope
    
 , 
    cast(null as TEXT) as 
    
    title
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    vendor
    
 , 
    cast(null as TEXT) as 
    
    status
    
 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (
    
    select
        id as product_id,
        handle,
        product_type,
        published_scope,
        title,
        vendor,
        status,
        _fivetran_deleted as is_deleted,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(published_at as timestamp) as timestamp)
) as published_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

        





from fields

)

select * 
from final
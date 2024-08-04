-- this model will be all NULL until you have made a refund in Shopify

with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__refund_tmp

),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    note
    
 , 
    cast(null as numeric(28,6)) as 
    
    order_id
    
 , 
    cast(null as timestamp) as 
    
    processed_at
    
 , 
    cast(null as boolean) as 
    
    restock
    
 , 
    cast(null as TEXT) as 
    
    total_duties_set
    
 , 
    cast(null as numeric(28,6)) as 
    
    user_id
    
 



        


, cast('' as TEXT) as source_relation



        
    from base
),

final as (

    select
        id as refund_id,
        note,
        order_id,
        restock,
        total_duties_set,
        user_id,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(processed_at as timestamp) as timestamp)
) as processed_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
)

select * 
from final
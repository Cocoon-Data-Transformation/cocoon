with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__collection_product_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    collection_id
    
 , 
    cast(null as integer) as 
    
    product_id
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        collection_id,
        product_id,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_url_tag_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    key
    
 , 
    cast(null as integer) as 
    
    order_id
    
 , 
    cast(null as TEXT) as 
    
    value
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        order_id,
        key,
        value,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
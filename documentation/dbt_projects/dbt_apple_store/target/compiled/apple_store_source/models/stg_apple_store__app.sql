with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    app_opt_in_rate
    
 , 
    cast(null as TEXT) as 
    
    asset_token
    
 , 
    cast(null as TEXT) as 
    
    icon_url
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    ios
    
 , 
    cast(null as boolean) as 
    
    is_bundle
    
 , 
    cast(null as boolean) as 
    
    is_enabled
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    pre_order_info
    
 , 
    cast(null as boolean) as 
    
    tvos
    
 


        
    from base
),

final as (
    
    select 
        id as app_id,
        name as app_name,
        is_enabled
    from fields
)

select * 
from final
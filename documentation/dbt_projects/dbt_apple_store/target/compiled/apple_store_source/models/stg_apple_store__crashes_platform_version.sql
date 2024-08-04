with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_platform_version_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as integer) as 
    
    crashes
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    device
    
 , 
    cast(null as boolean) as 
    
    meets_threshold
    
 , 
    cast(null as TEXT) as 
    
    platform_version
    
 


        
    from base
),

final as (
    
    select 
        cast(date as date) as date_day,
        app_id,
        device,
        platform_version,
        crashes
    from fields
)

select * 
from final
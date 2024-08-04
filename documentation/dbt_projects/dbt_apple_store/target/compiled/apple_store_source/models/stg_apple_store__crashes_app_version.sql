with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_app_version_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as TEXT) as 
    
    app_version
    
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
    
 


        
    from base
),

final as (
    
    select 
        cast(date as date) as date_day,
        app_id,
        device,
        app_version,
        crashes
    from fields
)

select * 
from final
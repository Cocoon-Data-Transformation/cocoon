with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_app_version_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    active_devices
    
 , 
    cast(null as integer) as 
    
    active_devices_last_30_days
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as TEXT) as 
    
    app_version
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    deletions
    
 , 
    cast(null as integer) as 
    
    installations
    
 , 
    cast(null as boolean) as 
    
    meets_threshold
    
 , 
    cast(null as integer) as 
    
    sessions
    
 , 
    cast(null as TEXT) as 
    
    source_type
    
 


        
    from base
),

final as (
    
    select 
        cast(date as date) as date_day,
        app_id,
        source_type,
        app_version,
        active_devices,
        active_devices_last_30_days,
        deletions,
        installations,
        sessions
    from fields
)

select * 
from final
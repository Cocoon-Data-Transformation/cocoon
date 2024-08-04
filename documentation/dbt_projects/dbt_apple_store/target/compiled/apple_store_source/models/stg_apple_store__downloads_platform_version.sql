with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_platform_version_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    first_time_downloads
    
 , 
    cast(null as boolean) as 
    
    meets_threshold
    
 , 
    cast(null as TEXT) as 
    
    platform_version
    
 , 
    cast(null as integer) as 
    
    redownloads
    
 , 
    cast(null as TEXT) as 
    
    source_type
    
 , 
    cast(null as integer) as 
    
    total_downloads
    
 


        
    from base
),

final as (
    
    select 
        cast(date as date) as date_day,
        app_id,
        source_type,
        platform_version,
        first_time_downloads,
        redownloads,
        total_downloads
    from fields
)

select * 
from final
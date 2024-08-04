with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_device_tmp
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
    cast(null as TEXT) as 
    
    device
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as integer) as 
    
    impressions_unique_device
    
 , 
    cast(null as boolean) as 
    
    meets_threshold
    
 , 
    cast(null as integer) as 
    
    page_views
    
 , 
    cast(null as integer) as 
    
    page_views_unique_device
    
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
        device,
        impressions,
        impressions_unique_device,
        page_views,
        page_views_unique_device
    from fields
)

select * 
from final
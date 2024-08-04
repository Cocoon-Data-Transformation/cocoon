

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_click_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    browser
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    ip_address
    
 , 
    cast(null as TEXT) as 
    
    location
    
 , 
    cast(null as TEXT) as 
    
    referer
    
 , 
    cast(null as TEXT) as 
    
    url
    
 , 
    cast(null as TEXT) as 
    
    user_agent
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        browser,
        id as event_id,
        ip_address,
        location as geo_location,
        referer as referer_url,
        url as click_url,
        user_agent
    from macro
    
)

select *
from fields
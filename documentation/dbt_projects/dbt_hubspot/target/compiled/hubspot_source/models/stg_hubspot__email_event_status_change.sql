

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_status_change_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    bounced
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    portal_subscription_status
    
 , 
    cast(null as TEXT) as 
    
    requested_by
    
 , 
    cast(null as TEXT) as 
    
    source
    
 , 
    cast(null as TEXT) as 
    
    subscriptions
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        bounced as is_bounced,
        id as event_id,
        portal_subscription_status as subscription_status,
        requested_by as requested_by_email,
        source as change_source,
        subscriptions
    from macro
    
)

select *
from fields
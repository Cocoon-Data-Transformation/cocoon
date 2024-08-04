

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as timestamp) as 
    
    caused_by_created
    
 , 
    cast(null as TEXT) as 
    
    caused_by_id
    
 , 
    cast(null as timestamp) as 
    
    created
    
 , 
    cast(null as integer) as 
    
    email_campaign_id
    
 , 
    cast(null as boolean) as 
    
    filtered_event
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    obsoleted_by_created
    
 , 
    cast(null as TEXT) as 
    
    obsoleted_by_id
    
 , 
    cast(null as integer) as 
    
    portal_id
    
 , 
    cast(null as TEXT) as 
    
    recipient
    
 , 
    cast(null as timestamp) as 
    
    sent_by_created
    
 , 
    cast(null as TEXT) as 
    
    sent_by_id
    
 , 
    cast(null as TEXT) as 
    
    type
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        app_id,
        cast(caused_by_created as timestamp) as caused_timestamp,
        caused_by_id as caused_by_event_id,
        cast(created as timestamp) as created_timestamp,
        email_campaign_id,
        filtered_event as is_filtered_event,
        id as event_id,
        cast(obsoleted_by_created as timestamp) as obsoleted_timestamp,
        obsoleted_by_id as obsoleted_by_event_id,
        portal_id,
        recipient as recipient_email_address,
        cast(sent_by_created as timestamp) as sent_timestamp,
        sent_by_id as sent_by_event_id,
        type as event_type
    from macro
    
)

select *
from fields

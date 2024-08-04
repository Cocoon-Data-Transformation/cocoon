

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_dropped_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    bcc
    
 , 
    cast(null as TEXT) as 
    
    cc
    
 , 
    cast(null as TEXT) as 
    
    drop_message
    
 , 
    cast(null as TEXT) as 
    
    drop_reason
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    reply_to
    
 , 
    cast(null as TEXT) as 
    
    subject
    
 , 
    cast(null as TEXT) as from_email 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        bcc as bcc_emails,
        cc as cc_emails,
        drop_message,
        drop_reason,
        from_email, -- source field name = from ; alias declared in macros/get_email_event_dropped_columns.sql
        id as event_id,
        reply_to as reply_to_email,
        subject as email_subject
    from macro
    
)

select *
from fields
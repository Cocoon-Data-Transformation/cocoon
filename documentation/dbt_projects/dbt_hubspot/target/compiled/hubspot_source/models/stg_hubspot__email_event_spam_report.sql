

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_spam_report_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    ip_address
    
 , 
    cast(null as TEXT) as 
    
    user_agent
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        id as event_id,
        ip_address,
        user_agent
    from macro
    
)

select *
from fields
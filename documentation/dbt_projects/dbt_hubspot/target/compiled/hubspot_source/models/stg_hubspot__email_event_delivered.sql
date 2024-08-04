

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_delivered_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    response
    
 , 
    cast(null as TEXT) as 
    
    smtp_id
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        id as event_id,
        response as returned_response,
        smtp_id
    from macro
    
)

select *
from fields
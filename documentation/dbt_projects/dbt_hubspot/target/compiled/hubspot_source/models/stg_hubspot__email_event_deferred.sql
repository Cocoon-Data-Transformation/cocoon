

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_deferred_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    attempt
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    response
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        attempt as attempt_number,
        id as event_id,
        response as returned_response
    from macro
    
)

select *
from fields
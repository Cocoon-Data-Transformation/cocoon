

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_bounce_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    category
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    response
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


    from base
    
), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        category as bounce_category,
        id as event_id,
        response as returned_response,
        status as returned_status
    from macro
    
)

select *
from fields
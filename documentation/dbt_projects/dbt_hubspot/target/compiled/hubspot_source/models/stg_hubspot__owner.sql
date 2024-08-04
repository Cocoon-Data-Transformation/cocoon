

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__owner_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    first_name
    
 , 
    cast(null as TEXT) as 
    
    last_name
    
 , 
    cast(null as integer) as 
    
    owner_id
    
 , 
    cast(null as integer) as 
    
    portal_id
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        cast(created_at as timestamp) as created_timestamp,
        email as email_address,
        first_name,
        last_name,
        owner_id,
        portal_id,
        type as owner_type,
        cast(updated_at as timestamp) as updated_timestamp,
        trim( first_name || ' ' || last_name ) as full_name
    from macro
    
)

select *
from fields
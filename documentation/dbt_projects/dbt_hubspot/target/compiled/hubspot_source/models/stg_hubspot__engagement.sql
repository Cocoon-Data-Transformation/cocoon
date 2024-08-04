

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as is_active , 
    cast(null as timestamp) as created_timestamp , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    owner_id
    
 , 
    cast(null as integer) as 
    
    portal_id
    
 , 
    cast(null as timestamp) as occurred_timestamp , 
    cast(null as TEXT) as engagement_type 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        id as engagement_id,
        created_timestamp,
        owner_id,
        occurred_timestamp,
        portal_id,
        engagement_type,
        is_active
    from macro
    
)

select *
from fields
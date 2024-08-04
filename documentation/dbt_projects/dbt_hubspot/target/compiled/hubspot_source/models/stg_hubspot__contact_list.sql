

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact_list_tmp

), macro as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as boolean) as 
    
    deleteable
    
 , 
    cast(null as boolean) as 
    
    dynamic
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    metadata_error
    
 , 
    cast(null as timestamp) as 
    
    metadata_last_processing_state_change_at
    
 , 
    cast(null as timestamp) as 
    
    metadata_last_size_change_at
    
 , 
    cast(null as TEXT) as 
    
    metadata_processing
    
 , 
    cast(null as integer) as 
    
    metadata_size
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    portal_id
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    from base

), fields as (

    select
        _fivetran_deleted as is_contact_list_deleted,
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        cast(created_at as timestamp) as created_timestamp,
        deleteable as is_deletable,
        dynamic as is_dynamic,
        id as contact_list_id,
        metadata_error,
        cast(metadata_last_processing_state_change_at as timestamp) as metadata_last_processing_state_change_at,
        cast(metadata_last_size_change_at as timestamp) as metadata_last_size_change_at,
        metadata_processing,
        metadata_size,
        name as contact_list_name,
        portal_id,
        cast(updated_at as timestamp) as updated_timestamp
    from macro
    
)

select *
from fields
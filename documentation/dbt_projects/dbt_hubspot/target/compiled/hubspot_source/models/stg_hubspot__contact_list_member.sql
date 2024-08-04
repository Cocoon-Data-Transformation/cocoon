

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__contact_list_member_tmp 

), macro as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    added_at
    
 , 
    cast(null as integer) as 
    
    contact_id
    
 , 
    cast(null as integer) as 
    
    contact_list_id
    
 


    from base

), fields as (

    select
        _fivetran_deleted as is_contact_list_member_deleted,
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        cast(added_at as timestamp) as added_timestamp,
        contact_id,
        contact_list_id
    from macro
    
)

select *
from fields
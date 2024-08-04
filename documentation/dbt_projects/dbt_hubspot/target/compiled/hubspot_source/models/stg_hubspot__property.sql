

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__property_tmp

), macro as (

    select
        
    cast(null as TEXT) as 
    
    _fivetran_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    calculated
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    description
    
 , 
    cast(null as TEXT) as 
    
    field_type
    
 , 
    cast(null as TEXT) as 
    
    group_name
    
 , 
    cast(null as boolean) as 
    
    hubspot_defined
    
 , 
    cast(null as TEXT) as 
    
    hubspot_object
    
 , 
    cast(null as TEXT) as 
    
    label
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as boolean) as 
    
    show_currency_symbol
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    from base

), fields as (

    select
        _fivetran_id,
        _fivetran_synced,
        calculated,
        created_at,
        description,
        field_type,
        group_name,
        hubspot_defined,
        hubspot_object,
        label as property_label,
        name as property_name,
        type as property_type,
        updated_at
    from macro
    
)

select *
from fields
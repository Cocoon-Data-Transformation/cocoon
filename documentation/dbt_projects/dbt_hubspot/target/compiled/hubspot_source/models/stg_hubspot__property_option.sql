

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__property_option_tmp

), macro as (

    select
        
    cast(null as TEXT) as 
    
    label
    
 , 
    cast(null as TEXT) as 
    
    property_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    display_order
    
 , 
    cast(null as boolean) as 
    
    hidden
    
 , 
    cast(null as TEXT) as 
    
    value
    
 


    from base

), fields as (

    select
        label as property_option_label,	
        property_id,
        _fivetran_synced,
        display_order,
        hidden,
        value as property_option_value
    from macro
    
)

select *
from fields
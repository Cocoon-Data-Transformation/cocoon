

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__company_property_history_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    company_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    source
    
 , 
    cast(null as TEXT) as 
    
    source_id
    
 , 
    cast(null as timestamp) as change_timestamp , 
    cast(null as TEXT) as 
    
    value
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        company_id,
        name as field_name,
        source as change_source,
        source_id as change_source_id,
        cast(change_timestamp as timestamp) as change_timestamp, -- source field name = timestamp ; alias declared in macros/get_company_property_history_columns.sql
        value as new_value
    from macro
    
)

select *
from fields
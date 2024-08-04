

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_pipeline_tmp

), macro as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    active
    
 , 
    cast(null as integer) as 
    
    display_order
    
 , 
    cast(null as TEXT) as 
    
    label
    
 , 
    cast(null as TEXT) as 
    
    pipeline_id
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    from base

), fields as (

    select
        _fivetran_deleted as is_deal_pipeline_deleted,
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        active as is_active,
        display_order,
        label as pipeline_label,
        cast(pipeline_id as TEXT) as deal_pipeline_id,
        created_at as deal_pipeline_created_at,
        updated_at as deal_pipeline_updated_at
    from macro
    
)

select *
from fields
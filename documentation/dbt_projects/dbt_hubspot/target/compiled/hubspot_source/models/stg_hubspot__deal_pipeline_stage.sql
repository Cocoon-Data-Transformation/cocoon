

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_pipeline_stage_tmp

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
    cast(null as boolean) as 
    
    closed_won
    
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
    cast(null as float) as 
    
    probability
    
 , 
    cast(null as TEXT) as 
    
    stage_id
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    from base

), fields as (

    select
        _fivetran_deleted as is_deal_pipeline_stage_deleted,
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        active as is_active,
        closed_won as is_closed_won,
        display_order,
        label as pipeline_stage_label,
        pipeline_id as deal_pipeline_id,
        probability,
        cast(stage_id as TEXT) as deal_pipeline_stage_id,
        created_at as deal_pipeline_stage_created_at,
        updated_at as deal_pipeline_stage_updated_at
    from macro
    
)

select *
from fields
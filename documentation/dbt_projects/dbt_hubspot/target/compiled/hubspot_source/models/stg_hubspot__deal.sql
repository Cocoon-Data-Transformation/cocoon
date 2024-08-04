

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    deal_id
    
 , 
    cast(null as TEXT) as 
    
    deal_pipeline_id
    
 , 
    cast(null as TEXT) as 
    
    deal_pipeline_stage_id
    
 , 
    cast(null as boolean) as is_deal_deleted , 
    cast(null as integer) as 
    
    owner_id
    
 , 
    cast(null as integer) as 
    
    portal_id
    
 , 
    cast(null as TEXT) as deal_name , 
    cast(null as TEXT) as description , 
    cast(null as integer) as amount , 
    cast(null as timestamp) as closed_date , 
    cast(null as timestamp) as created_date 


    from base

), fields as (

    select


        -- just default columns + explicitly configured passthrough columns
        -- a few columns below are aliased within the macros/get_deal_columns.sql macro
        deal_name,
        cast(closed_date as timestamp) as closed_date,
        cast(created_date as timestamp) as created_date,
        is_deal_deleted,
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        deal_id,
        cast(deal_pipeline_id as TEXT) as deal_pipeline_id,
        cast(deal_pipeline_stage_id as TEXT) as deal_pipeline_stage_id,
        owner_id,
        portal_id,
        description,
        amount

        --The below macro adds the fields defined within your hubspot__deal_pass_through_columns variable into the staging model
        





        -- The below macro add the ability to create calculated fields using the hubspot__deal_calculated_fields variable.
        



    from macro


), joined as (
    

select fields.*

from fields
)

select *
from joined
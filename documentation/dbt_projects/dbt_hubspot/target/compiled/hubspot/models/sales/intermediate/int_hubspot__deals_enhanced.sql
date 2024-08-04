

with deals as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal



), pipelines as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_pipeline

), pipeline_stages as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_pipeline_stage


), owners as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__owner


), deal_fields_joined as (

    select 
        deals.*,

        

        coalesce(pipelines.is_deal_pipeline_deleted, false) as is_deal_pipeline_deleted,
        pipelines.pipeline_label,
        pipelines.is_active as is_pipeline_active,
        coalesce(pipeline_stages.is_deal_pipeline_stage_deleted, false) as is_deal_pipeline_stage_deleted,
        pipelines.deal_pipeline_created_at,
        pipelines.deal_pipeline_updated_at,
        pipeline_stages.pipeline_stage_label

        
        , owners.email_address as owner_email_address
        , owners.full_name as owner_full_name
        

    from deals    
    left join pipelines 
        on deals.deal_pipeline_id = pipelines.deal_pipeline_id
    left join pipeline_stages 
        on deals.deal_pipeline_stage_id = pipeline_stages.deal_pipeline_stage_id

    
    left join owners 
        on deals.owner_id = owners.owner_id
    

    
)   

select *
from deal_fields_joined
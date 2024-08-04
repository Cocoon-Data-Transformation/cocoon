

with  __dbt__cte__int_hubspot__deals_enhanced as (


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
), deals_enhanced as (

    select *
    from __dbt__cte__int_hubspot__deals_enhanced



), engagements as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__engagements

), engagement_deals as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_deal

), engagement_deal_joined as (

    select
        engagements.engagement_type,
        engagement_deals.deal_id
    from engagements
    inner join engagement_deals
        on cast(engagements.engagement_id as bigint) = cast(engagement_deals.engagement_id as bigint )

), engagement_deal_agg as (

    

    select
        deal_id,
        count(case when engagement_type = 'NOTE' then deal_id end) as count_engagement_notes,
        count(case when engagement_type = 'TASK' then deal_id end) as count_engagement_tasks,
        count(case when engagement_type = 'CALL' then deal_id end) as count_engagement_calls,
        count(case when engagement_type = 'MEETING' then deal_id end) as count_engagement_meetings,
        count(case when engagement_type = 'EMAIL' then deal_id end) as count_engagement_emails,
        count(case when engagement_type = 'INCOMING_EMAIL' then deal_id end) as count_engagement_incoming_emails,
        count(case when engagement_type = 'FORWARDED_EMAIL' then deal_id end) as count_engagement_forwarded_emails
    from engagement_deal_joined
    group by 1



), engagements_joined as (

    select 
        deals_enhanced.*,
        
        coalesce(engagement_deal_agg.count_engagement_notes,0) as count_engagement_notes ,
        
        coalesce(engagement_deal_agg.count_engagement_tasks,0) as count_engagement_tasks ,
        
        coalesce(engagement_deal_agg.count_engagement_calls,0) as count_engagement_calls ,
        
        coalesce(engagement_deal_agg.count_engagement_meetings,0) as count_engagement_meetings ,
        
        coalesce(engagement_deal_agg.count_engagement_emails,0) as count_engagement_emails ,
        
        coalesce(engagement_deal_agg.count_engagement_incoming_emails,0) as count_engagement_incoming_emails ,
        
        coalesce(engagement_deal_agg.count_engagement_forwarded_emails,0) as count_engagement_forwarded_emails 
        
    from deals_enhanced
    left join engagement_deal_agg
        on cast(deals_enhanced.deal_id as bigint) = cast(engagement_deal_agg.deal_id as bigint )

)

select *
from engagements_joined


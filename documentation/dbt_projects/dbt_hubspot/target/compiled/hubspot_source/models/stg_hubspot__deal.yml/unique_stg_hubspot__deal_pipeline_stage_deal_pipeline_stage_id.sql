
    
    

select
    deal_pipeline_stage_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_pipeline_stage
where deal_pipeline_stage_id is not null
group by deal_pipeline_stage_id
having count(*) > 1



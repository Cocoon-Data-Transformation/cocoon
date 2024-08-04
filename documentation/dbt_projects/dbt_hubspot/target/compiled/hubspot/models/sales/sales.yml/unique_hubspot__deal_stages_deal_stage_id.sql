
    
    

select
    deal_stage_id as unique_field,
    count(*) as n_records

from (select * from TEST.PUBLIC_hubspot.hubspot__deal_stages where not coalesce(is_deal_pipeline_stage_deleted, false)) dbt_subquery
where deal_stage_id is not null
group by deal_stage_id
having count(*) > 1





with base as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_group_history_tmp

), macro as (

    select
        
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as boolean) as 
    
    backfilled
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    last_modified_time
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as timestamp) as 
    
    run_schedule_end
    
 , 
    cast(null as timestamp) as 
    
    run_schedule_start
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


    
        


, cast('' as TEXT) as source_relation




    from base

), fields as (

    select 
        source_relation,
        id as campaign_group_id,
        name as campaign_group_name,
        account_id,
        status,
        backfilled as is_backfilled,
        cast(run_schedule_start as timestamp) as run_schedule_start_at,
        cast(run_schedule_end as timestamp) as run_schedule_end_at,
        cast(last_modified_time as timestamp) as last_modified_at,
        cast(created_time as timestamp) as created_at,
        row_number() over (partition by source_relation, id order by last_modified_time desc) = 1 as is_latest_version

    from macro

)

select *
from fields
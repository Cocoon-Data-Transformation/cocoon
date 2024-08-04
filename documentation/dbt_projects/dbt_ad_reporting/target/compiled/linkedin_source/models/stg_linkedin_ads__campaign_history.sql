

with base as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_history_tmp

), macro as (

    select 
        
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as boolean) as 
    
    audience_expansion_enabled
    
 , 
    cast(null as integer) as 
    
    campaign_group_id
    
 , 
    cast(null as TEXT) as 
    
    cost_type
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as TEXT) as 
    
    creative_selection
    
 , 
    cast(null as float) as 
    
    daily_budget_amount
    
 , 
    cast(null as TEXT) as 
    
    daily_budget_currency_code
    
 , 
    cast(null as TEXT) as 
    
    format
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    last_modified_time
    
 , 
    cast(null as TEXT) as 
    
    locale_country
    
 , 
    cast(null as TEXT) as 
    
    locale_language
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    objective_type
    
 , 
    cast(null as boolean) as 
    
    offsite_delivery_enabled
    
 , 
    cast(null as TEXT) as 
    
    optimization_target_type
    
 , 
    cast(null as timestamp) as 
    
    run_schedule_end
    
 , 
    cast(null as timestamp) as 
    
    run_schedule_start
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as float) as 
    
    unit_cost_amount
    
 , 
    cast(null as TEXT) as 
    
    unit_cost_currency_code
    
 , 
    cast(null as TEXT) as 
    
    version_tag
    
 


    
        


, cast('' as TEXT) as source_relation




    from base

), fields as (

    select 
        source_relation,
        id as campaign_id,
        name as campaign_name,
        cast(version_tag as numeric) as version_tag,
        campaign_group_id,
        account_id,
        status,
        type,
        cost_type,
        creative_selection,
        daily_budget_amount,
        daily_budget_currency_code,
        unit_cost_amount,
        unit_cost_currency_code,
        format,
        locale_country,
        locale_language,
        objective_type,
        optimization_target_type,
        audience_expansion_enabled as is_audience_expansion_enabled,
        offsite_delivery_enabled as is_offsite_delivery_enabled,
        cast(run_schedule_start as timestamp) as run_schedule_start_at,
        cast(run_schedule_end as timestamp) as run_schedule_end_at,
        cast(last_modified_time as timestamp) as last_modified_at,
        cast(created_time as timestamp) as created_at,
        row_number() over (partition by source_relation, id order by last_modified_time desc) = 1 as is_latest_version

    from macro

)

select *
from fields
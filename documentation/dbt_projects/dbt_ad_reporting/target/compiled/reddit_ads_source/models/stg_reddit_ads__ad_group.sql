

with base as (

    select * 
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad_group_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    bid_strategy
    
 , 
    cast(null as integer) as 
    
    bid_value
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    configured_status
    
 , 
    cast(null as TEXT) as 
    
    effective_status
    
 , 
    cast(null as timestamp) as 
    
    end_time
    
 , 
    cast(null as boolean) as 
    
    expand_targeting
    
 , 
    cast(null as TEXT) as 
    
    goal_type
    
 , 
    cast(null as integer) as 
    
    goal_value
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    is_processing
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    optimization_strategy_type
    
 , 
    cast(null as timestamp) as 
    
    start_time
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        account_id,
        bid_strategy,
        bid_value,
        campaign_id,
        configured_status,
        effective_status,
        cast(end_time as timestamp) as end_time_at,
        expand_targeting,
        goal_type,
        goal_value,
        id as ad_group_id,
        is_processing,
        name as ad_group_name,
        optimization_strategy_type,
        cast(start_time as timestamp) as start_time_at
    from fields
)

select *
from final
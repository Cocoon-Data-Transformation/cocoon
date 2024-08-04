

with base as (

    select * 
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__ad_set_history_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    updated_time
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as timestamp) as 
    
    start_time
    
 , 
    cast(null as timestamp) as 
    
    end_time
    
 , 
    cast(null as TEXT) as 
    
    bid_strategy
    
 , 
    cast(null as integer) as 
    
    daily_budget
    
 , 
    cast(null as integer) as 
    
    budget_remaining
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        updated_time as updated_at,
        cast(id as bigint) as ad_set_id,
        name as ad_set_name,
        cast(account_id as bigint) as account_id,
        cast(campaign_id as bigint) as campaign_id,
        start_time as start_at,
        end_time as end_at,
        bid_strategy,
        daily_budget,
        budget_remaining,
        status,
        case when id is null and updated_time is null
            then row_number() over (partition by source_relation order by source_relation)
        else row_number() over (partition by source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
    from fields

)

select * 
from final
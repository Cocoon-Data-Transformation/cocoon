

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__campaign_history_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    bidding_strategy
    
 , 
    cast(null as timestamp) as 
    
    creation_date
    
 , 
    cast(null as date) as 
    
    end_date
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    last_updated_date
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    portfolio_id
    
 , 
    cast(null as integer) as 
    
    profile_id
    
 , 
    cast(null as TEXT) as 
    
    serving_status
    
 , 
    cast(null as date) as 
    
    start_date
    
 , 
    cast(null as TEXT) as 
    
    state
    
 , 
    cast(null as TEXT) as 
    
    targeting_type
    
 , 
    cast(null as float) as 
    
    budget
    
 , 
    cast(null as TEXT) as 
    
    budget_type
    
 , 
    cast(null as float) as 
    
    effective_budget
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as TEXT) as campaign_id,
        last_updated_date,
        bidding_strategy,
        creation_date,
        end_date,
        name as campaign_name,
        cast(portfolio_id as TEXT) as portfolio_id,
        cast(profile_id as TEXT) as profile_id,
        serving_status,
        start_date,
        state,
        targeting_type,
        budget,
        budget_type,
        effective_budget,
        row_number() over (partition by source_relation, id order by last_updated_date desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
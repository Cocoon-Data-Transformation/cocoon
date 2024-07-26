

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__portfolio_history_tmp
),

fields as (

    select
        
    cast(null as FLOAT) as 
    
    budget_amount
    
 , 
    cast(null as TEXT) as 
    
    budget_currency_code
    
 , 
    cast(null as date) as 
    
    budget_end_date
    
 , 
    cast(null as TEXT) as 
    
    budget_policy
    
 , 
    cast(null as date) as 
    
    budget_start_date
    
 , 
    cast(null as TIMESTAMP) as 
    
    creation_date
    
 , 
    cast(null as INT) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    in_budget
    
 , 
    cast(null as TIMESTAMP) as 
    
    last_updated_date
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as INT) as 
    
    profile_id
    
 , 
    cast(null as TEXT) as 
    
    serving_status
    
 , 
    cast(null as TEXT) as 
    
    state
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as TEXT) as portfolio_id,
        budget_amount,
        budget_currency_code,
        budget_end_date,
        budget_policy,
        budget_start_date,
        creation_date,
        in_budget,
        last_updated_date,
        name as portfolio_name,
        cast(profile_id as TEXT) as profile_id,
        serving_status,
        state,
        row_number() over (partition by source_relation, id order by last_updated_date desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
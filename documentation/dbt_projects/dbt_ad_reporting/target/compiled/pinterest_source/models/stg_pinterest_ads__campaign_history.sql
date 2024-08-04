

with base as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__campaign_history_tmp
), 

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as integer) as 
    
    default_ad_group_budget_in_micro_currency
    
 , 
    cast(null as boolean) as 
    
    is_automated_campaign
    
 , 
    cast(null as boolean) as 
    
    is_campaign_budget_optimization
    
 , 
    cast(null as boolean) as 
    
    is_flexible_daily_budgets
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    advertiser_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
), 

final as (

    select
        source_relation, 
        id as campaign_id,
        name as campaign_name,
        advertiser_id,
        default_ad_group_budget_in_micro_currency,
        is_automated_campaign,
        is_campaign_budget_optimization,
        is_flexible_daily_budgets,
        status as campaign_status,
        _fivetran_synced,
        created_time as created_at,
        row_number() over (partition by source_relation, id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
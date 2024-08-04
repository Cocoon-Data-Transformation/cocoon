

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__campaign_level_report_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    campaign_applicable_budget_rule_id
    
 , 
    cast(null as TEXT) as 
    
    campaign_applicable_budget_rule_name
    
 , 
    cast(null as TEXT) as 
    
    campaign_bidding_strategy
    
 , 
    cast(null as float) as 
    
    campaign_budget_amount
    
 , 
    cast(null as TEXT) as 
    
    campaign_budget_currency_code
    
 , 
    cast(null as TEXT) as 
    
    campaign_budget_type
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as float) as 
    
    campaign_rule_based_budget_amount
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as float) as 
    
    cost
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impressions
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        campaign_applicable_budget_rule_id,
        campaign_applicable_budget_rule_name,
        campaign_bidding_strategy,
        campaign_budget_amount,
        campaign_budget_currency_code,
        campaign_budget_type,
        cast(campaign_id as TEXT) as campaign_id,
        campaign_rule_based_budget_amount,
        clicks,
        cost,
        date as date_day,
        impressions

        




    from fields
)

select *
from final
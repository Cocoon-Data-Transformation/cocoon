

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__targeting_keyword_report_tmp
),

fields as (

    select
        
    cast(null as INT) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    ad_keyword_status
    
 , 
    cast(null as FLOAT) as 
    
    campaign_budget_amount
    
 , 
    cast(null as TEXT) as 
    
    campaign_budget_currency_code
    
 , 
    cast(null as TEXT) as 
    
    campaign_budget_type
    
 , 
    cast(null as INT) as 
    
    campaign_id
    
 , 
    cast(null as INT) as 
    
    clicks
    
 , 
    cast(null as FLOAT) as 
    
    cost
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as INT) as 
    
    impressions
    
 , 
    cast(null as FLOAT) as 
    
    keyword_bid
    
 , 
    cast(null as INT) as 
    
    keyword_id
    
 , 
    cast(null as TEXT) as 
    
    keyword_type
    
 , 
    cast(null as TEXT) as 
    
    match_type
    
 , 
    cast(null as TEXT) as 
    
    targeting
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(ad_group_id as TEXT) as ad_group_id,
        ad_keyword_status,
        campaign_budget_amount,
        campaign_budget_currency_code,
        campaign_budget_type,
        cast(campaign_id as TEXT) as campaign_id,
        clicks,
        cost,
        date as date_day,
        impressions,
        keyword_bid,
        cast(keyword_id as TEXT) as keyword_id,
        keyword_type,
        match_type,
        targeting

        




    from fields
)

select *
from final
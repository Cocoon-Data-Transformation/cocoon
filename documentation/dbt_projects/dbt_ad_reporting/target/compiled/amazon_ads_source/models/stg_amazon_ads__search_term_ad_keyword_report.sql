

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__search_term_ad_keyword_report_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    ad_keyword_status
    
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
    
 , 
    cast(null as float) as 
    
    keyword_bid
    
 , 
    cast(null as integer) as 
    
    keyword_id
    
 , 
    cast(null as TEXT) as 
    
    search_term
    
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
        search_term,
        targeting

        




    from fields
)

select *
from final
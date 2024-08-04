

with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__campaign_daily_report_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    ad_distribution
    
 , 
    cast(null as TEXT) as 
    
    bid_match_type
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as TEXT) as 
    
    currency_code
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    delivered_match_type
    
 , 
    cast(null as TEXT) as 
    
    device_os
    
 , 
    cast(null as TEXT) as 
    
    device_type
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as TEXT) as 
    
    network
    
 , 
    cast(null as float) as 
    
    spend
    
 , 
    cast(null as TEXT) as 
    
    top_vs_other
    
 , 
    cast(null as TEXT) as 
    
    budget_association_status
    
 , 
    cast(null as TEXT) as 
    
    budget_name
    
 , 
    cast(null as TEXT) as 
    
    budget_status
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        date as date_day,
        account_id,
        campaign_id,
        currency_code,
        device_os,
        device_type,
        network,
        ad_distribution,
        bid_match_type,
        delivered_match_type,
        top_vs_other,
        budget_association_status,
        budget_name,
        budget_status,
        clicks,
        impressions,
        spend

        




    from fields
)

select * 
from final
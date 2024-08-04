

with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_daily_report_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    ad_distribution
    
 , 
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as integer) as 
    
    ad_id
    
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
    
    language
    
 , 
    cast(null as TEXT) as 
    
    network
    
 , 
    cast(null as float) as 
    
    spend
    
 , 
    cast(null as TEXT) as 
    
    top_vs_other
    
 



    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        date as date_day,
        account_id,
        campaign_id,
        ad_group_id,
        ad_id,
        currency_code,
        device_os,
        device_type,
        network,
        language,
        ad_distribution,
        bid_match_type,
        delivered_match_type,
        top_vs_other,
        clicks,
        impressions,
        spend

        




    from fields
)

select * 
from final
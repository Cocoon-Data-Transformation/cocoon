

with base as (

    select * 
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__campaign_report_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as integer) as 
    
    billed_charge_local_micro
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as TEXT) as 
    
    placement
    
 , 
    cast(null as integer) as 
    
    url_clicks
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        date_trunc('day', date) as date_day,
        account_id,
        campaign_id,
        placement,
        clicks,
        impressions,
        billed_charge_local_micro as spend_micro,
        round(billed_charge_local_micro / 1000000.0,2) as spend,
        url_clicks

        




    
    from fields
)

select *
from final
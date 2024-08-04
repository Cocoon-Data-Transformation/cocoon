

with base as (

    select * 
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__campaign_report_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as TEXT) as 
    
    region
    
 , 
    cast(null as integer) as 
    
    spend
    
 , 
    cast(null as date) as date_day 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        account_id,
        campaign_id,
        clicks,
        date as date_day,
        impressions,
        region,
        (spend/1000000) as spend
        
        




    from fields
)

select *
from final
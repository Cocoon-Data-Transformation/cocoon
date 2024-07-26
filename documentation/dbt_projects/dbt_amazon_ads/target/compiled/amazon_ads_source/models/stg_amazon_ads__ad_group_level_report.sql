
with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__ad_group_level_report_tmp
),

fields as (

    select
        
    cast(null as INT) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    campaign_bidding_strategy
    
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
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(ad_group_id as TEXT) as ad_group_id,
        campaign_bidding_strategy,
        clicks,
        cost,
        date as date_day,
        impressions

        




    from fields
)

select *
from final
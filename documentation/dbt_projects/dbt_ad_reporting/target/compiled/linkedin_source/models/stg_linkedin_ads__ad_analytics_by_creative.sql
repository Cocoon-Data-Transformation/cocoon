

with base as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__ad_analytics_by_creative_tmp

), macro as (

    select
        
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as numeric(28,6)) as 
    
    cost_in_local_currency
    
 , 
    cast(null as numeric(28,6)) as 
    
    cost_in_usd
    
 , 
    cast(null as integer) as 
    
    creative_id
    
 , 
    cast(null as timestamp) as 
    
    day
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as numeric(28,6)) as 
    
    conversion_value_in_local_currency
    
 , 
    cast(null as TEXT) as 
    
    external_website_conversions
    
 , 
    cast(null as TEXT) as 
    
    one_click_leads
    
 


    
        


, cast('' as TEXT) as source_relation




    from base

), fields as (

    select
        source_relation,
        date_trunc('day', day) as date_day,
        creative_id,
        clicks, 
        impressions,
        
        cost_in_usd as cost,
        

        coalesce(cast(conversion_value_in_local_currency as float), 0) as conversion_value_in_local_currency

        
            , coalesce(cast(external_website_conversions as bigint), 0) as external_website_conversions
        
            , coalesce(cast(one_click_leads as bigint), 0) as one_click_leads
        

        





    from macro

)

select *
from fields
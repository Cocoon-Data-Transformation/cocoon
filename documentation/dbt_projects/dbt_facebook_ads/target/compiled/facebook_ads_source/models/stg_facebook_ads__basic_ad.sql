

with base as (

    select * 
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__basic_ad_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    ad_id
    
 , 
    cast(null as TEXT) as 
    
    ad_name
    
 , 
    cast(null as TEXT) as 
    
    adset_name
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as integer) as 
    
    inline_link_clicks
    
 , 
    cast(null as float) as 
    
    spend
    
 , 
    cast(null as integer) as 
    
    reach
    
 , 
    cast(null as float) as 
    
    frequency
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(ad_id as bigint) as ad_id,
        ad_name,
        adset_name as ad_set_name,
        date as date_day,
        cast(account_id as bigint) as account_id,
        impressions,
        coalesce(inline_link_clicks,0) as clicks,
        spend

        
                , reach
            
                , frequency
            

        




    from fields
)

select * 
from final
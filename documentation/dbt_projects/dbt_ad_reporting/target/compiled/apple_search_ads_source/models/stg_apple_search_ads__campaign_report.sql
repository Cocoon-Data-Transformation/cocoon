

with base as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__campaign_report_tmp
),

fields as (

    select
        
    cast(null as date) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as numeric(28,6)) as 
    
    local_spend_amount
    
 , 
    cast(null as TEXT) as 
    
    local_spend_currency
    
 , 
    cast(null as integer) as 
    
    new_downloads
    
 , 
    cast(null as integer) as 
    
    redownloads
    
 , 
    cast(null as integer) as 
    
    taps
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        date as date_day,
        id as campaign_id,
        impressions,
        local_spend_amount as spend,
        local_spend_currency as currency,
        new_downloads,
        redownloads,
        taps

        




    from fields
)

select * 
from final
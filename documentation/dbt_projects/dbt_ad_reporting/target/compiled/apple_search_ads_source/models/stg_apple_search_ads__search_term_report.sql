

with base as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__search_term_report_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    _fivetran_id
    
 , 
    cast(null as boolean) as 
    
    ad_group_deleted
    
 , 
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    ad_group_name
    
 , 
    cast(null as numeric(28,6)) as 
    
    bid_amount_amount
    
 , 
    cast(null as TEXT) as 
    
    bid_amount_currency
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as boolean) as 
    
    deleted
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as TEXT) as 
    
    keyword
    
 , 
    cast(null as TEXT) as 
    
    keyword_display_status
    
 , 
    cast(null as integer) as 
    
    keyword_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    local_spend_amount
    
 , 
    cast(null as TEXT) as 
    
    local_spend_currency
    
 , 
    cast(null as TEXT) as 
    
    match_type
    
 , 
    cast(null as integer) as 
    
    new_downloads
    
 , 
    cast(null as integer) as 
    
    redownloads
    
 , 
    cast(null as TEXT) as 
    
    search_term_source
    
 , 
    cast(null as TEXT) as 
    
    search_term_text
    
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
        _fivetran_id,
        campaign_id,
        ad_group_id,
        ad_group_name,
        bid_amount_amount as bid_amount,
        bid_amount_currency as bid_currency,
        keyword as keyword_text,
        keyword_display_status,
        keyword_id,
        local_spend_amount as spend,
        local_spend_currency as currency,
        match_type,
        search_term_source,
        search_term_text,
        impressions,
        taps,
        new_downloads,
        redownloads

        




    from fields
)

select * 
from final
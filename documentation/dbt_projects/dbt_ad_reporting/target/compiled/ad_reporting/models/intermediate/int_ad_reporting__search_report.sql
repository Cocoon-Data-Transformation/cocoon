
    





with 

microsoft_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'microsoft_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(keyword_id as TEXT) as keyword_id

    
    ,cast(keyword_name as TEXT) as keyword_text

    
    ,cast(match_type as TEXT) as search_match_type

    
    ,cast(search_query as TEXT) as search_query

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_microsoft_ads.microsoft_ads__search_report

), 



apple_search_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'apple_search_ads' as TEXT) as platform,

    cast(organization_id as TEXT) as account_id

    
    ,cast(organization_name as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(taps as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(keyword_id as TEXT) as keyword_id

    
    ,cast(keyword_text as TEXT) as keyword_text

    
    ,cast(match_type as TEXT) as search_match_type

    
    ,cast(search_term_text as TEXT) as search_query

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_apple_search_ads.apple_search_ads__search_term_report

), 



amazon_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'amazon_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(keyword_id as TEXT) as keyword_id

    
    ,cast(keyword_text as TEXT) as keyword_text

    
    ,cast(match_type as TEXT) as search_match_type

    
    ,cast(search_term as TEXT) as search_query

    
    ,cast(cost as float) as spend

    
from TEST.PUBLIC_amazon_ads.amazon_ads__search_report

), 


unioned as (

    


select * from amazon_ads

union all

select * from apple_search_ads

union all

select * from microsoft_ads




)

select *
from unioned
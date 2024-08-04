






with

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

    
    ,cast(match_type as TEXT) as keyword_match_type

    
    ,cast(keyword_text as TEXT) as keyword_text

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_apple_search_ads.apple_search_ads__keyword_report

),



google_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'google_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(criterion_id as TEXT) as keyword_id

    
    ,cast(keyword_match_type as TEXT) as keyword_match_type

    
    ,cast(keyword_text as TEXT) as keyword_text

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_google_ads.google_ads__keyword_report

),



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

    
    ,cast(match_type as TEXT) as keyword_match_type

    
    ,cast(keyword_name as TEXT) as keyword_text

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_microsoft_ads.microsoft_ads__keyword_report

),



pinterest_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'pinterest_ads' as TEXT) as platform,

    cast(advertiser_id as TEXT) as account_id

    
    ,cast(advertiser_name as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(keyword_id as TEXT) as keyword_id

    
    ,cast(match_type as TEXT) as keyword_match_type

    
    ,cast(keyword_value as TEXT) as keyword_text

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_pinterest.pinterest_ads__keyword_report

),



twitter_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'twitter_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(line_item_id as TEXT) as ad_group_id

    
    ,cast(line_item_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(keyword_id as TEXT) as keyword_id

    
    ,cast(null as TEXT) as keyword_match_type

    
    ,cast(keyword as TEXT) as keyword_text

    
    ,cast(spend as float) as spend

    
from TEST.PUBLIC_twitter_ads.twitter_ads__keyword_report

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

    
    ,cast(match_type as TEXT) as keyword_match_type

    
    ,cast(keyword_text as TEXT) as keyword_text

    
    ,cast(cost as float) as spend

    
from TEST.PUBLIC_amazon_ads.amazon_ads__keyword_report

), 


unioned as (

    


select * from amazon_ads

union all

select * from apple_search_ads

union all

select * from google_ads

union all

select * from microsoft_ads

union all

select * from pinterest_ads

union all

select * from twitter_ads




)

select *
from unioned
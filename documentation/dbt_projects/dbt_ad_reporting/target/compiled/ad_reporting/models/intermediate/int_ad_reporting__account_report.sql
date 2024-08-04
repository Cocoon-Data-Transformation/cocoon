


with


twitter_ads as (
    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'twitter_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_twitter_ads.twitter_ads__account_report

),



facebook_ads as (
    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'facebook_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_facebook_ads.facebook_ads__account_report

),



google_ads as (
    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'google_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_google_ads.google_ads__account_report

),



microsoft_ads as (
    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'microsoft_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_microsoft_ads.microsoft_ads__account_report

),




apple_search_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'apple_search_ads' as TEXT) as platform,

    cast(organization_id as TEXT) as account_id

    
    ,cast(organization_name as TEXT) as account_name

    
    ,cast(taps as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_apple_search_ads.apple_search_ads__organization_report

),



linkedin_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'linkedin_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(cost as float) as spend

    
from TEST.PUBLIC_linkedin_ads.linkedin_ads__account_report

),



pinterest_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'pinterest_ads' as TEXT) as platform,

    cast(advertiser_id as TEXT) as account_id

    
    ,cast(advertiser_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_pinterest.pinterest_ads__advertiser_report

),



snapchat_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'snapchat_ads' as TEXT) as platform,

    cast(ad_account_id as TEXT) as account_id

    
    ,cast(ad_account_name as TEXT) as account_name

    
    ,cast(swipes as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_snapchat_ads.snapchat_ads__account_report

), 



tiktok_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'tiktok_ads' as TEXT) as platform,

    cast(advertiser_id as TEXT) as account_id

    
    ,cast(advertiser_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_tiktok_ads.tiktok_ads__advertiser_report

), 



amazon_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'amazon_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(cost as float) as spend

    
from TEST.PUBLIC_amazon_ads.amazon_ads__account_report

), 



reddit_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'reddit_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(null as TEXT) as account_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_reddit_ads.reddit_ads__account_report

),


unioned as (

    


select * from amazon_ads

union all

select * from apple_search_ads

union all

select * from facebook_ads

union all

select * from google_ads

union all

select * from linkedin_ads

union all

select * from microsoft_ads

union all

select * from pinterest_ads

union all

select * from snapchat_ads

union all

select * from tiktok_ads

union all

select * from twitter_ads

union all

select * from reddit_ads




)

select *
from unioned
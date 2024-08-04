


with  __dbt__cte__int_ad_reporting__ad_group_report as (



with


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

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_google_ads.google_ads__ad_group_report

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

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_microsoft_ads.microsoft_ads__ad_group_report

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

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_apple_search_ads.apple_search_ads__ad_group_report

),



linkedin_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'linkedin_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(campaign_id as TEXT) as ad_group_id

    
    ,cast(campaign_name as TEXT) as ad_group_name

    
    ,cast(campaign_group_id as TEXT) as campaign_id

    
    ,cast(campaign_group_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(cost as float) as spend

    
from TEST.PUBLIC_linkedin_ads.linkedin_ads__campaign_report

),



facebook_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'facebook_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(account_name as TEXT) as account_name

    
    ,cast(ad_set_id as TEXT) as ad_group_id

    
    ,cast(ad_set_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_facebook_ads.facebook_ads__ad_set_report

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

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_pinterest.pinterest_ads__ad_group_report

),



snapchat_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'snapchat_ads' as TEXT) as platform,

    cast(ad_account_id as TEXT) as account_id

    
    ,cast(ad_account_name as TEXT) as account_name

    
    ,cast(ad_squad_id as TEXT) as ad_group_id

    
    ,cast(ad_squad_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(swipes as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_snapchat_ads.snapchat_ads__ad_squad_report

), 



tiktok_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'tiktok_ads' as TEXT) as platform,

    cast(advertiser_id as TEXT) as account_id

    
    ,cast(advertiser_name as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_tiktok_ads.tiktok_ads__ad_group_report

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

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_twitter_ads.twitter_ads__line_item_report

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

    ,cast(cost as float) as spend

    
from TEST.PUBLIC_amazon_ads.amazon_ads__ad_group_report

), 



reddit_ads as (

    select 
    source_relation,
    

    to_date(to_timestamp(date_day))

 as date_day,
    cast( 'reddit_ads' as TEXT) as platform,

    cast(account_id as TEXT) as account_id

    
    ,cast(null as TEXT) as account_name

    
    ,cast(ad_group_id as TEXT) as ad_group_id

    
    ,cast(ad_group_name as TEXT) as ad_group_name

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    
from TEST.PUBLIC_reddit_ads.reddit_ads__ad_group_report

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
), base as (

    select *
    from __dbt__cte__int_ad_reporting__ad_group_report
),

aggregated as (
    
    select
        source_relation,
        date_day,
        platform,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        ad_group_id,
        ad_group_name,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(spend) as spend 

        





    from base
    group by 1,2,3,4,5,6,7,8,9
)

select *
from aggregated
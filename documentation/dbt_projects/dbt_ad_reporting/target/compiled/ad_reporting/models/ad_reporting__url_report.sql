


with  __dbt__cte__int_ad_reporting__url_report as (



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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_google_ads.google_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_microsoft_ads.microsoft_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_facebook_ads.facebook_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_group_id as TEXT) as campaign_id

    
    ,cast(campaign_group_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(cost as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_linkedin_ads.linkedin_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_pinterest.pinterest_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(swipes as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_snapchat_ads.snapchat_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_tiktok_ads.tiktok_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_twitter_ads.twitter_ads__url_report

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

    
    ,cast(base_url as TEXT) as base_url

    
    ,cast(campaign_id as TEXT) as campaign_id

    
    ,cast(campaign_name as TEXT) as campaign_name

    
    ,cast(clicks as integer) as clicks

    ,cast(impressions as integer) as impressions

    ,cast(spend as float) as spend

    ,cast(url_host as TEXT) as url_host

    
    ,cast(url_path as TEXT) as url_path

    
    ,cast(utm_campaign as TEXT) as utm_campaign

    
    ,cast(utm_content as TEXT) as utm_content

    
    ,cast(utm_medium as TEXT) as utm_medium

    
    ,cast(utm_source as TEXT) as utm_source

    
    ,cast(utm_term as TEXT) as utm_term

    
    
from TEST.PUBLIC_reddit_ads.reddit_ads__url_report

),


unioned as (

    


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
    from __dbt__cte__int_ad_reporting__url_report
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
        base_url,
        url_host,
        url_path,
        utm_source,
        utm_medium,
        utm_campaign,
        utm_content,
        utm_term,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(spend) as spend 

        





    from base
    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
)

select *
from aggregated


with report as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__promoted_tweet_report
),

campaigns as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__campaign_history
    where is_latest_version
),

accounts as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__account_history
    where is_latest_version
),

line_items as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_history
    where is_latest_version
),

promoted_tweets as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__promoted_tweet_history
    where is_latest_version
),

tweets as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__tweet
),

tweet_url as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__tweet_url
    where index = 0
),

final as (

    select 
        report.source_relation,
        report.date_day,
        report.placement, 
        accounts.account_id,
        accounts.name as account_name,
        campaigns.campaign_id,
        campaigns.campaign_name,
        line_items.line_item_id,
        line_items.name as line_item_name,
        promoted_tweets.promoted_tweet_id,
        promoted_tweets.tweet_id,
        tweets.name as tweet_name,
        tweets.full_text as tweet_full_text,
        tweet_url.base_url,
        tweet_url.url_host,
        tweet_url.url_path,
        tweet_url.utm_source,
        tweet_url.utm_medium,
        tweet_url.utm_campaign,
        tweet_url.utm_content,
        tweet_url.utm_term,
        tweet_url.expanded_url,
        tweet_url.display_url,
        campaigns.currency,
        sum(report.clicks) as clicks, 
        sum(report.impressions) as impressions,
        sum(report.spend) as spend,
        sum(report.spend_micro) as spend_micro,
        sum(report.url_clicks) as url_clicks

        





    from report 
    left join promoted_tweets 
        on report.promoted_tweet_id = promoted_tweets.promoted_tweet_id
        and report.source_relation = promoted_tweets.source_relation
    left join tweet_url 
        on promoted_tweets.tweet_id = tweet_url.tweet_id
        and promoted_tweets.source_relation = tweet_url.source_relation
    left join tweets
        on promoted_tweets.tweet_id = tweets.tweet_id
        and promoted_tweets.source_relation = tweets.source_relation
    left join line_items
        on promoted_tweets.line_item_id = line_items.line_item_id
        and promoted_tweets.source_relation = line_items.source_relation
    left join campaigns 
        on line_items.campaign_id = campaigns.campaign_id
        and line_items.source_relation = campaigns.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation
    
    
        where tweet_url.expanded_url is not null
    

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24

    
)

select *
from final
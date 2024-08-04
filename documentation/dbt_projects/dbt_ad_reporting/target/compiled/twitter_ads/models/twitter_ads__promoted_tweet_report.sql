

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
        tweets.full_text,
        promoted_tweets.is_deleted,
        promoted_tweets.entity_status as promoted_tweet_status,
        campaigns.entity_status as campaign_status,
        line_items.entity_status as line_item_status,
        tweets.language,
        campaigns.currency,
        promoted_tweets.approval_status,
        promoted_tweets.created_timestamp,
        promoted_tweets.updated_timestamp,
        sum(report.clicks) as clicks, 
        sum(report.impressions) as impressions,
        sum(report.spend) as spend,
        sum(report.spend_micro) as spend_micro,
        sum(report.url_clicks) as url_clicks

        





    from report 
    left join promoted_tweets 
        on report.promoted_tweet_id = promoted_tweets.promoted_tweet_id
        and report.source_relation = promoted_tweets.source_relation
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

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
)

select *
from final


with accounts as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__account_history
    where is_latest_version
),

promoted_tweet_report as (
    
    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__promoted_tweet_report
),

rollup_report as (

    select 
        source_relation,
        date_day,
        account_id,
        placement,
        sum(clicks) as clicks, 
        sum(impressions) as impressions,
        sum(spend) as spend,
        sum(spend_micro) as spend_micro,
        sum(url_clicks) as url_clicks

        





    from promoted_tweet_report
    group by 1,2,3,4

),

final as (

    select 
        report.source_relation,
        report.date_day,
        report.placement, 
        report.account_id,
        accounts.name as account_name,
        accounts.is_deleted,
        accounts.timezone,
        accounts.industry_type,
        accounts.approval_status,
        accounts.business_name,
        accounts.business_id,
        accounts.created_timestamp,
        accounts.updated_timestamp,
        accounts.timezone_switched_timestamp,
        sum(report.clicks) as clicks, 
        sum(report.impressions) as impressions,
        sum(report.spend) as spend,
        sum(report.spend_micro) as spend_micro,
        sum(report.url_clicks) as url_clicks

        





    from rollup_report as report
    left join accounts 
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
)

select *
from final
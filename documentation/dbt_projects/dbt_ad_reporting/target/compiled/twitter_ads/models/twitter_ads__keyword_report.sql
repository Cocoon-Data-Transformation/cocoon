

with report as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_keywords_report
),

line_items as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_history
    where is_latest_version
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

final as (

    select 
        report.source_relation,
        report.date_day,
        report.placement, 
        report.account_id,
        accounts.name as account_name,
        line_items.campaign_id,
        campaigns.campaign_name,
        report.line_item_id,
        line_items.name as line_item_name,
        report.keyword_id,
        report.keyword,
        line_items.currency,
        sum(report.clicks) as clicks, 
        sum(report.impressions) as impressions,
        sum(report.spend) as spend,
        sum(report.spend_micro) as spend_micro,
        sum(report.url_clicks) as url_clicks

        





    from report 
    left join line_items
        on report.line_item_id = line_items.line_item_id
        and report.source_relation = line_items.source_relation
    left join campaigns 
        on line_items.campaign_id = campaigns.campaign_id
        and line_items.source_relation = campaigns.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation

    group by 1,2,3,4,5,6,7,8,9,10,11,12
)

select *
from final
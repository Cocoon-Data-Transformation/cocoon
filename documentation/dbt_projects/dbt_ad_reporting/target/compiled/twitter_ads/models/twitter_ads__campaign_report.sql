

with report as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__campaign_report
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
        report.campaign_id,
        campaigns.campaign_name,
        campaigns.is_deleted,
        campaigns.entity_status as campaign_status,
        campaigns.currency,
        campaigns.is_servable,
        campaigns.is_standard_delivery,
        campaigns.frequency_cap,
        campaigns.start_timestamp,
        campaigns.end_timestamp,
        campaigns.created_timestamp,
        campaigns.updated_timestamp,
        campaigns.funding_instrument_id,
        campaigns.daily_budget_amount,
        campaigns.total_budget_amount,
        sum(report.clicks) as clicks, 
        sum(report.impressions) as impressions,
        sum(report.spend) as spend,
        sum(report.spend_micro) as spend_micro,
        sum(report.url_clicks) as url_clicks

        





    from report 
    left join campaigns 
        on report.campaign_id = campaigns.campaign_id
        and report.source_relation = campaigns.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
)

select *
from final
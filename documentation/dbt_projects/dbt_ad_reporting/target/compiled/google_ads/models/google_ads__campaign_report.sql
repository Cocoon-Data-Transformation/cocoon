

with stats as (

    select *
    from TEST.PUBLIC_google_ads_source.stg_google_ads__campaign_stats
), 

accounts as (

    select *
    from TEST.PUBLIC_google_ads_source.stg_google_ads__account_history
    where is_most_recent_record = True
), 

campaigns as (

    select *
    from TEST.PUBLIC_google_ads_source.stg_google_ads__campaign_history
    where is_most_recent_record = True
), 

fields as (

    select
        stats.source_relation,
        stats.date_day,
        accounts.account_name,
        accounts.account_id,
        accounts.currency_code,
        campaigns.campaign_name,
        stats.campaign_id,
        campaigns.advertising_channel_type,
        campaigns.advertising_channel_subtype,
        campaigns.status,
        sum(stats.spend) as spend,
        sum(stats.clicks) as clicks,
        sum(stats.impressions) as impressions,
        sum(conversions) as conversions,
        sum(conversions_value) as conversions_value,
        sum(view_through_conversions) as view_through_conversions

        





    from stats
    left join campaigns
        on stats.campaign_id = campaigns.campaign_id
        and stats.source_relation = campaigns.source_relation
    left join accounts
        on campaigns.account_id = accounts.account_id
        and campaigns.source_relation = accounts.source_relation
    group by 1,2,3,4,5,6,7,8,9,10
)

select *
from fields


with report as (
    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__campaign_report
),

campaigns as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__campaign_history
    where is_most_recent_record = True
),

advertisers as (
    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_history
    where is_most_recent_record = True
),

fields as (

    select
        report.source_relation,
        report.date_day,
        advertisers.advertiser_name,
        advertisers.advertiser_id,
        campaigns.campaign_name,
        report.campaign_id,
        campaigns.campaign_status,
        sum(report.spend) as spend,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions

        





    from report
    left join campaigns
        on report.campaign_id = campaigns.campaign_id
        and report.source_relation = campaigns.source_relation
    left join advertisers
        on campaigns.advertiser_id = advertisers.advertiser_id
        and campaigns.source_relation = advertisers.source_relation
    group by 1,2,3,4,5,6,7
)

select *
from fields
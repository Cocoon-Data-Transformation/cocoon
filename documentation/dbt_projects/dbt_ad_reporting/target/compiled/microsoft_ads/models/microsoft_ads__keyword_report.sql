

with report as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__keyword_daily_report

), 

keywords as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__keyword_history
    where is_most_recent_record = True
),

ads as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_history
    where is_most_recent_record = True

), 

ad_groups as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_group_history
    where is_most_recent_record = True

), 

campaigns as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__campaign_history
    where is_most_recent_record = True

), 

accounts as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__account_history
    where is_most_recent_record = True

), 

joined as (

    select
        report.source_relation,
        report.date_day,
        accounts.account_name,
        report.account_id,
        campaigns.campaign_name,
        report.campaign_id,
        ad_groups.ad_group_name,
        report.ad_group_id,
        ads.ad_name,
        report.ad_id,
        keywords.keyword_name,
        report.keyword_id,
        keywords.match_type,
        report.device_os,
        report.device_type,
        report.network,
        report.currency_code,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        




    from report
    left join ads
        on report.ad_id = ads.ad_id
        and report.source_relation = ads.source_relation
    left join ad_groups
        on report.ad_group_id = ad_groups.ad_group_id
        and report.source_relation = ad_groups.source_relation
    left join campaigns
        on report.campaign_id = campaigns.campaign_id
        and report.source_relation = campaigns.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation
    left join keywords
        on report.keyword_id = keywords.keyword_id
        and report.source_relation = keywords.source_relation
    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
)

select *
from joined
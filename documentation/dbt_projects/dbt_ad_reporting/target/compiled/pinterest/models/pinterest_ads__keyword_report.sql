

with report as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__keyword_report
), 

advertisers as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_history
    where is_most_recent_record = True
),

campaigns as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__campaign_history
    where is_most_recent_record = True
), 

ad_groups as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__ad_group_history
    where is_most_recent_record = True
), 

keywords as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__keyword_history
    where is_most_recent_record = True
), 

fields as (

    select
        report.source_relation,
        report.date_day,
        advertisers.advertiser_name,
        advertisers.advertiser_id,
        campaigns.campaign_name,
        campaigns.campaign_id,
        ad_groups.ad_group_name,
        ad_groups.ad_group_id,
        report.keyword_id,
        keywords.match_type,
        keywords.parent_type,
        keywords.keyword_value,
        sum(report.spend) as spend,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions

        





    from report
    left join keywords
        on report.keyword_id = keywords.keyword_id
        and report.source_relation = keywords.source_relation
    left join ad_groups
        on keywords.ad_group_id = ad_groups.ad_group_id
        and keywords.source_relation = ad_groups.source_relation
    left join campaigns
        on ad_groups.campaign_id = campaigns.campaign_id
        and ad_groups.source_relation = campaigns.source_relation
    left join advertisers
        on campaigns.advertiser_id = advertisers.advertiser_id
        and campaigns.source_relation = advertisers.source_relation
    group by 1,2,3,4,5,6,7,8,9,10,11,12
)

select *
from fields
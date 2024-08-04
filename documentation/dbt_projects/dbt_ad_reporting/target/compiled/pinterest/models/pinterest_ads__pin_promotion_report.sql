

with report as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__pin_promotion_report
), 

pins as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__pin_promotion_history
    where is_most_recent_record = True
), 

ad_groups as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__ad_group_history
    where is_most_recent_record = True
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

joined as (

    select
        report.source_relation,
        report.date_day,
        campaigns.advertiser_id,
        advertisers.advertiser_name,
        report.campaign_id,
        campaigns.campaign_name,
        campaigns.campaign_status,
        report.ad_group_id,
        ad_groups.ad_group_name,
        ad_groups.ad_group_status,
        pins.creative_type,
        report.pin_promotion_id,
        pins.pin_name,
        pins.pin_status,
        pins.destination_url,
        pins.base_url,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        





    from report 
    left join pins 
        on report.pin_promotion_id = pins.pin_promotion_id
        and report.source_relation = pins.source_relation
    left join ad_groups
        on report.ad_group_id = ad_groups.ad_group_id
        and report.source_relation = ad_groups.source_relation
    left join campaigns 
        on report.campaign_id = campaigns.campaign_id
        and report.source_relation = campaigns.source_relation
    left join advertisers
        on campaigns.advertiser_id = advertisers.advertiser_id
        and campaigns.source_relation = advertisers.source_relation

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
)

select * 
from joined


with report as (

    select *
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__ad_group_report
), 

ad_group as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__ad_group_history
    where is_most_recent_record = True
), 

campaign as (

    select *
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__campaign_history
    where is_most_recent_record = True
), 

organization as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__organization
), 

joined as (

    select 
        report.source_relation,
        report.date_day,
        organization.organization_id,
        organization.organization_name,
        campaign.campaign_id, 
        campaign.campaign_name, 
        ad_group.ad_group_id,
        ad_group.ad_group_name,
        report.currency,
        ad_group.ad_group_status,
        ad_group.start_at, 
        ad_group.end_at,
        sum(report.taps) as taps,
        sum(report.new_downloads) as new_downloads,
        sum(report.redownloads) as redownloads,
        sum(report.new_downloads + report.redownloads) as total_downloads,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        




    from report
    join ad_group 
        on report.ad_group_id = ad_group.ad_group_id
        and report.source_relation = ad_group.source_relation
    join campaign 
        on ad_group.campaign_id = campaign.campaign_id
        and ad_group.source_relation = campaign.source_relation
    join organization 
        on ad_group.organization_id = organization.organization_id
        and ad_group.source_relation = organization.source_relation
    group by 1,2,3,4,5,6,7,8,9,10,11,12
)

select * 
from joined
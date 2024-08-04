

with campaign_group as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_group_history
    where is_latest_version
),

campaign as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_history
    where is_latest_version
),

account as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__account_history
    where is_latest_version
),

report as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__ad_analytics_by_campaign
),

final as (

    select 
        report.source_relation,
        report.date_day,
        campaign_group.campaign_group_id,
        campaign_group.campaign_group_name,
        account.account_id,
        account.account_name,
        campaign_group.status,
        account.currency,
        campaign_group.is_backfilled,
        campaign_group.run_schedule_start_at,
        campaign_group.run_schedule_end_at,
        campaign_group.last_modified_at,
        campaign_group.created_at,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.cost) as cost

        




    
    from report 
    left join campaign 
        on report.campaign_id = campaign.campaign_id
        and report.source_relation = campaign.source_relation
    left join campaign_group
        on campaign.campaign_group_id = campaign_group.campaign_group_id
        and campaign.source_relation = campaign_group.source_relation
    left join account 
        on campaign.account_id = account.account_id
        and campaign.source_relation = account.source_relation

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13

)

select *
from final
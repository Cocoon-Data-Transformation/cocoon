

with campaign as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_history
    where is_latest_version
),

campaign_group as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_group_history
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
        report.campaign_id,
        campaign.campaign_name,
        campaign.version_tag,
        campaign_group.campaign_group_id,
        campaign_group.campaign_group_name,
        account.account_id,
        account.account_name,
        campaign.status as campaign_status,
        campaign_group.status as campaign_group_status,
        campaign.type,
        campaign.cost_type,
        campaign.creative_selection,
        campaign.daily_budget_amount,
        campaign.daily_budget_currency_code,
        campaign.unit_cost_amount,
        campaign.unit_cost_currency_code,
        account.currency,
        campaign.format,
        campaign.locale_country,
        campaign.locale_language,
        campaign.objective_type,
        campaign.optimization_target_type,
        campaign.is_audience_expansion_enabled,
        campaign.is_offsite_delivery_enabled,
        campaign.run_schedule_start_at,
        campaign.run_schedule_end_at,
        campaign.last_modified_at,
        campaign.created_at,
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

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30

)

select *
from final
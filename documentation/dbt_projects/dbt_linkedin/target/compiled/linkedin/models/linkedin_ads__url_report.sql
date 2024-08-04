

with creative as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__creative_history
    where is_latest_version
),

campaign as (

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
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__ad_analytics_by_creative
),

final as (

    select 
        report.source_relation,
        report.date_day,
        creative.click_uri,
        creative.base_url,
        creative.url_host,
        creative.url_path,
        creative.utm_source,
        creative.utm_medium,
        creative.utm_campaign,
        creative.utm_content,
        creative.utm_term,
        report.creative_id,
        campaign.campaign_id,
        campaign.campaign_name,
        campaign_group.campaign_group_id,
        campaign_group.campaign_group_name,
        account.account_id,
        account.account_name,
        account.currency,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.cost) as cost

        




    
    from report 
    left join creative 
        on report.creative_id = creative.creative_id
        and report.source_relation = creative.source_relation
    left join campaign 
        on creative.campaign_id = campaign.campaign_id
        and creative.source_relation = campaign.source_relation
    left join campaign_group
        on campaign.campaign_group_id = campaign_group.campaign_group_id
        and campaign.source_relation = campaign_group.source_relation
    left join account 
        on campaign.account_id = account.account_id
        and campaign.source_relation = account.source_relation

    
        where creative.click_uri is not null
    

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19

)

select *
from final
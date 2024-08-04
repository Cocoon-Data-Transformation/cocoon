

with account as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__account_history
    where is_latest_version
),

campaign as (

    select *
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_history
    where is_latest_version
),

report as (

    select *,
        
            external_website_conversions + one_click_leads as total_conversions
        
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__ad_analytics_by_campaign
),

final as (

    select 
        report.source_relation,
        report.date_day,
        account.account_id,
        account.account_name,
        account.version_tag,
        account.currency,
        account.status,
        account.type,
        account.last_modified_at,
        account.created_at,
        sum(report.total_conversions) as total_conversions,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.cost) as cost,
        sum(coalesce(report.conversion_value_in_local_currency, 0)) as conversion_value_in_local_currency

        



    



    



    
        
        , sum(coalesce(external_website_conversions, 0)) as external_website_conversions
        
    
        
        , sum(coalesce(one_click_leads, 0)) as one_click_leads
        
    




        






    from report 
    left join campaign 
        on report.campaign_id = campaign.campaign_id
        and report.source_relation = campaign.source_relation
    left join account 
        on campaign.account_id = account.account_id
        and campaign.source_relation = account.source_relation

    group by 1,2,3,4,5,6,7,8,9,10

)

select *
from final


with report as (

    select *
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__basic_ad

), 

creatives as (

    select *
    from TEST.PUBLIC_facebook_ads.int_facebook_ads__creative_history

), 

accounts as (

    select *
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__account_history
    where is_most_recent_record = true

), 

ads as (

    select *
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__ad_history
    where is_most_recent_record = true

), 

ad_sets as (

    select *
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__ad_set_history
    where is_most_recent_record = true

), 

campaigns as (

    select *
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__campaign_history
    where is_most_recent_record = true

), 

joined as (

    select
        report.source_relation,
        report.date_day,
        accounts.account_id,
        accounts.account_name,
        campaigns.campaign_id,
        campaigns.campaign_name,
        ad_sets.ad_set_id,
        ad_sets.ad_set_name,
        ads.ad_id,
        ads.ad_name,
        creatives.creative_id,
        creatives.creative_name,
        creatives.base_url,
        creatives.url_host,
        creatives.url_path,
        creatives.utm_source,
        creatives.utm_medium,
        creatives.utm_campaign,
        creatives.utm_content,
        creatives.utm_term,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        




    from report
    left join ads 
        on report.ad_id = ads.ad_id
        and report.source_relation = ads.source_relation
    left join creatives
        on ads.creative_id = creatives.creative_id
        and ads.source_relation = creatives.source_relation
    left join ad_sets
        on ads.ad_set_id = ad_sets.ad_set_id
        and ads.source_relation = ad_sets.source_relation
    left join campaigns
        on ads.campaign_id = campaigns.campaign_id
        and ads.source_relation = campaigns.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation  

    
        where creatives.url is not null
    
    
    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
)

select *
from joined
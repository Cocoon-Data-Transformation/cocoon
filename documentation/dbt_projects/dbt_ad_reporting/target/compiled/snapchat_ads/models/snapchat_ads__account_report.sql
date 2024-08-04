

with ad_hourly as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_hourly_report

), account as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_account_history
    where is_most_recent_record = true

), ads as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_history
    where is_most_recent_record = true

), ad_squads as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_squad_history
    where is_most_recent_record = true

), campaigns as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__campaign_history
    where is_most_recent_record = true


), aggregated as (

    select
        ad_hourly.source_relation,
        cast(ad_hourly.date_hour as date) as date_day,
        account.ad_account_id,
        account.ad_account_name,
        account.currency,
        sum(ad_hourly.swipes) as swipes,
        sum(ad_hourly.impressions) as impressions,
        round(sum(ad_hourly.spend),2) as spend

        




    
    from ad_hourly
    left join ads 
        on ad_hourly.ad_id = ads.ad_id
        and ad_hourly.source_relation = ads.source_relation
    left join ad_squads
        on ads.ad_squad_id = ad_squads.ad_squad_id
        and ads.source_relation = ad_squads.source_relation
    left join campaigns
        on ad_squads.campaign_id = campaigns.campaign_id
        and ad_squads.source_relation = campaigns.source_relation
    left join account
        on campaigns.ad_account_id = account.ad_account_id
        and campaigns.source_relation = account.source_relation

    group by 1,2,3,4,5

)

select *
from aggregated


with report as (
    select *
    --use campaign report since account report not provided
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__campaign_level_report
), 

account_info as (
    select *
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__profile
    where _fivetran_deleted = False
),

campaigns as (
    select *
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__campaign_history
    where is_most_recent_record = True
),

fields as (
    select
        report.source_relation,
        report.date_day,
        account_info.account_name,
        account_info.account_id,
        account_info.country_code,
        account_info.profile_id,
        sum(report.cost) as cost,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions 

        --use campaign report since portfolio report not provided
        





    from report

    left join campaigns
        on campaigns.campaign_id = report.campaign_id
        and campaigns.source_relation = report.source_relation
    left join account_info
        on account_info.profile_id = campaigns.profile_id
        and account_info.source_relation = campaigns.source_relation
    

    group by 1,2,3,4,5,6
)

select *
from fields
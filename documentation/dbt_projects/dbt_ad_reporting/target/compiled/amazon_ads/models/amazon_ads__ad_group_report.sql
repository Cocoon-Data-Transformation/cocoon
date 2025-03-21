

with report as (
    select *
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__ad_group_level_report
), 

account_info as (
    select *
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__profile
    where _fivetran_deleted = False
),

portfolios as (
    select *
    from TEST.PUBLIC_amazon_ads.int_amazon_ads__portfolio_history
), 

campaigns as (
    select *
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__campaign_history
    where is_most_recent_record = True
),

ad_groups as (
    select *
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__ad_group_history
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
        portfolios.portfolio_name,
        portfolios.portfolio_id,
        campaigns.campaign_name,
        campaigns.campaign_id,
        ad_groups.ad_group_name,
        report.ad_group_id,
        ad_groups.serving_status,
        ad_groups.state,
        ad_groups.default_bid,
        report.campaign_bidding_strategy,
        sum(report.cost) as cost,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions 

        





    from report

    left join ad_groups
        on ad_groups.ad_group_id = report.ad_group_id
        and ad_groups.source_relation = report.source_relation
    left join campaigns
        on campaigns.campaign_id = ad_groups.campaign_id
        and campaigns.source_relation = ad_groups.source_relation
    left join portfolios
        on portfolios.portfolio_id = campaigns.portfolio_id
        and portfolios.source_relation = campaigns.source_relation
    left join account_info
        on account_info.profile_id = campaigns.profile_id
        and account_info.source_relation = campaigns.source_relation

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
)

select *
from fields
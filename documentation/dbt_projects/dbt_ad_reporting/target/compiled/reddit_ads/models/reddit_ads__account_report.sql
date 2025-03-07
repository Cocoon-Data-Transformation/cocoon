

with report as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__account_report
), 

accounts as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__account
)

, joined as (

    select
        report.source_relation,
        report.date_day,
        report.account_id,
        accounts.currency,
        accounts.attribution_type,
        accounts.status,
        accounts.time_zone_id,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        





    from report
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation
    group by 1,2,3,4,5,6,7
)

select *
from joined
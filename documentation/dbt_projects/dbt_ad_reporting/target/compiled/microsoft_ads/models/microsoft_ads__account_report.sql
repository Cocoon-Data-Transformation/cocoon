

with report as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__account_daily_report

), 

accounts as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__account_history
    where is_most_recent_record = True
)

, joined as (

    select
        report.source_relation,
        report.date_day,
        accounts.account_name,
        report.account_id,
        accounts.time_zone as account_timezone,
        report.device_os,
        report.device_type,
        report.network,
        report.currency_code,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        




    from report
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation
    group by 1,2,3,4,5,6,7,8,9
)

select *
from joined


with report as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_report
), 

advertisers as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_history
    where is_most_recent_record = True
), 

fields as (

    select
        report.source_relation,
        report.date_day,
        advertisers.advertiser_name,
        report.advertiser_id,
        advertisers.currency_code,
        advertisers.country,
        sum(report.spend) as spend,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions

        





    from report
    left join advertisers
        on report.advertiser_id = advertisers.advertiser_id
        and report.source_relation = advertisers.source_relation
    group by 1,2,3,4,5,6
)

select *
from fields
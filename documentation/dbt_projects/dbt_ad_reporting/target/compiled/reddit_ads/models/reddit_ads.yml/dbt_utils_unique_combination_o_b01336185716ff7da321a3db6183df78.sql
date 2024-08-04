





with validation_errors as (

    select
        source_relation, date_day, account_id, attribution_type, currency, status, time_zone_id
    from TEST.PUBLIC_reddit_ads.reddit_ads__account_report
    group by source_relation, date_day, account_id, attribution_type, currency, status, time_zone_id
    having count(*) > 1

)

select *
from validation_errors



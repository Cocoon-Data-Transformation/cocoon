





with validation_errors as (

    select
        source_relation, date_day, account_id, campaign_id, currency
    from TEST.PUBLIC_reddit_ads.reddit_ads__campaign_report
    group by source_relation, date_day, account_id, campaign_id, currency
    having count(*) > 1

)

select *
from validation_errors



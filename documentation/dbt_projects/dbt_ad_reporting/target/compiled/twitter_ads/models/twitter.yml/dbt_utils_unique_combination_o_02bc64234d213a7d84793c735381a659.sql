





with validation_errors as (

    select
        source_relation, date_day, campaign_id, placement, account_id
    from TEST.PUBLIC_twitter_ads.twitter_ads__campaign_report
    group by source_relation, date_day, campaign_id, placement, account_id
    having count(*) > 1

)

select *
from validation_errors



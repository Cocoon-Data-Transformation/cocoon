





with validation_errors as (

    select
        source_relation, date_day, account_id, placement
    from TEST.PUBLIC_twitter_ads.twitter_ads__account_report
    group by source_relation, date_day, account_id, placement
    having count(*) > 1

)

select *
from validation_errors



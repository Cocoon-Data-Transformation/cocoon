





with validation_errors as (

    select
        source_relation, date_day, keyword_id, campaign_id
    from TEST.PUBLIC_twitter_ads.twitter_ads__keyword_report
    group by source_relation, date_day, keyword_id, campaign_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, promoted_tweet_id, placement
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__promoted_tweet_report
    group by source_relation, date_day, promoted_tweet_id, placement
    having count(*) > 1

)

select *
from validation_errors



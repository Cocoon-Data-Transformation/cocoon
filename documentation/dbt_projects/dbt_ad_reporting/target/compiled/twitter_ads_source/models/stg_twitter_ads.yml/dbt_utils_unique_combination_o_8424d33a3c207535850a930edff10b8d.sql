





with validation_errors as (

    select
        source_relation, tweet_id
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__tweet
    group by source_relation, tweet_id
    having count(*) > 1

)

select *
from validation_errors



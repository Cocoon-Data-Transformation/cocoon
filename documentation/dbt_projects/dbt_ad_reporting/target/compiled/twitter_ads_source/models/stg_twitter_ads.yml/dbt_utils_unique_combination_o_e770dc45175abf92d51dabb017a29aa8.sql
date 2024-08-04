





with validation_errors as (

    select
        source_relation, index, tweet_id
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__tweet_url
    group by source_relation, index, tweet_id
    having count(*) > 1

)

select *
from validation_errors



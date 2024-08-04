





with validation_errors as (

    select
        source_relation, campaign_id
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__campaign
    group by source_relation, campaign_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, campaign_id, placement
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__campaign_report
    group by source_relation, date_day, campaign_id, placement
    having count(*) > 1

)

select *
from validation_errors



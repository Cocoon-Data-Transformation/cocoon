





with validation_errors as (

    select
        source_relation, campaign_id, date_day
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__campaign_report
    group by source_relation, campaign_id, date_day
    having count(*) > 1

)

select *
from validation_errors



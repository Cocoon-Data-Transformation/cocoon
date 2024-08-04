





with validation_errors as (

    select
        source_relation, date_day, creative_id
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__ad_analytics_by_creative
    group by source_relation, date_day, creative_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, keyword_id, date_day
    from TEST.PUBLIC_google_ads_source.stg_google_ads__keyword_stats
    group by source_relation, keyword_id, date_day
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, ad_id, date_day
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad_report
    group by source_relation, ad_id, date_day
    having count(*) > 1

)

select *
from validation_errors



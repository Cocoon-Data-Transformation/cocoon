





with validation_errors as (

    select
        source_relation, date_day, keyword_id
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_keywords_report
    group by source_relation, date_day, keyword_id
    having count(*) > 1

)

select *
from validation_errors



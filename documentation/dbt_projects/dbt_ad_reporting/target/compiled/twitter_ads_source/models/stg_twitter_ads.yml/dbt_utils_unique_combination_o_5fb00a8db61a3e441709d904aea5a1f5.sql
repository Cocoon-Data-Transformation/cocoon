





with validation_errors as (

    select
        source_relation, date_day, line_item_id, placement
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_report
    group by source_relation, date_day, line_item_id, placement
    having count(*) > 1

)

select *
from validation_errors



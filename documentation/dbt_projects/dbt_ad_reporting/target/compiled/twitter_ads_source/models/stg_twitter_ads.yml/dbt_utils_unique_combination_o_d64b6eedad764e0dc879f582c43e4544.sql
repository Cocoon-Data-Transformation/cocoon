





with validation_errors as (

    select
        source_relation, line_item_id, updated_timestamp
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_history
    group by source_relation, line_item_id, updated_timestamp
    having count(*) > 1

)

select *
from validation_errors



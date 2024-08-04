





with validation_errors as (

    select
        source_relation, date_day, line_item_id, placement, campaign_id, account_id
    from TEST.PUBLIC_twitter_ads.twitter_ads__line_item_report
    group by source_relation, date_day, line_item_id, placement, campaign_id, account_id
    having count(*) > 1

)

select *
from validation_errors



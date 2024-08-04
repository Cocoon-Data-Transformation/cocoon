





with validation_errors as (

    select
        source_relation, campaign_id, date_day
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__campaign_level_report
    group by source_relation, campaign_id, date_day
    having count(*) > 1

)

select *
from validation_errors



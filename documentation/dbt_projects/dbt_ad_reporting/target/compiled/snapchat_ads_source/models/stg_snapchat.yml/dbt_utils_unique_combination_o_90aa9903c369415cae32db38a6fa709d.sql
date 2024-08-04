





with validation_errors as (

    select
        source_relation, campaign_id, date_hour
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__campaign_hourly_report
    group by source_relation, campaign_id, date_hour
    having count(*) > 1

)

select *
from validation_errors



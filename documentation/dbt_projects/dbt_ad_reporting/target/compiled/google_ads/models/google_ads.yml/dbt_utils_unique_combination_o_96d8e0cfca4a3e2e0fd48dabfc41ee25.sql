





with validation_errors as (

    select
        source_relation, campaign_id, advertising_channel_type, advertising_channel_subtype, date_day
    from TEST.PUBLIC_google_ads.google_ads__campaign_report
    group by source_relation, campaign_id, advertising_channel_type, advertising_channel_subtype, date_day
    having count(*) > 1

)

select *
from validation_errors



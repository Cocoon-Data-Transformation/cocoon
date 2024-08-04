





with validation_errors as (

    select
        source_relation, campaign_id, advertiser_id, date_day
    from TEST.PUBLIC_tiktok_ads.tiktok_ads__campaign_report
    group by source_relation, campaign_id, advertiser_id, date_day
    having count(*) > 1

)

select *
from validation_errors



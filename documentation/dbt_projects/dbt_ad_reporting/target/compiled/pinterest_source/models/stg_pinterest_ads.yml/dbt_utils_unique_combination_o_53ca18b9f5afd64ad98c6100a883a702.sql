





with validation_errors as (

    select
        source_relation, date_day, campaign_id, advertiser_id
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__campaign_report
    group by source_relation, date_day, campaign_id, advertiser_id
    having count(*) > 1

)

select *
from validation_errors



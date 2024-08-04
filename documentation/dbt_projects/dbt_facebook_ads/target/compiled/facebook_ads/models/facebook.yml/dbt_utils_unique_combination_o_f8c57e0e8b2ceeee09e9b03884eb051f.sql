





with validation_errors as (

    select
        source_relation, date_day, account_id, campaign_id
    from TEST.PUBLIC_facebook_ads.facebook_ads__campaign_report
    group by source_relation, date_day, account_id, campaign_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, date_day, creative_id, campaign_id, campaign_group_id, account_id
    from TEST.PUBLIC_linkedin_ads.linkedin_ads__creative_report
    group by source_relation, date_day, creative_id, campaign_id, campaign_group_id, account_id
    having count(*) > 1

)

select *
from validation_errors



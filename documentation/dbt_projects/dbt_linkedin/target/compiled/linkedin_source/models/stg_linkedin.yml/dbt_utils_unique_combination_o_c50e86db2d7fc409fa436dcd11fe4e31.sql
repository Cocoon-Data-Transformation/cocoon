





with validation_errors as (

    select
        source_relation, last_modified_at, campaign_group_id
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_group_history
    group by source_relation, last_modified_at, campaign_group_id
    having count(*) > 1

)

select *
from validation_errors



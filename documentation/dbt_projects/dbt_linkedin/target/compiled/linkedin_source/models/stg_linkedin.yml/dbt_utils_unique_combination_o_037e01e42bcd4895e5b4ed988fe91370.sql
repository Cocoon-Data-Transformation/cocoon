





with validation_errors as (

    select
        source_relation, version_tag, campaign_id
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__campaign_history
    group by source_relation, version_tag, campaign_id
    having count(*) > 1

)

select *
from validation_errors



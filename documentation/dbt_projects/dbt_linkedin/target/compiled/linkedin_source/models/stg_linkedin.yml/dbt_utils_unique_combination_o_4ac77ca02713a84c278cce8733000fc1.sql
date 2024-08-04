





with validation_errors as (

    select
        source_relation, account_id, version_tag
    from TEST.PUBLIC_linkedin_ads_source.stg_linkedin_ads__account_history
    group by source_relation, account_id, version_tag
    having count(*) > 1

)

select *
from validation_errors



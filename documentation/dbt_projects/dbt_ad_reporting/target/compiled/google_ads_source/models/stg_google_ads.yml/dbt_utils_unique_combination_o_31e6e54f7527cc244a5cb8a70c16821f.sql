





with validation_errors as (

    select
        source_relation, account_id, updated_at
    from TEST.PUBLIC_google_ads_source.stg_google_ads__account_history
    group by source_relation, account_id, updated_at
    having count(*) > 1

)

select *
from validation_errors



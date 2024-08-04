





with validation_errors as (

    select
        source_relation, account_id, _fivetran_synced
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__account_history
    group by source_relation, account_id, _fivetran_synced
    having count(*) > 1

)

select *
from validation_errors



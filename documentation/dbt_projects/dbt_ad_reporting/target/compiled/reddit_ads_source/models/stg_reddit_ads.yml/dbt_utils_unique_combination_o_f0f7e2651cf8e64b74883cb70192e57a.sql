





with validation_errors as (

    select
        source_relation, account_id
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__account
    group by source_relation, account_id
    having count(*) > 1

)

select *
from validation_errors



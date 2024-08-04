





with validation_errors as (

    select
        source_relation, updated_at, advertiser_id
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_history
    group by source_relation, updated_at, advertiser_id
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        source_relation, campaign_id, updated_at
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__campaign_history
    group by source_relation, campaign_id, updated_at
    having count(*) > 1

)

select *
from validation_errors



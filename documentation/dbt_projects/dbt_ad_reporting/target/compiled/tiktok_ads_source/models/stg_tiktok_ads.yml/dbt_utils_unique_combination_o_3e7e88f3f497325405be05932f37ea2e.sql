





with validation_errors as (

    select
        source_relation, advertiser_id
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__advertiser
    group by source_relation, advertiser_id
    having count(*) > 1

)

select *
from validation_errors



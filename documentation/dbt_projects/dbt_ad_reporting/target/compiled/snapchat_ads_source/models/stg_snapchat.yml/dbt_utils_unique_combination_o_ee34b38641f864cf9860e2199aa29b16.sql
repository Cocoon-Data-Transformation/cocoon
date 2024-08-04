





with validation_errors as (

    select
        source_relation, creative_id, param_key, updated_at
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__creative_url_tag_history
    group by source_relation, creative_id, param_key, updated_at
    having count(*) > 1

)

select *
from validation_errors



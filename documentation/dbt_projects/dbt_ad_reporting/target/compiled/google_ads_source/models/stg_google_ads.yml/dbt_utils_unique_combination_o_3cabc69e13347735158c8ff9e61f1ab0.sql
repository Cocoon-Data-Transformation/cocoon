





with validation_errors as (

    select
        source_relation, criterion_id, ad_group_id, updated_at
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_group_criterion_history
    group by source_relation, criterion_id, ad_group_id, updated_at
    having count(*) > 1

)

select *
from validation_errors



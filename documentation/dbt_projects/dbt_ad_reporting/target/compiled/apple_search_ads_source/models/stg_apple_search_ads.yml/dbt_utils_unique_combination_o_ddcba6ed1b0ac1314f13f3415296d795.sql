





with validation_errors as (

    select
        source_relation, ad_id, modified_at
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__ad_history
    group by source_relation, ad_id, modified_at
    having count(*) > 1

)

select *
from validation_errors



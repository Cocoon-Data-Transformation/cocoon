





with validation_errors as (

    select
        source_relation, organization_id
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__organization
    group by source_relation, organization_id
    having count(*) > 1

)

select *
from validation_errors



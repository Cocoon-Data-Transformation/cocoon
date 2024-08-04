





with validation_errors as (

    select
        source_relation, ad_id, date_day, ad_group_id
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__ad_report
    group by source_relation, ad_id, date_day, ad_group_id
    having count(*) > 1

)

select *
from validation_errors



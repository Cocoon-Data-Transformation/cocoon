





with validation_errors as (

    select
        source_relation, _fivetran_id, date_day
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__search_term_report
    group by source_relation, _fivetran_id, date_day
    having count(*) > 1

)

select *
from validation_errors



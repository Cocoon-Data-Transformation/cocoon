





with validation_errors as (

    select
        source_relation, ad_id, ad_group_id, date_day
    from TEST.PUBLIC_google_ads.google_ads__ad_report
    group by source_relation, ad_id, ad_group_id, date_day
    having count(*) > 1

)

select *
from validation_errors



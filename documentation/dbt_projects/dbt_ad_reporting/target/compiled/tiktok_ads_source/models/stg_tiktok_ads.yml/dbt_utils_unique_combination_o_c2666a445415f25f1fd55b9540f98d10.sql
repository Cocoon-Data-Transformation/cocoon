





with validation_errors as (

    select
        source_relation, ad_group_id, stat_time_hour
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__ad_group_report_hourly
    group by source_relation, ad_group_id, stat_time_hour
    having count(*) > 1

)

select *
from validation_errors



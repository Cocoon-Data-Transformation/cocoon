





with validation_errors as (

    select
        date_day, app_id, source_type, platform_version
    from TEST.PUBLIC_apple_store.apple_store__platform_version_report
    group by date_day, app_id, source_type, platform_version
    having count(*) > 1

)

select *
from validation_errors



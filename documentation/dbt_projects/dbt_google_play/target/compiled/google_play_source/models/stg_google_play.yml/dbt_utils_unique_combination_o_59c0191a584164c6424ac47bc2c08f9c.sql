





with validation_errors as (

    select
        package_name, date_day, app_version_code
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_crashes_app_version
    group by package_name, date_day, app_version_code
    having count(*) > 1

)

select *
from validation_errors



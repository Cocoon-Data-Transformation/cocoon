





with validation_errors as (

    select
        package_name, date_day, android_os_version
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_crashes_os_version
    group by package_name, date_day, android_os_version
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        package_name, date_day, android_os_version
    from TEST.PUBLIC_google_play.google_play__os_version_report
    group by package_name, date_day, android_os_version
    having count(*) > 1

)

select *
from validation_errors



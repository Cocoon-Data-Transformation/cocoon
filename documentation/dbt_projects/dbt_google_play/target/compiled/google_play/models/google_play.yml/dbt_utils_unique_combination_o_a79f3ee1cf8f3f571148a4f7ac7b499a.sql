





with validation_errors as (

    select
        package_name, date_day, app_version_code
    from TEST.PUBLIC_google_play.google_play__app_version_report
    group by package_name, date_day, app_version_code
    having count(*) > 1

)

select *
from validation_errors



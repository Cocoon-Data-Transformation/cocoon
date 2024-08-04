





with validation_errors as (

    select
        package_name, date_day, device
    from TEST.PUBLIC_google_play.google_play__device_report
    group by package_name, date_day, device
    having count(*) > 1

)

select *
from validation_errors



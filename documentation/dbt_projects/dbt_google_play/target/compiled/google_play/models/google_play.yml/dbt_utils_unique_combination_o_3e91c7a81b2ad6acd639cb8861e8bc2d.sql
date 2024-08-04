





with validation_errors as (

    select
        package_name, date_day
    from TEST.PUBLIC_google_play.google_play__overview_report
    group by package_name, date_day
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        package_name, date_day
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_crashes_overview
    group by package_name, date_day
    having count(*) > 1

)

select *
from validation_errors



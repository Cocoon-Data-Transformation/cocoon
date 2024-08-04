





with validation_errors as (

    select
        package_name, date_day, device
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_ratings_device
    group by package_name, date_day, device
    having count(*) > 1

)

select *
from validation_errors



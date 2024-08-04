





with validation_errors as (

    select
        package_name, date_day, country
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_ratings_country
    group by package_name, date_day, country
    having count(*) > 1

)

select *
from validation_errors



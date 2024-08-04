





with validation_errors as (

    select
        package_name, date_day, country_region
    from TEST.PUBLIC_google_play_source.stg_google_play__store_performance_country
    group by package_name, date_day, country_region
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        package_name, date_day, country_short
    from TEST.PUBLIC_google_play.google_play__country_report
    group by package_name, date_day, country_short
    having count(*) > 1

)

select *
from validation_errors









with validation_errors as (

    select
        date_day, app_id
    from TEST.PUBLIC_apple_store.apple_store__overview_report
    group by date_day, app_id
    having count(*) > 1

)

select *
from validation_errors



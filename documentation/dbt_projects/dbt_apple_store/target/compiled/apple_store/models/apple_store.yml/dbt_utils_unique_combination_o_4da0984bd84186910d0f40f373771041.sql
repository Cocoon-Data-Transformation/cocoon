





with validation_errors as (

    select
        date_day, app_id, source_type
    from TEST.PUBLIC_apple_store.apple_store__source_type_report
    group by date_day, app_id, source_type
    having count(*) > 1

)

select *
from validation_errors



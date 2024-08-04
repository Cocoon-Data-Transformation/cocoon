





with validation_errors as (

    select
        date_day, app_id, source_type, territory_long
    from TEST.PUBLIC_apple_store.apple_store__territory_report
    group by date_day, app_id, source_type, territory_long
    having count(*) > 1

)

select *
from validation_errors



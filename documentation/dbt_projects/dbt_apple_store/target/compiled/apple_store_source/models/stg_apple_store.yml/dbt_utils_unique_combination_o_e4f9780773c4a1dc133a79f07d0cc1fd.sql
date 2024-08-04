





with validation_errors as (

    select
        date_day, app_id, source_type, device
    from TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_device
    group by date_day, app_id, source_type, device
    having count(*) > 1

)

select *
from validation_errors



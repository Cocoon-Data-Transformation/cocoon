





with validation_errors as (

    select
        date_day, app_id, source_type, territory
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_territory
    group by date_day, app_id, source_type, territory
    having count(*) > 1

)

select *
from validation_errors



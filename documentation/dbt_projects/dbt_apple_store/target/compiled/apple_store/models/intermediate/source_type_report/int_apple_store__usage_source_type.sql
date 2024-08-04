with base as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_device
),

aggregated as (

    select 
        date_day,
        app_id,
        source_type,
        sum(active_devices) as active_devices,
        sum(deletions) as deletions,
        sum(installations) as installations,
        sum(sessions) as sessions
    from base
    group by 1,2,3
)

select * 
from aggregated
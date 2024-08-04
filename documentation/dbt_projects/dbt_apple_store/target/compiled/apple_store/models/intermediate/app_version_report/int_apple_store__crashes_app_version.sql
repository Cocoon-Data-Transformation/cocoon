with base as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_app_version
),

aggregated as (

    select 
        date_day, 
        app_id,
        app_version,
        cast(null as TEXT) as source_type,
        sum(crashes) as crashes
    from base
    group by 1,2,3,4
)

select * 
from aggregated
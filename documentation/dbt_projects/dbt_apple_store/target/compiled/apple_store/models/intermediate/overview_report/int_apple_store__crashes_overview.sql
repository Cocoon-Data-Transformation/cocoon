with base as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_app_version
),

aggregated as (

    select 
        date_day, 
        app_id,
        sum(crashes) as crashes
    from base
    group by 1,2
)

select * 
from aggregated
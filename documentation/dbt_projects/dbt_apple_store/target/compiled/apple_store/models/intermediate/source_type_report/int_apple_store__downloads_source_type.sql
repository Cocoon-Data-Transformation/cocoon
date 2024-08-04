with base as (
    
    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_device
),

aggregated as (

    select 
        date_day,
        app_id,
        source_type,
        sum(first_time_downloads) as first_time_downloads,
        sum(redownloads) as redownloads,
        sum(total_downloads) as total_downloads
    from base 
    group by 1,2,3
)

select * 
from aggregated
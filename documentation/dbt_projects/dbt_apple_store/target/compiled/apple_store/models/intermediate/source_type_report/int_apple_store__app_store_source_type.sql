with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_device
),

aggregated as (

    select 
        date_day,
        app_id,
        source_type,
        sum(impressions) as impressions,
        sum(page_views) as page_views
    from base 
    group by 1,2,3
)

select * 
from aggregated
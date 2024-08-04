with  __dbt__cte__int_apple_store__app_store_overview as (
with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_device
),

aggregated as (

    select 
        date_day,
        app_id,
        sum(impressions) as impressions,
        sum(page_views) as page_views
    from base 
    group by 1,2
)

select * 
from aggregated
),  __dbt__cte__int_apple_store__crashes_overview as (
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
),  __dbt__cte__int_apple_store__downloads_overview as (
with base as (
    
    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_device
),

aggregated as (

    select 
        date_day,
        app_id,
        sum(first_time_downloads) as first_time_downloads,
        sum(redownloads) as redownloads,
        sum(total_downloads) as total_downloads
    from base 
    group by 1,2
)

select * 
from aggregated
),  __dbt__cte__int_apple_store__usage_overview as (
with base as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_device
),

aggregated as (

    select 
        date_day,
        app_id,
        sum(active_devices) as active_devices,
        sum(deletions) as deletions,
        sum(installations) as installations,
        sum(sessions) as sessions
    from base
    group by 1,2
)

select * 
from aggregated
), app as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app
),

app_store as (

    select *
    from __dbt__cte__int_apple_store__app_store_overview
),

crashes as (

    select *
    from __dbt__cte__int_apple_store__crashes_overview
),

downloads as (

    select *
    from __dbt__cte__int_apple_store__downloads_overview
),



usage as (

    select *
    from __dbt__cte__int_apple_store__usage_overview
),

reporting_grain as (

    select distinct
        date_day,
        app_id 
    from app_store
), 

joined as (

    select 
        reporting_grain.date_day,
        reporting_grain.app_id,
        app.app_name,
        coalesce(app_store.impressions, 0) as impressions,
        coalesce(app_store.page_views, 0) as page_views,
        coalesce(crashes.crashes,0) as crashes,
        coalesce(downloads.first_time_downloads, 0) as first_time_downloads,
        coalesce(downloads.redownloads, 0) as redownloads,
        coalesce(downloads.total_downloads, 0) as total_downloads,
        coalesce(usage.active_devices, 0) as active_devices,
        coalesce(usage.deletions, 0) as deletions,
        coalesce(usage.installations, 0) as installations,
        coalesce(usage.sessions, 0) as sessions
        
    from reporting_grain
    left join app 
        on reporting_grain.app_id = app.app_id
    left join app_store 
        on reporting_grain.date_day = app_store.date_day
        and reporting_grain.app_id = app_store.app_id
    left join crashes
        on reporting_grain.date_day = crashes.date_day
        and reporting_grain.app_id = crashes.app_id
    left join downloads
        on reporting_grain.date_day = downloads.date_day
        and reporting_grain.app_id = downloads.app_id
    
    left join usage
        on reporting_grain.date_day = usage.date_day
        and reporting_grain.app_id = usage.app_id        
)

select * 
from joined
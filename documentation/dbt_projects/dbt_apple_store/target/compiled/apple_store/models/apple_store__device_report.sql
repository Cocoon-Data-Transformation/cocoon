with  __dbt__cte__int_apple_store__crashes_device as (
with base as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_app_version
),

aggregated as (

    select 
        date_day, 
        app_id,
        device,
        cast(null as TEXT) as source_type,
        sum(crashes) as crashes
    from base
    group by 1,2,3,4
)

select * 
from aggregated
), app as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app
),

app_store_device as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_device
),

downloads_device as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_device
),

usage_device as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_device
),

crashes_device as (

    select *
    from __dbt__cte__int_apple_store__crashes_device
),



reporting_grain_combined as (

    select
        date_day,
        app_id,
        source_type,
        device 
    from app_store_device
    union all
    select
        date_day,
        app_id,
        source_type,
        device
    from crashes_device
),

reporting_grain as (
    
    select
        distinct *
    from reporting_grain_combined
),

joined as (

    select 
        reporting_grain.date_day,
        reporting_grain.app_id, 
        app.app_name,
        reporting_grain.source_type,
        reporting_grain.device,
        coalesce(app_store_device.impressions, 0) as impressions,
        coalesce(app_store_device.impressions_unique_device, 0) as impressions_unique_device,
        coalesce(app_store_device.page_views, 0) as page_views,
        coalesce(app_store_device.page_views_unique_device, 0) as page_views_unique_device,
        coalesce(crashes_device.crashes, 0) as crashes,
        coalesce(downloads_device.first_time_downloads, 0) as first_time_downloads,
        coalesce(downloads_device.redownloads, 0) as redownloads,
        coalesce(downloads_device.total_downloads, 0) as total_downloads,
        coalesce(usage_device.active_devices, 0) as active_devices,
        coalesce(usage_device.active_devices_last_30_days, 0) as active_devices_last_30_days,
        coalesce(usage_device.deletions, 0) as deletions,
        coalesce(usage_device.installations, 0) as installations,
        coalesce(usage_device.sessions, 0) as sessions
        
    from reporting_grain
    left join app 
        on reporting_grain.app_id = app.app_id
    left join app_store_device 
        on reporting_grain.date_day = app_store_device.date_day
        and reporting_grain.app_id = app_store_device.app_id 
        and reporting_grain.source_type = app_store_device.source_type
        and reporting_grain.device = app_store_device.device
    left join crashes_device
        on reporting_grain.date_day = crashes_device.date_day
        and reporting_grain.app_id = crashes_device.app_id
        and reporting_grain.source_type = crashes_device.source_type
        and reporting_grain.device = crashes_device.device
    left join downloads_device
        on reporting_grain.date_day = downloads_device.date_day
        and reporting_grain.app_id = downloads_device.app_id 
        and reporting_grain.source_type = downloads_device.source_type
        and reporting_grain.device = downloads_device.device
    
    left join usage_device
        on reporting_grain.date_day = usage_device.date_day
        and reporting_grain.app_id = usage_device.app_id 
        and reporting_grain.source_type = usage_device.source_type
        and reporting_grain.device = usage_device.device
)

select * 
from joined
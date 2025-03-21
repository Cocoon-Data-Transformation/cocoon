with  __dbt__cte__int_apple_store__platform_version as (
with base as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__crashes_platform_version
),

aggregated as (

    select 
        date_day, 
        app_id,
        platform_version,
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

app_store_platform_version as (
    
    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app_store_platform_version
),

crashes_platform_version as (
    
    select *
    from __dbt__cte__int_apple_store__platform_version
),

downloads_platform_version as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__downloads_platform_version
),

usage_platform_version as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_platform_version
),

reporting_grain_combined as (

    select
        date_day,
        app_id,
        source_type,
        platform_version
    from app_store_platform_version
    union all
    select 
        date_day,
        app_id,
        source_type,
        platform_version
    from crashes_platform_version
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
        reporting_grain.platform_version,
        coalesce(app_store_platform_version.impressions, 0) as impressions,
        coalesce(app_store_platform_version.impressions_unique_device, 0) as impressions_unique_device,
        coalesce(app_store_platform_version.page_views, 0) as page_views,
        coalesce(app_store_platform_version.page_views_unique_device, 0) as page_views_unique_device,
        coalesce(crashes_platform_version.crashes, 0) as crashes,
        coalesce(downloads_platform_version.first_time_downloads, 0) as first_time_downloads,
        coalesce(downloads_platform_version.redownloads, 0) as redownloads,
        coalesce(downloads_platform_version.total_downloads, 0) as total_downloads,
        coalesce(usage_platform_version.active_devices, 0) as active_devices,
        coalesce(usage_platform_version.active_devices_last_30_days, 0) as active_devices_last_30_days,
        coalesce(usage_platform_version.deletions, 0) as deletions,
        coalesce(usage_platform_version.installations, 0) as installations,
        coalesce(usage_platform_version.sessions, 0) as sessions
    from reporting_grain
    left join app 
        on reporting_grain.app_id = app.app_id
    left join app_store_platform_version 
        on reporting_grain.date_day = app_store_platform_version.date_day
        and reporting_grain.app_id = app_store_platform_version.app_id 
        and reporting_grain.source_type = app_store_platform_version.source_type
        and reporting_grain.platform_version = app_store_platform_version.platform_version
    left join crashes_platform_version
        on reporting_grain.date_day = crashes_platform_version.date_day
        and reporting_grain.app_id = crashes_platform_version.app_id
        and reporting_grain.source_type = crashes_platform_version.source_type
        and reporting_grain.platform_version = crashes_platform_version.platform_version    
    left join downloads_platform_version
        on reporting_grain.date_day = downloads_platform_version.date_day
        and reporting_grain.app_id = downloads_platform_version.app_id 
        and reporting_grain.source_type = downloads_platform_version.source_type
        and reporting_grain.platform_version = downloads_platform_version.platform_version
    left join usage_platform_version
        on reporting_grain.date_day = usage_platform_version.date_day
        and reporting_grain.app_id = usage_platform_version.app_id 
        and reporting_grain.source_type = usage_platform_version.source_type
        and reporting_grain.platform_version = usage_platform_version.platform_version
)

select * 
from joined
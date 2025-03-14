with  __dbt__cte__int_apple_store__crashes_app_version as (
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
), app as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__app
),

crashes_app_version_report as (
    
    select *
    from __dbt__cte__int_apple_store__crashes_app_version
),

usage_app_version_report as (

    select *
    from TEST.PUBLIC_apple_store_source.stg_apple_store__usage_app_version
),

reporting_grain_combined as (
    
    select
        date_day,
        app_id,
        source_type,
        app_version
    from usage_app_version_report
    union all 
    select 
        date_day,
        app_id,
        source_type,
        app_version
    from crashes_app_version_report
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
        reporting_grain.app_version,
        coalesce(crashes_app_version_report.crashes, 0) as crashes,
        coalesce(usage_app_version_report.active_devices, 0) as active_devices,
        coalesce(usage_app_version_report.active_devices_last_30_days, 0) as active_devices_last_30_days,
        coalesce(usage_app_version_report.deletions, 0) as deletions,
        coalesce(usage_app_version_report.installations, 0) as installations,
        coalesce(usage_app_version_report.sessions, 0) as sessions
    from reporting_grain
    left join app 
        on reporting_grain.app_id = app.app_id
    left join crashes_app_version_report
        on reporting_grain.date_day = crashes_app_version_report.date_day
        and reporting_grain.app_id = crashes_app_version_report.app_id
        and reporting_grain.source_type = crashes_app_version_report.source_type
        and reporting_grain.app_version = crashes_app_version_report.app_version
    left join usage_app_version_report
        on reporting_grain.date_day = usage_app_version_report.date_day
        and reporting_grain.app_id = usage_app_version_report.app_id 
        and reporting_grain.source_type = usage_app_version_report.source_type
        and reporting_grain.app_version = usage_app_version_report.app_version
)

select * 
from joined
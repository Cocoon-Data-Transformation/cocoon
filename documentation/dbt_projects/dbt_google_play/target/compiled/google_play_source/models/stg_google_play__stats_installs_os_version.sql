with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_installs_os_version_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    _file
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    _line
    
 , 
    cast(null as timestamp) as 
    
    _modified
    
 , 
    cast(null as integer) as 
    
    active_device_installs
    
 , 
    cast(null as TEXT) as 
    
    android_os_version
    
 , 
    cast(null as integer) as 
    
    current_device_installs
    
 , 
    cast(null as integer) as 
    
    current_user_installs
    
 , 
    cast(null as integer) as 
    
    daily_device_installs
    
 , 
    cast(null as integer) as 
    
    daily_device_uninstalls
    
 , 
    cast(null as integer) as 
    
    daily_device_upgrades
    
 , 
    cast(null as integer) as 
    
    daily_user_installs
    
 , 
    cast(null as integer) as 
    
    daily_user_uninstalls
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    install_events
    
 , 
    cast(null as TEXT) as 
    
    package_name
    
 , 
    cast(null as integer) as 
    
    total_user_installs
    
 , 
    cast(null as integer) as 
    
    uninstall_events
    
 , 
    cast(null as integer) as 
    
    update_events
    
 



    from base
),

final as (

    select
        cast(date as date) as date_day,
        package_name,
        android_os_version,
        sum(active_device_installs) as active_devices_last_30_days,
        sum(daily_device_installs) as device_installs,
        sum(daily_device_uninstalls) as device_uninstalls,
        sum(daily_device_upgrades) as device_upgrades,
        sum(daily_user_installs) as user_installs,
        sum(daily_user_uninstalls) as user_uninstalls,
        sum(install_events) as install_events,
        sum(uninstall_events) as uninstall_events,
        sum(update_events) as update_events
    from fields
    group by 1,2,3
)

select *
from final
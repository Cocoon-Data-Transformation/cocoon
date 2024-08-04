with installs as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_installs_device
), 

ratings as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_ratings_device
), 

install_metrics as (

    select
        *,
        sum(device_installs) over (partition by device, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_installs,
        sum(device_uninstalls) over (partition by device, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_uninstalls
    from installs 
), 

device_join as (

    select 
        -- these 3 columns are the grain of this model
        coalesce(install_metrics.date_day, ratings.date_day) as date_day,
        coalesce(install_metrics.device, ratings.device) as device, -- device type
        coalesce(install_metrics.package_name, ratings.package_name) as package_name,

        -- metrics based on unique devices + users
        coalesce(install_metrics.active_devices_last_30_days, 0) as active_devices_last_30_days,
        coalesce(install_metrics.device_installs, 0) as device_installs,
        coalesce(install_metrics.device_uninstalls, 0) as device_uninstalls,
        coalesce(install_metrics.device_upgrades, 0) as device_upgrades,
        coalesce(install_metrics.user_installs, 0) as user_installs,
        coalesce(install_metrics.user_uninstalls, 0) as user_uninstalls,
        
        -- metrics based on events. a user or device can have multiple installs in one day
        coalesce(install_metrics.install_events, 0) as install_events,
        coalesce(install_metrics.uninstall_events, 0) as uninstall_events,
        coalesce(install_metrics.update_events, 0) as update_events,    

        -- all of the following fields (except average_rating) are rolling metrics that we'll use window functions to backfill instead of coalescing
        install_metrics.total_device_installs,
        install_metrics.total_device_uninstalls,
        ratings.average_rating, -- this one actually isn't rolling but we won't coalesce days with no reviews to 0 rating
        ratings.rolling_total_average_rating
    from install_metrics
    full outer join ratings
        on install_metrics.date_day = ratings.date_day
        and install_metrics.package_name = ratings.package_name
        -- coalesce null device types otherwise they'll cause fanout with the full outer join
        and coalesce(install_metrics.device, 'null_device') = coalesce(ratings.device, 'null_device') -- in the source package we aggregate all null device-type records together into one batch per day
), 

-- to backfill in days with NULL values for rolling metrics, we'll create partitions to batch them together with records that have non-null values
-- we can't just use last_value(ignore nulls) because of postgres :/
create_partitions as (

    select
        *, sum(case when rolling_total_average_rating is null 
                then 0 else 1 end) over (partition by device, package_name order by date_day asc rows unbounded preceding) as rolling_total_average_rating_partition, sum(case when total_device_installs is null 
                then 0 else 1 end) over (partition by device, package_name order by date_day asc rows unbounded preceding) as total_device_installs_partition, sum(case when total_device_uninstalls is null 
                then 0 else 1 end) over (partition by device, package_name order by date_day asc rows unbounded preceding) as total_device_uninstalls_partition
    from device_join
), 

-- now we'll take the non-null value for each partitioned batch and propagate it across the rows included in the batch
fill_values as (

    select 
        date_day,
        device,
        package_name,
        active_devices_last_30_days,
        device_installs,
        device_uninstalls,
        device_upgrades,
        user_installs,
        user_uninstalls,
        install_events,
        uninstall_events,
        update_events,
        average_rating

        , first_value( rolling_total_average_rating ) over (
            partition by rolling_total_average_rating_partition, device, package_name order by date_day asc rows between unbounded preceding and current row) as rolling_total_average_rating, first_value( total_device_installs ) over (
            partition by total_device_installs_partition, device, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_installs, first_value( total_device_uninstalls ) over (
            partition by total_device_uninstalls_partition, device, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_uninstalls
    from create_partitions
), 

final as (

    select 
        date_day,
        device,
        package_name,
        device_installs,
        device_uninstalls,
        device_upgrades,
        user_installs,
        user_uninstalls,
        install_events,
        uninstall_events,
        update_events,
        active_devices_last_30_days,
        average_rating,

        -- leave null if there are no ratings yet
        rolling_total_average_rating,

        -- the first day will have NULL values, let's make it 0
        coalesce(total_device_installs, 0) as total_device_installs,
        coalesce(total_device_uninstalls, 0) as total_device_uninstalls,

        -- calculate difference rolling metric
        coalesce(total_device_installs, 0) - coalesce(total_device_uninstalls, 0) as net_device_installs
    from fill_values
)

select *
from final
with installs as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_installs_country
), 

ratings as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_ratings_country
), 

store_performance as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__store_performance_country
), 

country_codes as (

    select *
    from TEST.PUBLIC_google_play_source.google_play__country_codes
),

install_metrics as (

    select
        *,
        sum(device_installs) over (partition by country, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_installs,
        sum(device_uninstalls) over (partition by country, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_uninstalls
    from installs 
), 

store_performance_metrics as (

    select
        *,
        sum(store_listing_acquisitions) over (partition by country_region, package_name order by date_day asc rows between unbounded preceding and current row) as total_store_acquisitions,
        sum(store_listing_visitors) over (partition by country_region, package_name order by date_day asc rows between unbounded preceding and current row) as total_store_visitors
    from store_performance
), 

country_join as (

    select 
        -- these 3 columns are the grain of this model
        coalesce(install_metrics.date_day, ratings.date_day, store_performance_metrics.date_day) as date_day,
        coalesce(install_metrics.country, ratings.country, store_performance_metrics.country_region) as country,
        coalesce(install_metrics.package_name, ratings.package_name, store_performance_metrics.package_name) as package_name,

        -- metrics based on unique devices + users
        coalesce(install_metrics.active_devices_last_30_days, 0) as active_devices_last_30_days,
        coalesce(install_metrics.device_installs, 0) as device_installs,
        coalesce(install_metrics.device_uninstalls, 0) as device_uninstalls,
        coalesce(install_metrics.device_upgrades, 0) as device_upgrades,
        coalesce(install_metrics.user_installs, 0) as user_installs,
        coalesce(install_metrics.user_uninstalls, 0) as user_uninstalls,
        coalesce(store_performance_metrics.store_listing_acquisitions, 0) as store_listing_acquisitions,
        coalesce(store_performance_metrics.store_listing_visitors, 0) as store_listing_visitors,
        store_performance_metrics.store_listing_conversion_rate, -- not coalescing if there aren't any visitors 
        
        -- metrics based on events. a user or device can have multiple installs in one day
        coalesce(install_metrics.install_events, 0) as install_events,
        coalesce(install_metrics.uninstall_events, 0) as uninstall_events,
        coalesce(install_metrics.update_events, 0) as update_events,    

        -- all of the following fields (except %'s') are rolling metrics that we'll use window functions to backfill instead of coalescing
        install_metrics.total_device_installs,
        install_metrics.total_device_uninstalls,
        ratings.average_rating, -- this one actually isn't rolling but we won't coalesce days with no reviews to 0 rating
        ratings.rolling_total_average_rating,
        store_performance_metrics.total_store_acquisitions,
        store_performance_metrics.total_store_visitors
        
    from install_metrics
    full outer join ratings
        on install_metrics.date_day = ratings.date_day
        and install_metrics.package_name = ratings.package_name
        -- coalesce null countries otherwise they'll cause fanout with the full outer join
        and coalesce(install_metrics.country, 'null_country') = coalesce(ratings.country, 'null_country') -- in the source package we aggregate all null country records together into one batch per day
    full outer join store_performance_metrics
        on store_performance_metrics.date_day = coalesce(install_metrics.date_day, ratings.date_day)
        and store_performance_metrics.package_name = coalesce(install_metrics.package_name, ratings.package_name)
        and coalesce(store_performance_metrics.country_region, 'null_country') = coalesce(install_metrics.country, ratings.country, 'null_country')
), 

-- to backfill in days with NULL values for rolling metrics, we'll create partitions to batch them together with records that have non-null values
-- we can't just use last_value(ignore nulls) because of postgres :/
create_partitions as (

    select
        *, sum(case when rolling_total_average_rating is null 
                then 0 else 1 end) over (partition by country, package_name order by date_day asc rows unbounded preceding) as rolling_total_average_rating_partition, sum(case when total_device_installs is null 
                then 0 else 1 end) over (partition by country, package_name order by date_day asc rows unbounded preceding) as total_device_installs_partition, sum(case when total_device_uninstalls is null 
                then 0 else 1 end) over (partition by country, package_name order by date_day asc rows unbounded preceding) as total_device_uninstalls_partition, sum(case when total_store_acquisitions is null 
                then 0 else 1 end) over (partition by country, package_name order by date_day asc rows unbounded preceding) as total_store_acquisitions_partition, sum(case when total_store_visitors is null 
                then 0 else 1 end) over (partition by country, package_name order by date_day asc rows unbounded preceding) as total_store_visitors_partition
    from country_join
), 

-- now we'll take the non-null value for each partitioned batch and propagate it across the rows included in the batch
fill_values as (

    select 
        date_day,
        country,
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
        store_listing_acquisitions, 
        store_listing_visitors,
        store_listing_conversion_rate,
        average_rating

        , first_value( rolling_total_average_rating ) over (
            partition by rolling_total_average_rating_partition, country, package_name order by date_day asc rows between unbounded preceding and current row) as rolling_total_average_rating, first_value( total_device_installs ) over (
            partition by total_device_installs_partition, country, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_installs, first_value( total_device_uninstalls ) over (
            partition by total_device_uninstalls_partition, country, package_name order by date_day asc rows between unbounded preceding and current row) as total_device_uninstalls, first_value( total_store_acquisitions ) over (
            partition by total_store_acquisitions_partition, country, package_name order by date_day asc rows between unbounded preceding and current row) as total_store_acquisitions, first_value( total_store_visitors ) over (
            partition by total_store_visitors_partition, country, package_name order by date_day asc rows between unbounded preceding and current row) as total_store_visitors
    from create_partitions
), 

final as (

    select 
        date_day,
        country as country_short,
        coalesce(country_codes.alternative_country_name, country_codes.country_name) as country_long,
        country_codes.region,
        country_codes.sub_region,
        package_name,
        device_installs,
        device_uninstalls,
        device_upgrades,
        user_installs,
        user_uninstalls,
        install_events,
        uninstall_events,
        update_events,
        store_listing_acquisitions,
        store_listing_visitors,
        store_listing_conversion_rate,
        active_devices_last_30_days,
        average_rating,

        -- leave null if there are no ratings yet
        rolling_total_average_rating, 

        -- the first day will have NULL values, let's make it 0
        coalesce(total_device_installs, 0) as total_device_installs,
        coalesce(total_device_uninstalls, 0) as total_device_uninstalls,
        coalesce(total_store_acquisitions, 0) as total_store_acquisitions,
        coalesce(total_store_visitors, 0) as total_store_visitors,

        -- calculate percentage and difference rolling metrics
        round(cast(total_store_acquisitions as numeric(28,6)) / nullif(total_store_visitors, 0), 4) as rolling_store_conversion_rate,
        coalesce(total_device_installs, 0) - coalesce(total_device_uninstalls, 0) as net_device_installs
    from fill_values
    left join country_codes
        on country_codes.country_code_alpha_2 = fill_values.country
)

select *
from final
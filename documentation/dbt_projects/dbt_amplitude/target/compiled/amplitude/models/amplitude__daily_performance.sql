

with event_enhanced as (

    select * 
    from TEST.PUBLIC_amplitude.amplitude__event_enhanced
),



date_spine as (
    
    select spine.*
    from TEST.PUBLIC_int_amplitude.int_amplitude__date_spine as spine

    
), 

agg_event_data as (

    select
        event_day,
        event_type,
        count(distinct unique_event_id) as number_events,
        count(distinct unique_session_id) as number_sessions,
        count(distinct amplitude_user_id) as number_users,
        count(distinct 
                (case when cast( date_trunc('day', user_creation_time) as date) = event_day
            then amplitude_user_id end)) as number_new_users 
    from event_enhanced
    group by 1,2
),

spine_joined as (

    select
        date_spine.event_day,
        date_spine.event_type,
        agg_event_data.number_events,
        agg_event_data.number_sessions,
        agg_event_data.number_users,
        agg_event_data.number_new_users
    from date_spine
    left join agg_event_data
        on date_spine.event_day = agg_event_data.event_day
        and date_spine.event_type = agg_event_data.event_type
),

final as (

    select
        event_day,
        event_type,
        coalesce(number_events,0) as number_events,
        coalesce(number_sessions,0) as number_sessions,
        coalesce(number_users,0) as number_users,
        coalesce(number_new_users,0) as number_new_users,
        md5(cast(coalesce(cast(event_day as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(event_type as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as daily_unique_key
    from spine_joined

    
)

select *
from final
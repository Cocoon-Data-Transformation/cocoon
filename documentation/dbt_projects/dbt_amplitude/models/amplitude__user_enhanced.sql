with event_enhanced as (

    select * 
    from {{ ref('amplitude__event_enhanced') }}
),

session_data as (

    select *
    from {{ ref('amplitude__sessions') }}
)

select
    event_enhanced.amplitude_user_id,
    min(event_enhanced.user_creation_time) as user_created_at,
    min(event_enhanced.session_started_at) as first_session_at,
    max(event_enhanced.session_ended_at) as last_session_at,
    count(distinct event_enhanced.unique_event_id) as total_events_per_user,
    count(distinct session_data.unique_session_id) as total_sessions_per_user,
    avg(session_data.session_length_in_minutes) as average_session_length_in_minutes,
    avg(session_data.minutes_in_between_sessions) as average_minutes_in_between_sessions

from event_enhanced
left join session_data
    on event_enhanced.unique_session_id = session_data.unique_session_id
group by 1


with 



event_data_raw as (

    select events.*
    from TEST.PUBLIC__source_amplitude.stg_amplitude__event as events

    
),

-- deduplicate
event_data as (
    
    select * 
    from (
        select 
            *,
            case when _insert_id is not null
                then row_number() over (partition by _insert_id order by client_upload_time desc)
                else row_number() over (partition by event_id, device_id, client_event_time, amplitude_user_id order by client_upload_time desc)
            end as nth_event_record

        from event_data_raw
        ) as duplicates
    where nth_event_record = 1
),

event_type as (

    select * 
    from TEST.PUBLIC__source_amplitude.stg_amplitude__event_type
),

session_data as (

    select *
    from TEST.PUBLIC_amplitude.amplitude__sessions
),

event_enhanced as (

    select
        event_data.unique_event_id
        , event_data.unique_session_id
        , cast(event_data.amplitude_user_id as TEXT) as amplitude_user_id
        , event_data.event_id
        , event_data.event_type
        , event_data.event_time
        , event_data.event_day

        

        , event_type.event_type_id
        , event_type.event_type_name
        , event_data.session_id
        , row_number() over (partition by session_id order by event_time asc) as session_event_number
        , row_number() over (partition by amplitude_user_id order by event_time asc) as user_event_number
        , event_data.group_types

        

        , cast(event_data.user_id as TEXT) as user_id
        , event_data.user_creation_time

        

        , event_data.amplitude_id
        , event_data.app
        , event_data.project_name
        , event_data.version_name
        , event_data.client_event_time
        , event_data.client_upload_time
        , event_data.server_received_time
        , event_data.server_upload_time
        , event_data.city
        , event_data.country
        , event_data.region
        , event_data.data
        , event_data.location_lat
        , event_data.location_lng
        , event_data.device_brand
        , event_data.device_carrier
        , event_data.device_family
        , event_data.device_id
        , event_data.device_manufacturer
        , event_data.device_model
        , event_data.device_type
        , event_data.ip_address
        , event_data.os_name
        , event_data.os_version
        , event_data.platform
        , event_data.language
        , event_data.dma
        , event_data.schema
        , event_data.start_version
        , event_type.totals
        , event_type.value
        , session_data.events_per_session
        , session_data.session_started_at
        , session_data.session_ended_at
        , session_data.user_session_number
        , session_data.session_started_at_day
        , session_data.session_ended_at_day
        , session_data.session_length_in_minutes
        , session_data.is_first_user_session
        , session_data.minutes_in_between_sessions

    from event_data
    left join event_type
        on event_data.event_type_id = event_type.event_type_id
    left join session_data
        on event_data.unique_session_id = session_data.unique_session_id
),

final as (

    select 
        *,
        md5(cast(coalesce(cast(unique_event_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(event_day as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as unique_key
    from event_enhanced
)

select *
from final
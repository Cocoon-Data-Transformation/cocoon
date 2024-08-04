with base as (

    select * 
    from TEST.PUBLIC__source_amplitude.stg_amplitude__event_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    _insert_id
    
 , 
    cast(null as TEXT) as 
    
    ad_id
    
 , 
    cast(null as TEXT) as 
    
    amplitude_id
    
 , 
    cast(null as TEXT) as 
    
    app
    
 , 
    cast(null as TEXT) as 
    
    city
    
 , 
    cast(null as timestamp) as 
    
    client_event_time
    
 , 
    cast(null as timestamp) as 
    
    client_upload_time
    
 , 
    cast(null as TEXT) as 
    
    country
    
 , 
    cast(null as TEXT) as 
    
    data
    
 , 
    cast(null as TEXT) as 
    
    device_brand
    
 , 
    cast(null as TEXT) as 
    
    device_carrier
    
 , 
    cast(null as TEXT) as 
    
    device_family
    
 , 
    cast(null as TEXT) as 
    
    device_id
    
 , 
    cast(null as TEXT) as 
    
    device_manufacturer
    
 , 
    cast(null as TEXT) as 
    
    device_model
    
 , 
    cast(null as TEXT) as 
    
    device_type
    
 , 
    cast(null as TEXT) as 
    
    dma
    
 , 
    cast(null as TEXT) as 
    
    event_properties
    
 , 
    cast(null as timestamp) as 
    
    event_time
    
 , 
    cast(null as TEXT) as 
    
    event_type
    
 , 
    cast(null as integer) as 
    
    event_type_id
    
 , 
    cast(null as TEXT) as 
    
    group_properties
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    idfa
    
 , 
    cast(null as TEXT) as 
    
    ip_address
    
 , 
    cast(null as boolean) as 
    
    is_attribution_event
    
 , 
    cast(null as TEXT) as 
    
    language
    
 , 
    cast(null as TEXT) as 
    
    library
    
 , 
    cast(null as TEXT) as 
    
    location_lat
    
 , 
    cast(null as TEXT) as 
    
    location_lng
    
 , 
    cast(null as TEXT) as 
    
    os_name
    
 , 
    cast(null as TEXT) as 
    
    os_version
    
 , 
    cast(null as boolean) as 
    
    paying
    
 , 
    cast(null as TEXT) as 
    
    platform
    
 , 
    cast(null as timestamp) as 
    
    processed_time
    
 , 
    cast(null as TEXT) as 
    
    project_name
    
 , 
    cast(null as TEXT) as 
    
    region
    
 , 
    cast(null as integer) as 
    
    schema
    
 , 
    cast(null as timestamp) as 
    
    server_received_time
    
 , 
    cast(null as timestamp) as 
    
    server_upload_time
    
 , 
    cast(null as integer) as 
    
    session_id
    
 , 
    cast(null as TEXT) as 
    
    start_version
    
 , 
    cast(null as timestamp) as 
    
    user_creation_time
    
 , 
    cast(null as TEXT) as 
    
    user_id
    
 , 
    cast(null as TEXT) as 
    
    user_properties
    
 , 
    cast(null as TEXT) as 
    
    uuid
    
 , 
    cast(null as TEXT) as 
    
    version_name
    
 , 
    cast(null as TEXT) as group_types 


    from base
),

final as (

    select
        id as event_id,
        cast(event_time as timestamp) as event_time,
        cast(date_trunc('day', event_time) as date) as event_day,
        md5(cast(coalesce(cast(user_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(session_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as unique_session_id,
        coalesce(cast(user_id as TEXT), (cast(amplitude_id as TEXT))) as amplitude_user_id,
        event_properties,
        event_type,
        event_type_id,
        group_types,
        group_properties,
        session_id,
        cast(user_id as TEXT) as user_id, 
        user_properties,
        cast(amplitude_id as TEXT) as amplitude_id,
        _insert_id,
        ad_id,
        app,
        project_name,
        cast(client_event_time as timestamp) as client_event_time,
        cast(client_upload_time as timestamp) as client_upload_time,
        city,
        country,
        data,
        device_brand,
        device_carrier,
        device_family,
        device_id,
        device_manufacturer,
        device_model,
        device_type,
        dma,
        idfa,
        ip_address,
        language,
        location_lat,
        location_lng,
        os_name,
        os_version,
        is_attribution_event,
        library,
        paying as is_paying,
        platform,
        cast(processed_time as timestamp) as processed_time,
        region,
        schema,
        cast(server_received_time as timestamp) as server_received_time,
        cast(server_upload_time as timestamp) as server_upload_time,
        start_version,
        cast(user_creation_time as timestamp) as user_creation_time,
        uuid,
        version_name,
        _fivetran_synced
    from fields

    where cast(date_trunc('day', event_time) as date) >= cast('2020-01-01' as date) -- filter to records past a specific date
    and cast(date_trunc('day', event_time) as date) <= cast(

    dateadd(
        month,
        1,
        date_trunc('day', 
  current_timestamp::timestamp
)
        )

 as date) -- filter to records before a specific date

),

surrogate as (

    select
        *,
        md5(cast(coalesce(cast(event_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(device_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(client_event_time as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(amplitude_user_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as unique_event_id
    from final
)

select *
from surrogate
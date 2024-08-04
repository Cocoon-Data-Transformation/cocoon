with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_response_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    distribution_channel
    
 , 
    cast(null as integer) as 
    
    duration_in_seconds
    
 , 
    cast(null as timestamp) as 
    
    end_date
    
 , 
    cast(null as integer) as 
    
    finished
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    ip_address
    
 , 
    cast(null as timestamp) as 
    
    last_modified_date
    
 , 
    cast(null as float) as 
    
    location_latitude
    
 , 
    cast(null as float) as 
    
    location_longitude
    
 , 
    cast(null as integer) as 
    
    progress
    
 , 
    cast(null as TEXT) as 
    
    recipient_email
    
 , 
    cast(null as TEXT) as 
    
    recipient_first_name
    
 , 
    cast(null as TEXT) as 
    
    recipient_last_name
    
 , 
    cast(null as timestamp) as 
    
    recorded_date
    
 , 
    cast(null as timestamp) as 
    
    start_date
    
 , 
    cast(null as integer) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    survey_id
    
 , 
    cast(null as TEXT) as 
    
    user_language
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        distribution_channel,
        duration_in_seconds,
        cast(end_date as timestamp) as finished_at,
        cast(case when finished = 1 then true else false end as boolean) as is_finished,
        id as response_id,
        ip_address,
        cast(last_modified_date as timestamp) as last_modified_at,
        location_latitude,
        location_longitude,
        progress,
        lower(recipient_email) as recipient_email,
        recipient_first_name,
        recipient_last_name,
        cast(recorded_date as timestamp) as recorded_date,
        cast(start_date as timestamp) as started_at,
        status,
        survey_id,
        user_language,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
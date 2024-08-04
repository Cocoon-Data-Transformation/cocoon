with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__distribution_contact_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    contact_frequency_rule_id
    
 , 
    cast(null as TEXT) as 
    
    contact_id
    
 , 
    cast(null as TEXT) as 
    
    contact_lookup_id
    
 , 
    cast(null as TEXT) as 
    
    distribution_id
    
 , 
    cast(null as timestamp) as 
    
    opened_at
    
 , 
    cast(null as timestamp) as 
    
    response_completed_at
    
 , 
    cast(null as TEXT) as 
    
    response_id
    
 , 
    cast(null as timestamp) as 
    
    response_started_at
    
 , 
    cast(null as timestamp) as 
    
    sent_at
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    survey_link
    
 , 
    cast(null as TEXT) as 
    
    survey_session_id
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        contact_frequency_rule_id,
        contact_id,
        contact_lookup_id,
        distribution_id,
        cast(opened_at as timestamp) as opened_at,
        cast(response_completed_at as timestamp) as response_completed_at,
        response_id,
        cast(response_started_at as timestamp) as response_started_at,
        cast(sent_at as timestamp) as sent_at,
        status,
        survey_link,
        survey_session_id,
        _fivetran_synced,
        source_relation

    from fields
)

select *
from final
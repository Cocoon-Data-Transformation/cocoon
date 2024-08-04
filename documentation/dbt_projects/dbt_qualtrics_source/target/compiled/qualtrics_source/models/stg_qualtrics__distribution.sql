with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__distribution_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_date
    
 , 
    cast(null as TEXT) as 
    
    header_from_email
    
 , 
    cast(null as TEXT) as 
    
    header_from_name
    
 , 
    cast(null as TEXT) as 
    
    header_reply_to_email
    
 , 
    cast(null as TEXT) as 
    
    header_subject
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    message_library_id
    
 , 
    cast(null as TEXT) as 
    
    message_message_id
    
 , 
    cast(null as TEXT) as 
    
    message_message_text
    
 , 
    cast(null as timestamp) as 
    
    modified_date
    
 , 
    cast(null as TEXT) as 
    
    organization_id
    
 , 
    cast(null as TEXT) as 
    
    owner_id
    
 , 
    cast(null as TEXT) as 
    
    parent_distribution_id
    
 , 
    cast(null as TEXT) as 
    
    recipient_contact_id
    
 , 
    cast(null as TEXT) as 
    
    recipient_library_id
    
 , 
    cast(null as TEXT) as 
    
    recipient_mailing_list_id
    
 , 
    cast(null as TEXT) as 
    
    recipient_sample_id
    
 , 
    cast(null as TEXT) as 
    
    request_status
    
 , 
    cast(null as TEXT) as 
    
    request_type
    
 , 
    cast(null as timestamp) as 
    
    send_date
    
 , 
    cast(null as timestamp) as 
    
    survey_link_expiration_date
    
 , 
    cast(null as TEXT) as 
    
    survey_link_link_type
    
 , 
    cast(null as TEXT) as 
    
    survey_link_survey_id
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        cast(created_date as timestamp) as created_at,
        header_from_email,
        header_from_name,
        header_reply_to_email,
        header_subject,
        id as distribution_id,
        message_library_id,
        message_message_id as message_id,
        message_message_text as message_text,
        cast(modified_date as timestamp) as last_modified_at,
        organization_id,
        owner_id as owner_user_id,
        parent_distribution_id,
        recipient_contact_id,
        recipient_library_id,
        recipient_mailing_list_id,
        recipient_sample_id,
        request_status,
        request_type,
        cast(send_date as timestamp) as send_at,
        cast(survey_link_expiration_date as timestamp) as survey_link_expires_at,
        survey_link_link_type as survey_link_type,
        survey_link_survey_id as survey_id,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation

        





    from fields
)

select *
from final
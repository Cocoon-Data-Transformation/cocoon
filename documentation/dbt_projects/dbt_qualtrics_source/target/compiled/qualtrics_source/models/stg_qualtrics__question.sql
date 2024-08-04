with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__question_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    data_export_tag
    
 , 
    cast(null as boolean) as 
    
    data_visibility_hidden
    
 , 
    cast(null as boolean) as 
    
    data_visibility_private
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    next_answer_id
    
 , 
    cast(null as integer) as 
    
    next_choice_id
    
 , 
    cast(null as TEXT) as 
    
    question_description
    
 , 
    cast(null as TEXT) as 
    
    question_description_option
    
 , 
    cast(null as TEXT) as 
    
    question_text
    
 , 
    cast(null as TEXT) as 
    
    question_text_unsafe
    
 , 
    cast(null as TEXT) as 
    
    question_type
    
 , 
    cast(null as TEXT) as 
    
    selector
    
 , 
    cast(null as TEXT) as 
    
    sub_selector
    
 , 
    cast(null as TEXT) as 
    
    survey_id
    
 , 
    cast(null as TEXT) as 
    
    validation_setting_force_response
    
 , 
    cast(null as TEXT) as 
    
    validation_setting_force_response_type
    
 , 
    cast(null as TEXT) as 
    
    validation_setting_type
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        data_export_tag,
        data_visibility_hidden as is_data_hidden,
        data_visibility_private as is_data_private,
        id as question_id,
        next_answer_id,
        next_choice_id,
        question_description,
        question_description_option,
        question_text,
        question_text_unsafe,
        question_type,
        selector,
        sub_selector,
        survey_id,
        validation_setting_force_response,
        validation_setting_force_response_type,
        validation_setting_type,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation
    from fields
)

select *
from final
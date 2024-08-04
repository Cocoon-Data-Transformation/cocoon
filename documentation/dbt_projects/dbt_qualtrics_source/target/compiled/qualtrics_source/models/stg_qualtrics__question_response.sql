with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__question_response_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    _fivetran_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    loop_id
    
 , 
    cast(null as TEXT) as 
    
    question
    
 , 
    cast(null as TEXT) as 
    
    question_id
    
 , 
    cast(null as TEXT) as 
    
    question_option_key
    
 , 
    cast(null as TEXT) as 
    
    response_id
    
 , 
    cast(null as TEXT) as 
    
    sub_question_key
    
 , 
    cast(null as TEXT) as 
    
    sub_question_text
    
 , 
    cast(null as TEXT) as 
    
    value
    
 


        
        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        _fivetran_id,
        loop_id,
        question_id,
        question,
        question_option_key,
        response_id,
        sub_question_key,
        sub_question_text,
        value,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
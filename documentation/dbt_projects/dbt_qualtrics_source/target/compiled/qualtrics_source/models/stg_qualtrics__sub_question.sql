with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__sub_question_tmp
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
    
    choice_data_export_tag
    
 , 
    cast(null as TEXT) as 
    
    key
    
 , 
    cast(null as TEXT) as 
    
    question_id
    
 , 
    cast(null as TEXT) as 
    
    survey_id
    
 , 
    cast(null as TEXT) as 
    
    text
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        choice_data_export_tag,
        key,
        question_id,
        survey_id,
        text,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
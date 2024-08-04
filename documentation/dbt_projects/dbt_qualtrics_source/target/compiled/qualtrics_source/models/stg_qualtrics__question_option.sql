with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__question_option_tmp
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
    
    key
    
 , 
    cast(null as TEXT) as 
    
    question_id
    
 , 
    cast(null as TEXT) as 
    
    recode_value
    
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
        question_id,
        survey_id,
        key,
        recode_value,
        text,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
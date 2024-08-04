with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__block_question_tmp
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
    
    block_id
    
 , 
    cast(null as TEXT) as 
    
    question_id
    
 , 
    cast(null as TEXT) as 
    
    survey_id
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        block_id,
        question_id,
        survey_id,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
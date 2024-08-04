with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__block_tmp
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
    
    block_locking
    
 , 
    cast(null as TEXT) as 
    
    block_visibility
    
 , 
    cast(null as TEXT) as 
    
    description
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    randomize_questions
    
 , 
    cast(null as TEXT) as 
    
    survey_id
    
 , 
    cast(null as TEXT) as 
    
    type
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        block_locking as is_locked,
        block_visibility,
        description,
        id as block_id,
        randomize_questions,
        survey_id,
        type,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation

    from fields
)

select *
from final
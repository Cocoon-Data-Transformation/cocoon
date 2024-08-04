with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_version_tmp
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
    
    creation_date
    
 , 
    cast(null as TEXT) as 
    
    description
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    published
    
 , 
    cast(null as TEXT) as 
    
    survey_id
    
 , 
    cast(null as TEXT) as 
    
    user_id
    
 , 
    cast(null as integer) as 
    
    version_number
    
 , 
    cast(null as boolean) as 
    
    was_published
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        cast(creation_date as timestamp) as created_at,
        description as version_description,
        id as version_id,
        published as is_published,
        survey_id,
        user_id as publisher_user_id,
        version_number,
        was_published,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
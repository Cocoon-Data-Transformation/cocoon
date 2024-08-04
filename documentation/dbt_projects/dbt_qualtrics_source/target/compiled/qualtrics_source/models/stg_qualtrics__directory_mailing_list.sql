with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__directory_mailing_list_tmp
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
    
    directory_id
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    last_modified_date
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    owner_id
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        cast(creation_date as timestamp) as created_at,
        directory_id,
        id as mailing_list_id,
        cast(last_modified_date as timestamp) as last_modified_at,
        name,
        owner_id as owner_user_id,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation

    from fields
)

select *
from final
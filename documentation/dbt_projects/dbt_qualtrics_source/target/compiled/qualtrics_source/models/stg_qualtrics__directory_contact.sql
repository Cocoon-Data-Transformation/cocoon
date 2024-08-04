with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__directory_contact_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    creation_date
    
 , 
    cast(null as TEXT) as 
    
    directory_id
    
 , 
    cast(null as timestamp) as 
    
    directory_unsubscribe_date
    
 , 
    cast(null as boolean) as 
    
    directory_unsubscribed
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    email_domain
    
 , 
    cast(null as TEXT) as 
    
    ext_ref
    
 , 
    cast(null as TEXT) as 
    
    first_name
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    language
    
 , 
    cast(null as timestamp) as 
    
    last_modified
    
 , 
    cast(null as TEXT) as 
    
    last_name
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 



        


, cast('' as TEXT) as source_relation



        
    from base
),

final as (
    
    select 
        cast(creation_date as timestamp) as created_at,
        directory_id,
        cast(directory_unsubscribe_date as timestamp) as unsubscribed_from_directory_at,
        directory_unsubscribed as is_unsubscribed_from_directory,
        lower(email) as email,
        lower(email_domain) as email_domain,
        ext_ref,
        first_name,
        last_name,
        REGEXP_REPLACE(phone, '[^0-9]', '') AS phone, -- remove any non-numeric chars
        id as contact_id,
        language,
        cast(last_modified as timestamp) as last_modified_at,
        _fivetran_synced,
        source_relation

        





    from fields
)

select *
from final
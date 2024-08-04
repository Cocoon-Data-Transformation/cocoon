with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__directory_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    deduplication_criteria_email
    
 , 
    cast(null as boolean) as 
    
    deduplication_criteria_external_data_reference
    
 , 
    cast(null as boolean) as 
    
    deduplication_criteria_first_name
    
 , 
    cast(null as boolean) as 
    
    deduplication_criteria_last_name
    
 , 
    cast(null as boolean) as 
    
    deduplication_criteria_phone
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    is_default
    
 , 
    cast(null as TEXT) as 
    
    name
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        deduplication_criteria_email as is_deduped_on_email,
        deduplication_criteria_external_data_reference as is_deduped_on_ext_ref,
        deduplication_criteria_first_name as is_deduped_on_first_name,
        deduplication_criteria_last_name as is_deduped_on_last_name,
        deduplication_criteria_phone as is_deduped_on_phone,
        id as directory_id,
        is_default,
        name,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation

        





    from fields
)

select *
from final
with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_embedded_data_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    import_id
    
 , 
    cast(null as TEXT) as 
    
    key
    
 , 
    cast(null as TEXT) as 
    
    response_id
    
 , 
    cast(null as TEXT) as 
    
    value
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        import_id,
        key,
        response_id,
        value,
        _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
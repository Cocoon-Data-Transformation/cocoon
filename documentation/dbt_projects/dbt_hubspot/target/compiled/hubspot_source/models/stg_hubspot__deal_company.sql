

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_company_tmp

), macro as (

    select 
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    deal_id
    
 , 
    cast(null as integer) as 
    
    company_id
    
 , 
    cast(null as integer) as 
    
    type_id
    
 


    from base

), fields as (

    select
        company_id,
        deal_id,
        type_id,
        cast(_fivetran_synced as timestamp) as _fivetran_synced
        
    from macro
    
)

select *
from fields
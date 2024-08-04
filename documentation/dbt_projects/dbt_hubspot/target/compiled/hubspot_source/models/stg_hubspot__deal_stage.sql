

with base as (

    select * 
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__deal_stage_tmp

),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_active
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_end
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_start
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    date_entered
    
 , 
    cast(null as integer) as 
    
    deal_id
    
 , 
    cast(null as TEXT) as 
    
    source
    
 , 
    cast(null as TEXT) as 
    
    source_id
    
 , 
    cast(null as TEXT) as 
    
    value
    
 


        
    from base
),

final as (
    
    select 
        cast(date_entered as timestamp) as date_entered,
        deal_id,
        source,
        source_id,
        value as deal_stage_name,
        _fivetran_active,
        cast(_fivetran_end as timestamp) as _fivetran_end,
        cast(_fivetran_start as timestamp) as _fivetran_start
    from fields
)

select * 
from final
with base as (

    select * 
    from TEST.PUBLIC_apple_store_source.stg_apple_store__sales_account_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 


        
    from base
),

final as (
    
    select 
        id as account_id,
        name as account_name
    from fields
)

select * 
from final
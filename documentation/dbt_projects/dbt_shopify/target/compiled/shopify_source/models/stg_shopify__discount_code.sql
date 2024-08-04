-- this model will be all NULL until you create a discount code in Shopify

with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__discount_code_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    code
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    price_rule_id
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as float) as 
    
    usage_count
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as discount_code_id,
        upper(code) as code,
        price_rule_id,
        usage_count,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
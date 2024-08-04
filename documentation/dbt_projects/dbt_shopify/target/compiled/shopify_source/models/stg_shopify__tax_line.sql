with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__tax_line_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    index
    
 , 
    cast(null as integer) as 
    
    order_line_id
    
 , 
    cast(null as float) as 
    
    price
    
 , 
    cast(null as TEXT) as 
    
    price_set
    
 , 
    cast(null as float) as 
    
    rate
    
 , 
    cast(null as TEXT) as 
    
    title
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        index,
        order_line_id,
        price,
        price_set,
        rate,
        title,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
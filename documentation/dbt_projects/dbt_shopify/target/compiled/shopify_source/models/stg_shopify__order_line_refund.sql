-- this model will be all NULL until you have made an order line refund in Shopify

with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line_refund_tmp

),

fields as (

    select
    
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as numeric(28,6)) as 
    
    location_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    order_line_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    subtotal
    
 , 
    cast(null as TEXT) as 
    
    subtotal_set
    
 , 
    cast(null as numeric(28,6)) as 
    
    total_tax
    
 , 
    cast(null as TEXT) as 
    
    total_tax_set
    
 , 
    cast(null as float) as 
    
    quantity
    
 , 
    cast(null as numeric(28,6)) as 
    
    refund_id
    
 , 
    cast(null as TEXT) as 
    
    restock_type
    
 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (

    select
        id as order_line_refund_id,
        location_id,
        order_line_id,
        subtotal,
        subtotal_set,
        total_tax,
        total_tax_set,
        quantity,
        refund_id,
        restock_type,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

        





    from fields
)

select *
from final
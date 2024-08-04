-- this model will be all NULL until you have made an order adjustment in Shopify

with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_adjustment_tmp

),

fields as (

    select
        
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as numeric(28,6)) as 
    
    order_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    refund_id
    
 , 
    cast(null as float) as 
    
    amount
    
 , 
    cast(null as TEXT) as 
    
    amount_set
    
 , 
    cast(null as float) as 
    
    tax_amount
    
 , 
    cast(null as TEXT) as 
    
    tax_amount_set
    
 , 
    cast(null as TEXT) as 
    
    kind
    
 , 
    cast(null as TEXT) as 
    
    reason
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 



        


, cast('' as TEXT) as source_relation



        
    from base
),

final as (

    select
        id as order_adjustment_id,
        order_id,
        refund_id,
        amount,
        amount_set,
        tax_amount,
        tax_amount_set,
        kind,
        reason,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
)

select * 
from final
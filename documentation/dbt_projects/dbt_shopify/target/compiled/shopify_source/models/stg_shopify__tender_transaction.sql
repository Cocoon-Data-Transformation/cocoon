with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__tender_transaction_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as float) as 
    
    amount
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    order_id
    
 , 
    cast(null as TEXT) as 
    
    payment_method
    
 , 
    cast(null as timestamp) as 
    
    processed_at
    
 , 
    cast(null as TEXT) as 
    
    remote_reference
    
 , 
    cast(null as boolean) as 
    
    test
    
 , 
    cast(null as integer) as 
    
    user_id
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as transaction_id,
        order_id,
        amount,
        currency,
        payment_method,
        remote_reference,
        user_id,
        convert_timezone('UTC', 'UTC',
    cast(cast(processed_at as timestamp) as timestamp)
) as processed_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
    where not coalesce(test, false)
)

select *
from final
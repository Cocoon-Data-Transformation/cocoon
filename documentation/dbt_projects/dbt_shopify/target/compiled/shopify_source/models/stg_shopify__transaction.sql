with base as (

    select * from TEST.PUBLIC_stg_shopify.stg_shopify__transaction_tmp

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
    cast(null as numeric(28,6)) as 
    
    amount
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as timestamp) as 
    
    processed_at
    
 , 
    cast(null as numeric(28,6)) as 
    
    device_id
    
 , 
    cast(null as TEXT) as 
    
    gateway
    
 , 
    cast(null as TEXT) as 
    
    source_name
    
 , 
    cast(null as TEXT) as 
    
    message
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as numeric(28,6)) as 
    
    location_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    parent_id
    
 , 
    cast(null as TEXT) as 
    
    payment_avs_result_code
    
 , 
    cast(null as TEXT) as 
    
    payment_credit_card_bin
    
 , 
    cast(null as TEXT) as 
    
    payment_cvv_result_code
    
 , 
    cast(null as TEXT) as 
    
    payment_credit_card_number
    
 , 
    cast(null as TEXT) as 
    
    payment_credit_card_company
    
 , 
    cast(null as TEXT) as 
    
    kind
    
 , 
    cast(null as TEXT) as 
    
    receipt
    
 , 
    cast(null as numeric(28,6)) as 
    
    currency_exchange_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    currency_exchange_adjustment
    
 , 
    cast(null as numeric(28,6)) as 
    
    currency_exchange_original_amount
    
 , 
    cast(null as numeric(28,6)) as 
    
    currency_exchange_final_amount
    
 , 
    cast(null as TEXT) as 
    
    currency_exchange_currency
    
 , 
    cast(null as TEXT) as 
    
    error_code
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as boolean) as 
    
    test
    
 , 
    cast(null as numeric(28,6)) as 
    
    user_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    authorization_expires_at
    
 , 
    cast(null as TEXT) as authorization_code 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (

    select 
        id as transaction_id,
        order_id,
        refund_id,
        amount,
        device_id,
        gateway,
        source_name,
        message,
        currency,
        location_id,
        parent_id,
        payment_avs_result_code,
        payment_credit_card_bin,
        payment_cvv_result_code,
        payment_credit_card_number,
        payment_credit_card_company,
        kind,
        receipt,
        currency_exchange_id,
        currency_exchange_adjustment,
        currency_exchange_original_amount,
        currency_exchange_final_amount,
        currency_exchange_currency,
        error_code,
        status,
        user_id,
        authorization_code,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(processed_at as timestamp) as timestamp)
) as processed_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(authorization_expires_at as timestamp) as timestamp)
) as authorization_expires_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

        





    from fields
    where not coalesce(test, false)
)

select * 
from final
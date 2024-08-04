with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout_shipping_line_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    carrier_identifier
    
 , 
    cast(null as integer) as 
    
    checkout_id
    
 , 
    cast(null as TEXT) as 
    
    code
    
 , 
    cast(null as TEXT) as 
    
    delivery_category
    
 , 
    cast(null as TEXT) as 
    
    delivery_expectation_range
    
 , 
    cast(null as integer) as 
    
    delivery_expectation_range_max
    
 , 
    cast(null as integer) as 
    
    delivery_expectation_range_min
    
 , 
    cast(null as TEXT) as 
    
    delivery_expectation_type
    
 , 
    cast(null as float) as 
    
    discounted_price
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    index
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 , 
    cast(null as float) as 
    
    price
    
 , 
    cast(null as TEXT) as 
    
    requested_fulfillment_service_id
    
 , 
    cast(null as TEXT) as 
    
    source
    
 , 
    cast(null as TEXT) as 
    
    title
    
 



        


, cast('' as TEXT) as source_relation



        
    from base
),

final as (
    
    select 
        id as abandoned_checkout_shipping_line_id,
        checkout_id,
        index,
        carrier_identifier,
        code as shipping_code,
        delivery_category,
        delivery_expectation_range,
        delivery_expectation_range_max,
        delivery_expectation_range_min,
        delivery_expectation_type,
        discounted_price,
        phone,
        price,
        requested_fulfillment_service_id,
        source,
        title,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
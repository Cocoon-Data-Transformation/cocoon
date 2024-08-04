with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_shipping_line_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    carrier_identifier
    
 , 
    cast(null as TEXT) as 
    
    code
    
 , 
    cast(null as TEXT) as 
    
    delivery_category
    
 , 
    cast(null as float) as 
    
    discounted_price
    
 , 
    cast(null as TEXT) as 
    
    discounted_price_set
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    order_id
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 , 
    cast(null as float) as 
    
    price
    
 , 
    cast(null as TEXT) as 
    
    price_set
    
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
        id as order_shipping_line_id,
        order_id,
        carrier_identifier,
        code,
        delivery_category,
        discounted_price,
        discounted_price_set,
        phone,
        price,
        price_set,
        requested_fulfillment_service_id is not null as is_third_party_required,
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
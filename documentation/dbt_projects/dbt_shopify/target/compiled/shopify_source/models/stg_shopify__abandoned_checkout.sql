with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    abandoned_checkout_url
    
 , 
    cast(null as TEXT) as 
    
    billing_address_address_1
    
 , 
    cast(null as TEXT) as 
    
    billing_address_address_2
    
 , 
    cast(null as TEXT) as 
    
    billing_address_city
    
 , 
    cast(null as TEXT) as 
    
    billing_address_company
    
 , 
    cast(null as TEXT) as 
    
    billing_address_country
    
 , 
    cast(null as TEXT) as 
    
    billing_address_country_code
    
 , 
    cast(null as TEXT) as 
    
    billing_address_first_name
    
 , 
    cast(null as TEXT) as 
    
    billing_address_last_name
    
 , 
    cast(null as TEXT) as 
    
    billing_address_latitude
    
 , 
    cast(null as TEXT) as 
    
    billing_address_longitude
    
 , 
    cast(null as TEXT) as 
    
    billing_address_name
    
 , 
    cast(null as TEXT) as 
    
    billing_address_phone
    
 , 
    cast(null as TEXT) as 
    
    billing_address_province
    
 , 
    cast(null as TEXT) as 
    
    billing_address_province_code
    
 , 
    cast(null as TEXT) as 
    
    billing_address_zip
    
 , 
    cast(null as boolean) as 
    
    buyer_accepts_marketing
    
 , 
    cast(null as TEXT) as 
    
    cart_token
    
 , 
    cast(null as timestamp) as 
    
    closed_at
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as integer) as 
    
    customer_id
    
 , 
    cast(null as TEXT) as 
    
    customer_locale
    
 , 
    cast(null as integer) as 
    
    device_id
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    gateway
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    landing_site_base_url
    
 , 
    cast(null as integer) as 
    
    location_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    note
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 , 
    cast(null as TEXT) as 
    
    presentment_currency
    
 , 
    cast(null as TEXT) as 
    
    referring_site
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_address_1
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_address_2
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_city
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_company
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_country
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_country_code
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_first_name
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_last_name
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_latitude
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_longitude
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_name
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_phone
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_province
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_province_code
    
 , 
    cast(null as TEXT) as 
    
    shipping_address_zip
    
 , 
    cast(null as TEXT) as 
    
    source_name
    
 , 
    cast(null as float) as 
    
    subtotal_price
    
 , 
    cast(null as boolean) as 
    
    taxes_included
    
 , 
    cast(null as TEXT) as 
    
    token
    
 , 
    cast(null as float) as 
    
    total_discounts
    
 , 
    cast(null as TEXT) as 
    
    total_duties
    
 , 
    cast(null as float) as 
    
    total_line_items_price
    
 , 
    cast(null as float) as 
    
    total_price
    
 , 
    cast(null as float) as 
    
    total_tax
    
 , 
    cast(null as integer) as 
    
    total_weight
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as integer) as 
    
    user_id
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        _fivetran_deleted as is_deleted,
        abandoned_checkout_url,
        billing_address_address_1,
        billing_address_address_2,
        billing_address_city,
        billing_address_company,
        billing_address_country,
        billing_address_country_code,
        billing_address_first_name,
        billing_address_last_name,
        billing_address_latitude,
        billing_address_longitude,
        billing_address_name,
        billing_address_phone,
        billing_address_province,
        billing_address_province_code,
        billing_address_zip,
        buyer_accepts_marketing as has_buyer_accepted_marketing,
        cart_token,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(closed_at as timestamp) as timestamp)
) as closed_at,
        currency as shop_currency,
        customer_id,
        customer_locale,
        device_id,
        email,
        gateway,
        id as checkout_id,
        landing_site_base_url,
        location_id,
        name,
        note,
        phone,
        presentment_currency,
        referring_site,
        shipping_address_address_1,
        shipping_address_address_2,
        shipping_address_city,
        shipping_address_company,
        shipping_address_country,
        shipping_address_country_code,
        shipping_address_first_name,
        shipping_address_last_name,
        shipping_address_latitude,
        shipping_address_longitude,
        shipping_address_name,
        shipping_address_phone,
        shipping_address_province,
        shipping_address_province_code,
        shipping_address_zip,
        source_name,
        subtotal_price,
        taxes_included as has_taxes_included,
        token,
        total_discounts,
        total_duties,
        total_line_items_price,
        total_price,
        total_tax,
        total_weight,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_at,
        user_id,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation
        
    from fields
)

select *
from final
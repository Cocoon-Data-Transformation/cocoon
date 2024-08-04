with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_tmp

),

fields as (

    select
    
        
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    processed_at
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as numeric(28,6)) as 
    
    user_id
    
 , 
    cast(null as float) as 
    
    total_discounts
    
 , 
    cast(null as TEXT) as 
    
    total_discounts_set
    
 , 
    cast(null as float) as 
    
    total_line_items_price
    
 , 
    cast(null as TEXT) as 
    
    total_line_items_price_set
    
 , 
    cast(null as float) as 
    
    total_price
    
 , 
    cast(null as TEXT) as 
    
    total_price_set
    
 , 
    cast(null as TEXT) as 
    
    total_tax_set
    
 , 
    cast(null as float) as 
    
    total_tax
    
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
    cast(null as numeric(28,6)) as 
    
    total_weight
    
 , 
    cast(null as float) as 
    
    total_tip_received
    
 , 
    cast(null as TEXT) as 
    
    landing_site_base_url
    
 , 
    cast(null as numeric(28,6)) as 
    
    location_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    note
    
 , 
    cast(null as numeric(28,6)) as 
    
    number
    
 , 
    cast(null as numeric(28,6)) as 
    
    order_number
    
 , 
    cast(null as TEXT) as 
    
    cancel_reason
    
 , 
    cast(null as timestamp) as 
    
    cancelled_at
    
 , 
    cast(null as TEXT) as 
    
    cart_token
    
 , 
    cast(null as TEXT) as 
    
    checkout_token
    
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
    cast(null as numeric(28,6)) as 
    
    customer_id
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    financial_status
    
 , 
    cast(null as TEXT) as 
    
    fulfillment_status
    
 , 
    cast(null as TEXT) as 
    
    referring_site
    
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
    cast(null as TEXT) as 
    
    browser_ip
    
 , 
    cast(null as boolean) as 
    
    buyer_accepts_marketing
    
 , 
    cast(null as TEXT) as 
    
    total_shipping_price_set
    
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
    cast(null as boolean) as 
    
    test
    
 , 
    cast(null as TEXT) as 
    
    token
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as integer) as 
    
    checkout_id
    
 , 
    cast(null as TEXT) as 
    
    client_details_user_agent
    
 , 
    cast(null as TEXT) as 
    
    customer_locale
    
 , 
    cast(null as TEXT) as 
    
    order_status_url
    
 , 
    cast(null as TEXT) as 
    
    presentment_currency
    
 , 
    cast(null as boolean) as 
    
    confirmed
    
 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (

    select 
        id as order_id,
        user_id,
        total_discounts,
        total_discounts_set,
        total_line_items_price,
        total_line_items_price_set,
        total_price,
        total_price_set,
        total_tax_set,
        total_tax,
        source_name,
        subtotal_price,
        taxes_included as has_taxes_included,
        total_weight,
        total_tip_received,
        landing_site_base_url,
        location_id,
        name,
        note,
        number,
        order_number,
        cancel_reason,
        cart_token,
        checkout_token,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(cancelled_at as timestamp) as timestamp)
) as cancelled_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(closed_at as timestamp) as timestamp)
) as closed_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(processed_at as timestamp) as timestamp)
) as processed_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_timestamp,
        currency,
        customer_id,
        lower(email) as email,
        financial_status,
        fulfillment_status,
        referring_site,
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
        browser_ip,
        total_shipping_price_set,
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
        token,
        app_id,
        checkout_id,
        client_details_user_agent,
        customer_locale,
        order_status_url,
        presentment_currency,
        test as is_test_order,
        _fivetran_deleted as is_deleted,
        buyer_accepts_marketing as has_buyer_accepted_marketing,
        confirmed as is_confirmed,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

        





    from fields
)

select * 
from final
where not coalesce(is_test_order, false)
and not coalesce(is_deleted, false)
with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__shop_tmp
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
    
    address_1
    
 , 
    cast(null as TEXT) as 
    
    address_2
    
 , 
    cast(null as boolean) as 
    
    checkout_api_supported
    
 , 
    cast(null as TEXT) as 
    
    city
    
 , 
    cast(null as TEXT) as 
    
    cookie_consent_level
    
 , 
    cast(null as TEXT) as 
    
    country
    
 , 
    cast(null as TEXT) as 
    
    country_code
    
 , 
    cast(null as TEXT) as 
    
    country_name
    
 , 
    cast(null as boolean) as 
    
    county_taxes
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as TEXT) as 
    
    customer_email
    
 , 
    cast(null as TEXT) as 
    
    domain
    
 , 
    cast(null as boolean) as 
    
    eligible_for_card_reader_giveaway
    
 , 
    cast(null as boolean) as 
    
    eligible_for_payments
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    enabled_presentment_currencies
    
 , 
    cast(null as TEXT) as 
    
    google_apps_domain
    
 , 
    cast(null as boolean) as 
    
    google_apps_login_enabled
    
 , 
    cast(null as boolean) as 
    
    has_discounts
    
 , 
    cast(null as boolean) as 
    
    has_gift_cards
    
 , 
    cast(null as boolean) as 
    
    has_storefront
    
 , 
    cast(null as TEXT) as 
    
    iana_timezone
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as float) as 
    
    latitude
    
 , 
    cast(null as float) as 
    
    longitude
    
 , 
    cast(null as TEXT) as 
    
    money_format
    
 , 
    cast(null as TEXT) as 
    
    money_in_emails_format
    
 , 
    cast(null as TEXT) as 
    
    money_with_currency_format
    
 , 
    cast(null as TEXT) as 
    
    money_with_currency_in_emails_format
    
 , 
    cast(null as TEXT) as 
    
    myshopify_domain
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as boolean) as 
    
    password_enabled
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 , 
    cast(null as TEXT) as 
    
    plan_display_name
    
 , 
    cast(null as TEXT) as 
    
    plan_name
    
 , 
    cast(null as boolean) as 
    
    pre_launch_enabled
    
 , 
    cast(null as TEXT) as 
    
    primary_locale
    
 , 
    cast(null as TEXT) as 
    
    province
    
 , 
    cast(null as TEXT) as 
    
    province_code
    
 , 
    cast(null as boolean) as 
    
    requires_extra_payments_agreement
    
 , 
    cast(null as boolean) as 
    
    setup_required
    
 , 
    cast(null as TEXT) as 
    
    shop_owner
    
 , 
    cast(null as TEXT) as 
    
    source
    
 , 
    cast(null as boolean) as 
    
    tax_shipping
    
 , 
    cast(null as boolean) as 
    
    taxes_included
    
 , 
    cast(null as TEXT) as 
    
    timezone
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    weight_unit
    
 , 
    cast(null as TEXT) as 
    
    zip
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as shop_id,
        name,
        _fivetran_deleted as is_deleted,
        address_1,
        address_2,
        city,
        province,
        province_code,
        country,
        country_code,
        country_name,
        zip,
        latitude,
        longitude,
        case when county_taxes is null then false else county_taxes end as has_county_taxes,
        currency,
        enabled_presentment_currencies,
        customer_email,
        email,
        domain,
        phone,
        timezone,
        iana_timezone,
        primary_locale,
        weight_unit,
        myshopify_domain,
        cookie_consent_level,
        shop_owner,
        source,
        tax_shipping as has_shipping_taxes,
        case when taxes_included is null then false else taxes_included end as has_taxes_included_in_price,
        has_discounts,
        has_gift_cards,
        has_storefront,
        checkout_api_supported as has_checkout_api_supported,
        eligible_for_card_reader_giveaway as is_eligible_for_card_reader_giveaway,
        eligible_for_payments as is_eligible_for_payments,
        google_apps_domain,
        case when google_apps_login_enabled is null then false else google_apps_login_enabled end as is_google_apps_login_enabled,
        money_format,
        money_in_emails_format,
        money_with_currency_format,
        money_with_currency_in_emails_format,
        plan_display_name,
        plan_name,
        password_enabled as is_password_enabled,
        pre_launch_enabled as is_pre_launch_enabled,
        requires_extra_payments_agreement as is_extra_payments_agreement_required,
        setup_required as is_setup_required,
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
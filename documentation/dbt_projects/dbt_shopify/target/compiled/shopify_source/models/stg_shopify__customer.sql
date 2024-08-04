with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__customer_tmp

),

fields as (

    select
    
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    accepts_marketing
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as numeric(28,6)) as 
    
    default_address_id
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as TEXT) as 
    
    first_name
    
 , 
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    last_name
    
 , 
    cast(null as numeric(28,6)) as 
    
    orders_count
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 , 
    cast(null as TEXT) as 
    
    state
    
 , 
    cast(null as boolean) as 
    
    tax_exempt
    
 , 
    cast(null as float) as 
    
    total_spent
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as boolean) as 
    
    verified_email
    
 , 
    cast(null as timestamp) as 
    
    email_marketing_consent_consent_updated_at
    
 , 
    cast(null as TEXT) as 
    
    email_marketing_consent_opt_in_level
    
 , 
    cast(null as TEXT) as 
    
    email_marketing_consent_state
    
 , 
    cast(null as TEXT) as 
    
    note
    
 , 
    cast(null as timestamp) as 
    
    accepts_marketing_updated_at
    
 , 
    cast(null as TEXT) as 
    
    marketing_opt_in_level
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (

    select 
        id as customer_id,
        lower(email) as email,
        first_name,
        last_name,
        orders_count,
        default_address_id,
        phone,
        lower(state) as account_state,
        tax_exempt as is_tax_exempt,
        total_spent,
        verified_email as is_verified_email,
        note,
        currency,
        case 
            when email_marketing_consent_state is null then
                case 
                    when accepts_marketing is null then null
                    when accepts_marketing then 'subscribed (legacy)' 
                    else 'not_subscribed (legacy)' end
            else lower(email_marketing_consent_state) end as marketing_consent_state,
        lower(coalesce(email_marketing_consent_opt_in_level, marketing_opt_in_level)) as marketing_opt_in_level,

        convert_timezone('UTC', 'UTC',
    cast(cast(coalesce(accepts_marketing_updated_at, email_marketing_consent_consent_updated_at) as timestamp) as timestamp)
) as marketing_consent_updated_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_timestamp,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation
        
        





    from fields
    
)

select * 
from final
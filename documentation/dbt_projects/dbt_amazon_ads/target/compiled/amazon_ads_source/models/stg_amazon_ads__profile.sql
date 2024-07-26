

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__profile_tmp
),

fields as (

    select
        
    cast(null as INT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    account_marketplace_string_id
    
 , 
    cast(null as TEXT) as 
    
    account_name
    
 , 
    cast(null as TEXT) as 
    
    account_sub_type
    
 , 
    cast(null as TEXT) as 
    
    account_type
    
 , 
    cast(null as BOOLEAN) as 
    
    account_valid_payment_method
    
 , 
    cast(null as TEXT) as 
    
    country_code
    
 , 
    cast(null as TEXT) as 
    
    currency_code
    
 , 
    cast(null as INT) as 
    
    daily_budget
    
 , 
    cast(null as TEXT) as 
    
    timezone
    
 , 
    cast(null as BOOLEAN) as 
    
    _fivetran_deleted
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as TEXT) as profile_id,
        cast(account_id as TEXT) as account_id,
        account_marketplace_string_id,
        account_name,
        account_sub_type,
        account_type,
        account_valid_payment_method,
        country_code,
        currency_code,
        daily_budget,
        timezone,
        _fivetran_deleted
    from fields
)

select *
from final


with base as (

    select *
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__advertiser_tmp
), 

fields as (

    select
        
    cast(null as TEXT) as 
    
    address
    
 , 
    cast(null as float) as 
    
    balance
    
 , 
    cast(null as TEXT) as 
    
    cellphone_number
    
 , 
    cast(null as TEXT) as 
    
    company
    
 , 
    cast(null as TEXT) as 
    
    contacter
    
 , 
    cast(null as TEXT) as 
    
    country
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as TEXT) as 
    
    description
    
 , 
    cast(null as TEXT) as 
    
    email
    
 , 
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    industry
    
 , 
    cast(null as TEXT) as 
    
    language
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    phone_number
    
 , 
    cast(null as TEXT) as 
    
    telephone
    
 , 
    cast(null as TEXT) as 
    
    telephone_number
    
 , 
    cast(null as TEXT) as 
    
    timezone
    
 



    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation,   
        id as advertiser_id, 
        address, 
        balance, 
        company, 
        contacter, 
        country, 
        currency, 
        description, 
        email, 
        industry, 
        language,
        name as advertiser_name, 
        coalesce(cellphone_number, phone_number) as cellphone_number, 
        coalesce(telephone_number, telephone) as telephone_number,
        timezone
    from fields
)

select *
from final
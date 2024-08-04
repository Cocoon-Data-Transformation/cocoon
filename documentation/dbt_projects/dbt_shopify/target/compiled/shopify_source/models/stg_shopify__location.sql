with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__location_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    active
    
 , 
    cast(null as TEXT) as 
    
    address_1
    
 , 
    cast(null as TEXT) as 
    
    address_2
    
 , 
    cast(null as TEXT) as 
    
    city
    
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
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    legacy
    
 , 
    cast(null as TEXT) as 
    
    localized_country_name
    
 , 
    cast(null as TEXT) as 
    
    localized_province_name
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    phone
    
 , 
    cast(null as TEXT) as 
    
    province
    
 , 
    cast(null as TEXT) as 
    
    province_code
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    zip
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as location_id,
        name,
        _fivetran_deleted as is_deleted,
        active as is_active,
        address_1,
        address_2,
        city,
        country,
        country_code,
        country_name,
        legacy as is_legacy,
        localized_country_name,
        localized_province_name,
        phone,
        province,
        province_code,
        zip,
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
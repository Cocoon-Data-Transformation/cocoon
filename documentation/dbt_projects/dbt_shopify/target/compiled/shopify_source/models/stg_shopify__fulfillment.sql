with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__fulfillment_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    location_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    order_id
    
 , 
    cast(null as TEXT) as 
    
    service
    
 , 
    cast(null as TEXT) as 
    
    shipment_status
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    tracking_company
    
 , 
    cast(null as TEXT) as 
    
    tracking_number
    
 , 
    cast(null as TEXT) as 
    
    tracking_numbers
    
 , 
    cast(null as TEXT) as 
    
    tracking_urls
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as fulfillment_id,
        location_id,
        order_id,
        name,
        service,
        shipment_status,
        lower(status) as status,
        tracking_company,
        tracking_number,
        tracking_numbers,
        tracking_urls,
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


with base as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__organization_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    payment_model
    
 , 
    cast(null as TEXT) as 
    
    time_zone
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as organization_id,
        currency,
        payment_model,
        name as organization_name,
        time_zone
    from fields
)

select * 
from final


with base as (

    select * 
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__advertiser_history_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    country
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    owner_user_id
    
 , 
    cast(null as TEXT) as 
    
    owner_username
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as advertiser_permissions , 
    cast(null as timestamp) as 
    
    updated_time
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as advertiser_id,
        name as advertiser_name,
        country,
        created_time as created_at,
        currency as currency_code,
        owner_user_id,
        owner_username,
        advertiser_permissions, -- permissions was renamed in macro
        updated_time as updated_at,
        row_number() over (partition by source_relation, id order by updated_time desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
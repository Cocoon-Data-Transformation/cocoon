

with base as (

    select * 
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__account_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    attribution_type
    
 , 
    cast(null as TEXT) as 
    
    click_attribution_window
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    time_zone_id
    
 , 
    cast(null as TEXT) as 
    
    view_attribution_window
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        attribution_type,
        click_attribution_window,
        cast(created_at as timestamp) as created_at,
        currency,
        id as account_id,
        status,
        time_zone_id,
        view_attribution_window
    from fields
)

select *
from final


with base as (

    select * 
    from TEST.PUBLIC_google_ads_source.stg_google_ads__account_history_tmp

),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    auto_tagging_enabled
    
 , 
    cast(null as TEXT) as 
    
    currency_code
    
 , 
    cast(null as TEXT) as 
    
    descriptive_name
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    time_zone
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as boolean) as 
    
    _fivetran_active
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as account_id,
        updated_at,
        currency_code,
        auto_tagging_enabled,
        time_zone,
        descriptive_name as account_name,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_most_recent_record
    from fields
    where coalesce(_fivetran_active, true)
)

select * 
from final
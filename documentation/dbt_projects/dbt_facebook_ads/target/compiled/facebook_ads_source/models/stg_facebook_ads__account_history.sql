

with base as (

    select * 
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__account_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    account_status
    
 , 
    cast(null as TEXT) as 
    
    business_country_code
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as TEXT) as 
    
    timezone_name
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as bigint) as account_id,
        _fivetran_synced,
        name as account_name,
        account_status,
        business_country_code,
        created_time as created_at,
        currency,
        timezone_name,
        case when id is null and _fivetran_synced is null 
            then row_number() over (partition by source_relation order by source_relation)
        else row_number() over (partition by source_relation, id order by _fivetran_synced desc) end = 1 as is_most_recent_record
    from fields

)

select * 
from final


with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__account_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as timestamp) as 
    
    last_modified_time
    
 , 
    cast(null as TEXT) as 
    
    time_zone
    
 , 
    cast(null as TEXT) as 
    
    currency_code
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as account_id,
        name as account_name,
        last_modified_time as modified_at,
        time_zone,
        currency_code,
        row_number() over (partition by source_relation, id order by last_modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
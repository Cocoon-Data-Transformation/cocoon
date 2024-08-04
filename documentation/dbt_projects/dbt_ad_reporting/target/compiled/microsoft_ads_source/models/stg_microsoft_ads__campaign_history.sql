

with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__campaign_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as timestamp) as 
    
    modified_time
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as TEXT) as 
    
    time_zone
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as campaign_id,
        name as campaign_name,
        account_id,
        modified_time as modified_at,
        type,
        time_zone,
        status,
        row_number() over (partition by source_relation, id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final


with base as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__campaign_history_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    end_time
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    modification_time
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    organization_id
    
 , 
    cast(null as timestamp) as 
    
    start_time
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation,
        modification_time as modified_at,
        organization_id,
        name as campaign_name,
        id as campaign_id,
        status as campaign_status,
        start_time as start_at,
        end_time as end_at,
        row_number() over (partition by source_relation, id order by modification_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final


with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_group_history_tmp
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
    
    campaign_id
    
 , 
    cast(null as timestamp) as 
    
    modified_time
    
 , 
    cast(null as date) as 
    
    start_date
    
 , 
    cast(null as date) as 
    
    end_date
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as ad_group_id,
        name as ad_group_name,
        campaign_id,
        modified_time as modified_at,
        start_date,
        end_date,
        status,
        row_number() over (partition by source_relation, id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
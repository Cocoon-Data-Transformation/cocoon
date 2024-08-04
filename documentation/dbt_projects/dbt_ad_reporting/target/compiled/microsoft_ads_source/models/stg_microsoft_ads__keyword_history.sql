

with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__keyword_history_tmp
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
    
    modified_time
    
 , 
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    match_type
    
 , 
    cast(null as TEXT) as 
    
    status
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as keyword_id,
        name as keyword_name,
        modified_time as modified_at,
        ad_group_id,
        match_type,
        status,
        row_number() over (partition by source_relation, id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
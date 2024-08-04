

with base as (

    select * 
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__creative_url_tag_history_tmp

),

fields as (

    select
        
    cast(null as TEXT) as 
    
    creative_id
    
 , 
    cast(null as TEXT) as 
    
    key
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    value
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation,  
        creative_id,
        key as param_key,
        value as param_value,
        cast (updated_at as timestamp) as updated_at,
        row_number() over (partition by source_relation, creative_id, key order by updated_at desc) =1 as is_most_recent_record
    from fields
)

select * 
from final
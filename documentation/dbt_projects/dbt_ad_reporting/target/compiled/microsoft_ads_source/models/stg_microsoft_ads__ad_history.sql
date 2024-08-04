

with base as (

    select * 
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    title_part_1
    
 , 
    cast(null as TEXT) as 
    
    final_url
    
 , 
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as timestamp) as 
    
    modified_time
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    type
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as ad_id,
        title_part_1 as ad_name,
        final_url,
        ad_group_id,
        modified_time as modified_at,
        status,
        type,
        row_number() over (partition by source_relation, id order by modified_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
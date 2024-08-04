

with base as (

    select * 
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__ad_history_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    updated_time
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as integer) as 
    
    ad_set_id
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    creative_id
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        updated_time as updated_at,
        cast(id as bigint) as ad_id,
        name as ad_name,
        cast(account_id as bigint) as account_id,
        cast(ad_set_id as bigint) as ad_set_id,   
        cast(campaign_id as bigint) as campaign_id,
        cast(creative_id as bigint) as creative_id,
        case when id is null and updated_time is null 
            then row_number() over (partition by source_relation order by source_relation)
        else row_number() over (partition by source_relation, id order by updated_time desc) end = 1 as is_most_recent_record
    from fields
)

select * 
from final
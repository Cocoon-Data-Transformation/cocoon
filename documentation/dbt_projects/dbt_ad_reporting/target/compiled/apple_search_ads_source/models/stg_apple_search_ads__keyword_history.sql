

with base as (

    select * 
    from TEST.PUBLIC_apple_search_ads_source.stg_apple_search_ads__keyword_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    bid_amount
    
 , 
    cast(null as TEXT) as 
    
    bid_currency
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    match_type
    
 , 
    cast(null as timestamp) as 
    
    modification_time
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    text
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        modification_time as modified_at,
        campaign_id,
        ad_group_id,
        id as keyword_id,
        bid_amount, 
        bid_currency,
        match_type,
        status as keyword_status,
        text as keyword_text,
        row_number() over (partition by source_relation, id order by modification_time desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
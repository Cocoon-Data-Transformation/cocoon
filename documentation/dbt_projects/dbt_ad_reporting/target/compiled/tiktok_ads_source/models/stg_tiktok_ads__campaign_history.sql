

with base as (

    select *
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__campaign_history_tmp
), 

fields as (

    select
        
    cast(null as numeric(28,6)) as 
    
    advertiser_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    campaign_name
    
 , 
    cast(null as TEXT) as 
    
    campaign_type
    
 , 
    cast(null as TEXT) as 
    
    split_test_variable
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
), 

final as (

    select
        source_relation,   
        campaign_id,
        cast(updated_at as timestamp) as updated_at,
        advertiser_id,
        campaign_name,
        campaign_type,
        split_test_variable,
        row_number() over (partition by source_relation, campaign_id order by updated_at desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
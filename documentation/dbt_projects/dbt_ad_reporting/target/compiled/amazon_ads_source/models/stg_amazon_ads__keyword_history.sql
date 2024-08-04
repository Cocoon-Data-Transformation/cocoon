

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__keyword_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as float) as 
    
    bid
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as timestamp) as 
    
    creation_date
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    keyword_text
    
 , 
    cast(null as timestamp) as 
    
    last_updated_date
    
 , 
    cast(null as TEXT) as 
    
    match_type
    
 , 
    cast(null as TEXT) as 
    
    native_language_keyword
    
 , 
    cast(null as TEXT) as 
    
    serving_status
    
 , 
    cast(null as TEXT) as 
    
    state
    
 , 
    cast(null as TEXT) as 
    
    native_language_locale
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as TEXT) as keyword_id,
        cast(ad_group_id as TEXT) as ad_group_id,
        bid,
        cast(campaign_id as TEXT) as campaign_id,
        creation_date,
        keyword_text,
        last_updated_date,
        match_type,
        native_language_keyword,
        serving_status,
        state,
        native_language_locale,
        row_number() over (partition by source_relation, id order by last_updated_date desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
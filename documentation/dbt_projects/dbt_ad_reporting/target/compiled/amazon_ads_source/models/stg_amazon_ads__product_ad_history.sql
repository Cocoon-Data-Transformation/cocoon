

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__product_ad_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    asin
    
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
    cast(null as timestamp) as 
    
    last_updated_date
    
 , 
    cast(null as TEXT) as 
    
    serving_status
    
 , 
    cast(null as TEXT) as 
    
    sku
    
 , 
    cast(null as TEXT) as 
    
    state
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as TEXT) as ad_id,
        cast(ad_group_id as TEXT) as ad_group_id,
        asin,
        cast(campaign_id as TEXT) as campaign_id,
        creation_date,
        last_updated_date,
        serving_status,
        sku,
        state,
        row_number() over (partition by source_relation, id order by last_updated_date desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
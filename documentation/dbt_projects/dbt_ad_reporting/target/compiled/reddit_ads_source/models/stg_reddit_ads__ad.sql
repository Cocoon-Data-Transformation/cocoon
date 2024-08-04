

with base as (

    select * 
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    click_url
    
 , 
    cast(null as TEXT) as 
    
    configured_status
    
 , 
    cast(null as TEXT) as 
    
    effective_status
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    is_processing
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    post_id
    
 , 
    cast(null as TEXT) as 
    
    post_url
    
 , 
    cast(null as TEXT) as 
    
    rejection_reason
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation,
        account_id,
        ad_group_id,
        campaign_id,
        click_url,
        configured_status,
        effective_status,
        id as ad_id,
        is_processing,
        name as ad_name,
        post_id,
        post_url,
        rejection_reason
    from fields
)

select *
from final
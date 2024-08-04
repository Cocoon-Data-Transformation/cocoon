

with base as (

    select * 
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__campaign_tmp
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
    
    configured_status
    
 , 
    cast(null as TEXT) as 
    
    effective_status
    
 , 
    cast(null as TEXT) as 
    
    funding_instrument_id
    
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
    
    objective
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        account_id,
        configured_status,
        effective_status,
        funding_instrument_id,
        id as campaign_id,
        is_processing,
        name as campaign_name,
        objective
    from fields
)

select *
from final


with base as (

    select * 
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__keyword_history_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    _fivetran_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    advertiser_id
    
 , 
    cast(null as boolean) as 
    
    archived
    
 , 
    cast(null as integer) as 
    
    bid
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    match_type
    
 , 
    cast(null as TEXT) as 
    
    parent_type
    
 , 
    cast(null as TEXT) as 
    
    value
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation,
        id as keyword_id,
        value as keyword_value,
        _fivetran_id,
        _fivetran_synced,
        ad_group_id,
        advertiser_id,
        archived,
        bid,
        campaign_id,
        match_type,
        parent_type,
        row_number() over (partition by source_relation, id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from fields
)

select *
from final


with base as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__ad_group_history_tmp
), 

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as timestamp) as 
    
    end_time
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    ad_account_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    pacing_delivery_type
    
 , 
    cast(null as TEXT) as 
    
    placement_group
    
 , 
    cast(null as timestamp) as 
    
    start_time
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    summary_status
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation,
        id as ad_group_id,
        name as ad_group_name,
        status as ad_group_status,
        ad_account_id as advertiser_id,
        _fivetran_synced,
        campaign_id,
        created_time as created_at,
        end_time,
        pacing_delivery_type,
        placement_group,
        start_time,
        summary_status,
        row_number() over (partition by source_relation, id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from fields
)

select *
from final
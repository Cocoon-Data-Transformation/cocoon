

with base as (

    select * 
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_group_history_tmp

),

fields as (

    select
        
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    campaign_name
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as boolean) as 
    
    _fivetran_active
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(id as TEXT) as ad_group_id,
        updated_at,
        type as ad_group_type, 
        campaign_id, 
        campaign_name, 
        name as ad_group_name, 
        status as ad_group_status,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_most_recent_record
    from fields
    where coalesce(_fivetran_active, true)
)

select * 
from final
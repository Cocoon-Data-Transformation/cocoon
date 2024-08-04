

with base as (

    select * 
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_group_criterion_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as integer) as 
    
    base_campaign_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    keyword_match_type
    
 , 
    cast(null as TEXT) as 
    
    keyword_text
    
 , 
    cast(null as boolean) as 
    
    _fivetran_active
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        id as criterion_id,
        cast(ad_group_id as TEXT) as ad_group_id,
        base_campaign_id,
        updated_at,
        type,
        status,
        keyword_match_type,
        keyword_text,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_most_recent_record
    from fields
    where coalesce(_fivetran_active, true)
)

select *
from final


with base as (

    select * 
    from TEST.PUBLIC_google_ads_source.stg_google_ads__campaign_history_tmp

),

fields as (

    select
        
    cast(null as TEXT) as 
    
    advertising_channel_subtype
    
 , 
    cast(null as TEXT) as 
    
    advertising_channel_type
    
 , 
    cast(null as integer) as 
    
    customer_id
    
 , 
    cast(null as TEXT) as 
    
    end_date
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    serving_status
    
 , 
    cast(null as TEXT) as 
    
    start_date
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    tracking_url_template
    
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
        id as campaign_id, 
        updated_at,
        name as campaign_name,
        customer_id as account_id,
        advertising_channel_type,
        advertising_channel_subtype,
        start_date,
        end_date,
        serving_status,
        status,
        tracking_url_template,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_most_recent_record
    from fields
    where coalesce(_fivetran_active, true)
)

select * 
from final
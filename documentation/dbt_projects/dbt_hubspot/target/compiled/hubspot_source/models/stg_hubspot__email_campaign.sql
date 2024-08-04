

with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_campaign_tmp

), macro as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    app_id
    
 , 
    cast(null as TEXT) as 
    
    app_name
    
 , 
    cast(null as integer) as 
    
    content_id
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as integer) as 
    
    num_included
    
 , 
    cast(null as integer) as 
    
    num_queued
    
 , 
    cast(null as TEXT) as 
    
    sub_type
    
 , 
    cast(null as TEXT) as 
    
    subject
    
 , 
    cast(null as TEXT) as 
    
    type
    
 


    from base

), fields as (

    select
        cast(_fivetran_synced as timestamp) as _fivetran_synced,
        app_id,
        app_name,
        content_id,
        id as email_campaign_id,
        name as email_campaign_name,
        num_included,
        num_queued,
        sub_type as email_campaign_sub_type,
        subject as email_campaign_subject,
        type as email_campaign_type
    from macro
    
)

select *
from fields
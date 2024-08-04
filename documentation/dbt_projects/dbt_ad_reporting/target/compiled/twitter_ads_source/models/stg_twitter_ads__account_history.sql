

with source as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__account_history_tmp

),

fields as (

    select
    
        
    cast(null as TEXT) as 
    
    approval_status
    
 , 
    cast(null as TEXT) as 
    
    business_id
    
 , 
    cast(null as TEXT) as 
    
    business_name
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as boolean) as 
    
    deleted
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    industry_type
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    salt
    
 , 
    cast(null as TEXT) as 
    
    timezone
    
 , 
    cast(null as timestamp) as 
    
    timezone_switch_at
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    
        


, cast('' as TEXT) as source_relation




    from source

), 

final as (

    select
        source_relation,
        approval_status,
        business_id,
        business_name,
        created_at as created_timestamp,
        deleted as is_deleted,
        id as account_id,
        industry_type,
        name,
        salt,
        timezone,
        timezone_switch_at as timezone_switched_timestamp,
        updated_at as updated_timestamp,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_latest_version
    
    from fields 
)

select * from final
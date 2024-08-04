

with source as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__promoted_tweet_history_tmp

),

fields as (

    select
    
        
    cast(null as TEXT) as 
    
    approval_status
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as boolean) as 
    
    deleted
    
 , 
    cast(null as TEXT) as 
    
    entity_status
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    line_item_id
    
 , 
    cast(null as TEXT) as 
    
    tweet_id
    
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
        created_at as created_timestamp,
        deleted as is_deleted,
        entity_status,
        id as promoted_tweet_id,
        line_item_id,
        tweet_id,
        updated_at as updated_timestamp,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_latest_version
    from fields 
)

select * from final


with base as (

    select * 
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__tweet_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    full_text
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    lang
    
 , 
    cast(null as TEXT) as 
    
    name
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        account_id,
        id as tweet_id,
        name,
        full_text,
        lang as language

    from fields
)

select *
from final
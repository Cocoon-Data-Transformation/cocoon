

with source as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__promoted_tweet_report_tmp

),

renamed as (

    select
    
        
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as integer) as 
    
    billed_charge_local_micro
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as TEXT) as 
    
    placement
    
 , 
    cast(null as TEXT) as 
    
    promoted_tweet_id
    
 , 
    cast(null as integer) as 
    
    url_clicks
    
 


    
        


, cast('' as TEXT) as source_relation




    from source

), spend_calc as (

    select
        source_relation,
        date_trunc('day', date) as date_day,
        account_id,
        promoted_tweet_id,
        placement,
        clicks as clicks,
        impressions as impressions,
        billed_charge_local_micro as spend_micro,
        round(billed_charge_local_micro / 1000000.0,2) as spend,
        url_clicks as url_clicks

        




    
    from renamed

)

select * from spend_calc
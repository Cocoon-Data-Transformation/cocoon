

with base as (

    select * 
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__campaign_hourly_report_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    attachment_quartile_1
    
 , 
    cast(null as integer) as 
    
    attachment_quartile_2
    
 , 
    cast(null as integer) as 
    
    attachment_quartile_3
    
 , 
    cast(null as integer) as 
    
    attachment_total_view_time_millis
    
 , 
    cast(null as integer) as 
    
    attachment_view_completion
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as integer) as 
    
    quartile_1
    
 , 
    cast(null as integer) as 
    
    quartile_2
    
 , 
    cast(null as integer) as 
    
    quartile_3
    
 , 
    cast(null as integer) as 
    
    saves
    
 , 
    cast(null as integer) as 
    
    screen_time_millis
    
 , 
    cast(null as integer) as 
    
    shares
    
 , 
    cast(null as integer) as 
    
    spend
    
 , 
    cast(null as integer) as 
    
    swipes
    
 , 
    cast(null as integer) as 
    
    video_views
    
 , 
    cast(null as integer) as 
    
    view_completion
    
 , 
    cast(null as integer) as 
    
    view_time_millis
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        campaign_id,
        cast (date as timestamp) as date_hour,
        attachment_quartile_1,
        attachment_quartile_2,
        attachment_quartile_3,
        (attachment_total_view_time_millis / 1000000.0) as attachment_total_view_time,
        attachment_view_completion,
        quartile_1,
        quartile_2,
        quartile_3,
        saves,
        shares,
        (screen_time_millis / 1000000.0) as screen_time,
        video_views,
        view_completion,
        (view_time_millis / 1000000.0) as view_time,
        impressions,
        (spend / 1000000.0) as spend,
        swipes

        




    
    from fields
)

select *
from final
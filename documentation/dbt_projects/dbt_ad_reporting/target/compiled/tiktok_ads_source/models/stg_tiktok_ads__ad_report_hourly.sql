

with base as (

    select *
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__ad_report_hourly_tmp
), 

fields as (

    select
        
    cast(null as numeric(28,6)) as 
    
    ad_id
    
 , 
    cast(null as float) as 
    
    average_video_play
    
 , 
    cast(null as float) as 
    
    average_video_play_per_user
    
 , 
    cast(null as numeric(28,6)) as 
    
    clicks
    
 , 
    cast(null as numeric(28,6)) as 
    
    comments
    
 , 
    cast(null as numeric(28,6)) as 
    
    conversion
    
 , 
    cast(null as float) as 
    
    conversion_rate
    
 , 
    cast(null as float) as 
    
    cost_per_conversion
    
 , 
    cast(null as float) as 
    
    cpc
    
 , 
    cast(null as float) as 
    
    cpm
    
 , 
    cast(null as float) as 
    
    ctr
    
 , 
    cast(null as numeric(28,6)) as 
    
    follows
    
 , 
    cast(null as numeric(28,6)) as 
    
    impressions
    
 , 
    cast(null as numeric(28,6)) as 
    
    likes
    
 , 
    cast(null as numeric(28,6)) as 
    
    profile_visits
    
 , 
    cast(null as numeric(28,6)) as 
    
    reach
    
 , 
    cast(null as numeric(28,6)) as 
    
    shares
    
 , 
    cast(null as numeric(28,6)) as 
    
    spend
    
 , 
    cast(null as timestamp) as 
    
    stat_time_hour
    
 , 
    cast(null as numeric(28,6)) as 
    
    video_play_actions
    
 , 
    cast(null as numeric(28,6)) as 
    
    video_views_p_25
    
 , 
    cast(null as numeric(28,6)) as 
    
    video_views_p_50
    
 , 
    cast(null as numeric(28,6)) as 
    
    video_views_p_75
    
 , 
    cast(null as numeric(28,6)) as 
    
    video_watched_2_s
    
 , 
    cast(null as numeric(28,6)) as 
    
    video_watched_6_s
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
), 

final as (

    select
        source_relation,  
        ad_id, 
        cast(stat_time_hour as timestamp) as stat_time_hour, 
        cpc, 
        cpm, 
        ctr, 
        impressions, 
        clicks, 
        spend, 
        reach, 
        conversion, 
        cost_per_conversion, 
        conversion_rate, 
        likes, 
        comments, 
        shares, 
        profile_visits,
        follows, 
        video_play_actions, 
        video_watched_2_s, 
        video_watched_6_s, 
        video_views_p_25, 
        video_views_p_50,
        video_views_p_75,  
        average_video_play, 
        average_video_play_per_user

        




    from fields
)

select * 
from final
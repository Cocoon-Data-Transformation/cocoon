

with base as (

    select *
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__ad_group_history_tmp
), 

fields as (

    select
        
    cast(null as numeric(28,6)) as 
    
    action_days
    
 , 
    cast(null as numeric(28,6)) as 
    
    adgroup_id
    
 , 
    cast(null as TEXT) as 
    
    adgroup_name
    
 , 
    cast(null as numeric(28,6)) as 
    
    advertiser_id
    
 , 
    cast(null as TEXT) as 
    
    audience_type
    
 , 
    cast(null as float) as 
    
    budget
    
 , 
    cast(null as numeric(28,6)) as 
    
    campaign_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    category
    
 , 
    cast(null as TEXT) as 
    
    display_name
    
 , 
    cast(null as numeric(28,6)) as 
    
    frequency
    
 , 
    cast(null as numeric(28,6)) as 
    
    frequency_schedule
    
 , 
    cast(null as TEXT) as 
    
    gender
    
 , 
    cast(null as TEXT) as 
    
    landing_page_url
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    interest_category_v_2
    
 , 
    cast(null as TEXT) as 
    
    action_categories
    
 , 
    cast(null as TEXT) as 
    
    age
    
 , 
    cast(null as TEXT) as 
    
    age_groups
    
 , 
    cast(null as TEXT) as 
    
    languages
    
 



    
        


, cast('' as TEXT) as source_relation




    from base
), 

final as (

    select
        source_relation,
        adgroup_id as ad_group_id,
        cast(updated_at as timestamp) as updated_at,
        advertiser_id,
        campaign_id,
        action_days,
        action_categories,
        adgroup_name as ad_group_name,
        coalesce(age_groups, age) as age_groups,
        audience_type,
        budget,
        category,
        display_name,
        interest_category_v_2 as interest_category,
        frequency,
        frequency_schedule,
        gender,
        languages, 
        landing_page_url,
        row_number() over (partition by source_relation, adgroup_id order by updated_at desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
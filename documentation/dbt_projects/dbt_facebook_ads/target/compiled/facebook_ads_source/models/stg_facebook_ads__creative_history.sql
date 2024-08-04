

with base as (

    select * 
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__creative_history_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    _fivetran_id
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as integer) as 
    
    account_id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    page_link
    
 , 
    cast(null as TEXT) as 
    
    template_page_link
    
 , 
    cast(null as TEXT) as 
    
    url_tags
    
 , 
    cast(null as TEXT) as 
    
    asset_feed_spec_link_urls
    
 , 
    cast(null as TEXT) as 
    
    object_story_link_data_child_attachments
    
 , 
    cast(null as TEXT) as 
    
    object_story_link_data_caption
    
 , 
    cast(null as TEXT) as 
    
    object_story_link_data_description
    
 , 
    cast(null as TEXT) as 
    
    object_story_link_data_link
    
 , 
    cast(null as TEXT) as 
    
    object_story_link_data_message
    
 , 
    cast(null as TEXT) as 
    
    template_app_link_spec_android
    
 , 
    cast(null as TEXT) as 
    
    template_app_link_spec_ios
    
 , 
    cast(null as TEXT) as 
    
    template_app_link_spec_ipad
    
 , 
    cast(null as TEXT) as 
    
    template_app_link_spec_iphone
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        _fivetran_id,
        _fivetran_synced,
        cast(id as bigint) as creative_id,
        cast(account_id as bigint) as account_id,
        name as creative_name,
        page_link,
        template_page_link,
        url_tags,
        asset_feed_spec_link_urls,
        object_story_link_data_child_attachments,
        object_story_link_data_caption, 
        object_story_link_data_description, 
        object_story_link_data_link, 
        object_story_link_data_message,
        template_app_link_spec_ios,
        template_app_link_spec_ipad,
        template_app_link_spec_android,
        template_app_link_spec_iphone,
        case when id is null and _fivetran_synced is null 
            then row_number() over (partition by source_relation order by source_relation)
        else row_number() over (partition by source_relation, id order by _fivetran_synced desc) end = 1 as is_most_recent_record
    from fields
)

select * 
from final
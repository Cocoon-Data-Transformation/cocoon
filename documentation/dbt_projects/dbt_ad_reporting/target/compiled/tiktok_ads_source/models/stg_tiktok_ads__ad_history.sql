

with base as (

    select *
    from TEST.PUBLIC_stg_tiktok_ads.stg_tiktok_ads__ad_history_tmp
), 

fields as (

    select
        
    cast(null as numeric(28,6)) as 
    
    ad_id
    
 , 
    cast(null as TEXT) as 
    
    ad_name
    
 , 
    cast(null as numeric(28,6)) as 
    
    adgroup_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    advertiser_id
    
 , 
    cast(null as TEXT) as 
    
    call_to_action
    
 , 
    cast(null as numeric(28,6)) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    click_tracking_url
    
 , 
    cast(null as TEXT) as 
    
    impression_tracking_url
    
 , 
    cast(null as TEXT) as 
    
    landing_page_url
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 



    
        


, cast('' as TEXT) as source_relation




    from base
), 

final as (

    select
        source_relation,  
        ad_id,
        cast(updated_at as timestamp) as updated_at,
        adgroup_id as ad_group_id,
        advertiser_id,
        campaign_id,
        ad_name,
        call_to_action,
        click_tracking_url,
        impression_tracking_url,
        

    split_part(
        landing_page_url,
        '?',
        1
        )

 as base_url,
        
    
        try_cast(

    split_part(
        

    split_part(
        

    replace(
        

    replace(
        

    replace(
        landing_page_url,
        'android-app://',
        ''
    )


,
        'http://',
        ''
    )


,
        'https://',
        ''
    )


,
        '/',
        1
        )

,
        '?',
        1
        )

 as TEXT)
     as url_host,
        '/' || 
    
        try_cast(

    split_part(
        

    case when 

    length(
        

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )



    )-coalesce(
            nullif(

    position(
        '/' in 

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )



    ), 0),
            

    position(
        '?' in 

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )



    ) - 1
            ) = 0
        then ''
    else
        right(
            

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )


,
            

    length(
        

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )



    )-coalesce(
            nullif(

    position(
        '/' in 

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )



    ), 0),
            

    position(
        '?' in 

    replace(
        

    replace(
        landing_page_url,
        'http://',
        ''
    )


,
        'https://',
        ''
    )



    ) - 1
            )
        )
    end,
        '?',
        1
        )

 as TEXT)
     as url_path,
        nullif(

    split_part(
        

    split_part(
        landing_page_url,
        'utm_source=',
        2
        )

,
        '&',
        1
        )

,'') as utm_source,
        nullif(

    split_part(
        

    split_part(
        landing_page_url,
        'utm_medium=',
        2
        )

,
        '&',
        1
        )

,'') as utm_medium,
        nullif(

    split_part(
        

    split_part(
        landing_page_url,
        'utm_campaign=',
        2
        )

,
        '&',
        1
        )

,'') as utm_campaign,
        nullif(

    split_part(
        

    split_part(
        landing_page_url,
        'utm_content=',
        2
        )

,
        '&',
        1
        )

,'') as utm_content,
        nullif(

    split_part(
        

    split_part(
        landing_page_url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'') as utm_term,
        landing_page_url,
        row_number() over (partition by source_relation, ad_id order by updated_at desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final
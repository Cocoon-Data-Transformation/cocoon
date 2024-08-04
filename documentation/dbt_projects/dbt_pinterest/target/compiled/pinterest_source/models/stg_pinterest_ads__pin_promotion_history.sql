

with base as (

    select *
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__pin_promotion_history_tmp
), 

fields as (

    select

        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    ad_account_id
    
 , 
    cast(null as TEXT) as 
    
    android_deep_link
    
 , 
    cast(null as TEXT) as 
    
    click_tracking_url
    
 , 
    cast(null as timestamp) as 
    
    created_time
    
 , 
    cast(null as TEXT) as 
    
    creative_type
    
 , 
    cast(null as TEXT) as 
    
    destination_url
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    ios_deep_link
    
 , 
    cast(null as boolean) as 
    
    is_pin_deleted
    
 , 
    cast(null as boolean) as 
    
    is_removable
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    pin_id
    
 , 
    cast(null as TEXT) as 
    
    review_status
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as timestamp) as 
    
    updated_time
    
 , 
    cast(null as TEXT) as 
    
    view_tracking_url
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
), 

final as (

    select
        source_relation,
        id as pin_promotion_id,
        ad_account_id as advertiser_id,
        ad_group_id,
        created_time as created_at,
        destination_url,
        

    split_part(
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
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
        destination_url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'') as utm_term,
        name as pin_name,
        pin_id,
        status as pin_status,
        creative_type,
        _fivetran_synced,
        row_number() over (partition by source_relation, id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from fields
)

select *
from final


with base as (

    select * 
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_history_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as TEXT) as 
    
    display_url
    
 , 
    cast(null as TEXT) as 
    
    final_urls
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    status
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as boolean) as 
    
    _fivetran_active
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(ad_group_id as TEXT) as ad_group_id, 
        id as ad_id,
        name as ad_name,
        updated_at,
        type as ad_type,
        status as ad_status,
        display_url,
        final_urls as source_final_urls,
        replace(replace(final_urls, '[', ''),']','') as final_urls,
        row_number() over (partition by source_relation, id, ad_group_id order by updated_at desc) = 1 as is_most_recent_record
    from fields
    where coalesce(_fivetran_active, true)
),

final_urls as (

    select 
        *,
        --Extract the first url within the list of urls provided within the final_urls field
        

    split_part(
        final_urls,
        ',',
        1
        )

 as final_url

    from final

),

url_fields as (
    select 
        *,
        

    split_part(
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
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
        final_url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'') as utm_term
    from final_urls
)

select * 
from url_fields
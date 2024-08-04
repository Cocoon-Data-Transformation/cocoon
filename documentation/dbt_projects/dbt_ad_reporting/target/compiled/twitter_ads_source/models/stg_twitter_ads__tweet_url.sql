

with source as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__tweet_url_tmp

),

fields as (

    select
    
        
    cast(null as TEXT) as 
    
    display_url
    
 , 
    cast(null as TEXT) as 
    
    expanded_url
    
 , 
    cast(null as integer) as 
    
    index
    
 , 
    cast(null as TEXT) as 
    
    indices
    
 , 
    cast(null as TEXT) as 
    
    tweet_id
    
 , 
    cast(null as TEXT) as 
    
    url
    
 


    
        


, cast('' as TEXT) as source_relation




    from source

), 

final as (

    select
        source_relation,
        display_url,
        expanded_url,
        index,
        indices,
        tweet_id,
        url,
        

    split_part(
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
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
        expanded_url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'') as utm_term
    
    from fields

)

select * from final
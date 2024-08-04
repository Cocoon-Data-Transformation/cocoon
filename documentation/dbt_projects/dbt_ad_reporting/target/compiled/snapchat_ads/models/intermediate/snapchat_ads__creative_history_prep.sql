
with base as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__creative_history
    where is_most_recent_record = true

), url_tags as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__creative_url_tag_history
    where is_most_recent_record = true

), url_tags_pivoted as (

    select 
        source_relation,
        creative_id,
        min(case when param_key = 'utm_source' then param_value end) as utm_source,
        min(case when param_key = 'utm_medium' then param_value end) as utm_medium,
        min(case when param_key = 'utm_campaign' then param_value end) as utm_campaign,
        min(case when param_key = 'utm_content' then param_value end) as utm_content,
        min(case when param_key = 'utm_term' then param_value end) as utm_term
    from url_tags
    group by 1,2

), fields as (

    select
        base.source_relation,
        base.creative_id,
        base.ad_account_id,
        base.creative_name,
        base.url,
        

    split_part(
        base.url,
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
        base.url,
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
        base.url,
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
        base.url,
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
        base.url,
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
        base.url,
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
        base.url,
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
        base.url,
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
        base.url,
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
        coalesce(url_tags_pivoted.utm_source, nullif(

    split_part(
        

    split_part(
        base.url,
        'utm_source=',
        2
        )

,
        '&',
        1
        )

,'')) as utm_source,
        coalesce(url_tags_pivoted.utm_medium, nullif(

    split_part(
        

    split_part(
        base.url,
        'utm_medium=',
        2
        )

,
        '&',
        1
        )

,'')) as utm_medium,
        coalesce(url_tags_pivoted.utm_campaign, nullif(

    split_part(
        

    split_part(
        base.url,
        'utm_campaign=',
        2
        )

,
        '&',
        1
        )

,'')) as utm_campaign,
        coalesce(url_tags_pivoted.utm_content, nullif(

    split_part(
        

    split_part(
        base.url,
        'utm_content=',
        2
        )

,
        '&',
        1
        )

,'')) as utm_content,
        coalesce(url_tags_pivoted.utm_term, nullif(

    split_part(
        

    split_part(
        base.url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'')) as utm_term
    from base
    left join url_tags_pivoted
        on base.creative_id = url_tags_pivoted.creative_id
        and base.source_relation = url_tags_pivoted.source_relation

)

select *
from fields
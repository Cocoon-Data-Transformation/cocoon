

with report as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad_report
),

ads as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad
),

ad_groups as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__ad_group
), 

campaigns as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__campaign
), 

accounts as (

    select *
    from TEST.PUBLIC_reddit_ads_source.stg_reddit_ads__account
),

joined as (

    select
        report.source_relation,
        report.date_day,
        ads.ad_name,
        report.ad_id,
        report.account_id,
        campaigns.campaign_name,
        ads.campaign_id,
        ad_groups.ad_group_name,
        ads.ad_group_id,
        accounts.currency,
        ads.post_id,
        ads.post_url,
        ads.click_url,
        

    split_part(
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
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
        ads.click_url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'') as utm_term,
        nullif(

    split_part(
        

    split_part(
        ads.click_url,
        'utm_content=',
        2
        )

,
        '&',
        1
        )

,'') as utm_content,
        coalesce( nullif(

    split_part(
        

    split_part(
        ads.click_url,
        'utm_campaign=',
        2
        )

,
        '&',
        1
        )

,''), campaigns.campaign_name) as utm_campaign,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        





    from report
    left join ads
        on report.ad_id = ads.ad_id
        and report.source_relation = ads.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation
    left join ad_groups
        on ads.ad_group_id = ad_groups.ad_group_id
        and ads.source_relation = ad_groups.source_relation
    left join campaigns
        on ads.campaign_id = campaigns.campaign_id
        and ads.source_relation = campaigns.source_relation
    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
), 

filtered as (

    select *
    from joined

    
        where click_url is not null -- filter for only ads with valid URLs
    
)

select *
from filtered
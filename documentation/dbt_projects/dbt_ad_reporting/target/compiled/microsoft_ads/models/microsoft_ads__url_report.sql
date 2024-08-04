

with report as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_daily_report

), 

ads as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_history
    where is_most_recent_record = True

), 

ad_groups as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__ad_group_history
    where is_most_recent_record = True

), 

campaigns as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__campaign_history
    where is_most_recent_record = True

), 

accounts as (

    select *
    from TEST.PUBLIC_microsoft_ads_source.stg_microsoft_ads__account_history
    where is_most_recent_record = True

), 

joined as (

    select
        report.source_relation,
        report.date_day,
        accounts.account_name,
        report.account_id,
        campaigns.campaign_name,
        report.campaign_id,
        ad_groups.ad_group_name,
        report.ad_group_id,
        ads.ad_name,
        report.ad_id,
        report.device_os,
        report.device_type,
        report.network,
        report.currency_code,
        

    split_part(
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
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
        ads.final_url,
        'utm_term=',
        2
        )

,
        '&',
        1
        )

,'') as utm_term,
        sum(report.clicks) as clicks,
        sum(report.impressions) as impressions,
        sum(report.spend) as spend

        




    from report
    left join ads
        on report.ad_id = ads.ad_id
        and report.source_relation = ads.source_relation
    left join ad_groups
        on report.ad_group_id = ad_groups.ad_group_id
        and report.source_relation = ad_groups.source_relation
    left join campaigns
        on report.campaign_id = campaigns.campaign_id
        and report.source_relation = campaigns.source_relation
    left join accounts
        on report.account_id = accounts.account_id
        and report.source_relation = accounts.source_relation
    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
), 

filtered as (

    select * 
    from joined

    
        where base_url is not null
    
)

select *
from filtered
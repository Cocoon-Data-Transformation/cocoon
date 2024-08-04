

with  __dbt__cte__snapchat_ads__creative_history_prep as (

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
), ad_hourly as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_hourly_report

), creatives as (

    select *
    from __dbt__cte__snapchat_ads__creative_history_prep

), account as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_account_history
    where is_most_recent_record = true

), ads as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_history
    where is_most_recent_record = true

), ad_squads as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__ad_squad_history
    where is_most_recent_record = true

), campaigns as (

    select *
    from TEST.PUBLIC_snapchat_ads_source.stg_snapchat_ads__campaign_history
    where is_most_recent_record = true


), aggregated as (

    select
        ad_hourly.source_relation,
        cast(ad_hourly.date_hour as date) as date_day,
        account.ad_account_id,
        account.ad_account_name,
        ad_hourly.ad_id,
        ads.ad_name,
        ad_squads.ad_squad_id,
        ad_squads.ad_squad_name,
        campaigns.campaign_id,
        campaigns.campaign_name,
        account.currency,
        creatives.base_url,
        creatives.url_host,
        creatives.url_path,
        creatives.utm_source,
        creatives.utm_medium,
        creatives.utm_campaign,
        creatives.utm_content,
        creatives.utm_term,
        sum(ad_hourly.swipes) as swipes,
        sum(ad_hourly.impressions) as impressions,
        round(sum(ad_hourly.spend),2) as spend
        
        




    
    from ad_hourly
    left join ads 
        on ad_hourly.ad_id = ads.ad_id
        and ad_hourly.source_relation = ads.source_relation
    left join creatives
        on ads.creative_id = creatives.creative_id
        and ads.source_relation = creatives.source_relation
    left join ad_squads
        on ads.ad_squad_id = ad_squads.ad_squad_id
        and ads.source_relation = ad_squads.source_relation
    left join campaigns
        on ad_squads.campaign_id = campaigns.campaign_id
        and ad_squads.source_relation = campaigns.source_relation
    left join account
        on creatives.ad_account_id = account.ad_account_id
        and creatives.source_relation = account.source_relation

    
        -- We only want utm ads to populate this report. Therefore, we filter where url ads are populated.
        where creatives.url is not null
    

    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19

)

select *
from aggregated
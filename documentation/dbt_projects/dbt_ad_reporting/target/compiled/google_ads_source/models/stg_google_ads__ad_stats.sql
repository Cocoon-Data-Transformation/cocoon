

with base as (

    select * 
    from TEST.PUBLIC_google_ads_source.stg_google_ads__ad_stats_tmp

),

fields as (

    select
        
    cast(null as TEXT) as 
    
    ad_group
    
 , 
    cast(null as TEXT) as 
    
    ad_group_id
    
 , 
    cast(null as integer) as 
    
    ad_id
    
 , 
    cast(null as TEXT) as 
    
    ad_network_type
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as integer) as 
    
    cost_micros
    
 , 
    cast(null as integer) as 
    
    customer_id
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    device
    
 , 
    cast(null as integer) as 
    
    impressions
    
 , 
    cast(null as TEXT) as 
    
    keyword_ad_group_criterion
    
 , 
    cast(null as integer) as 
    
    conversions
    
 , 
    cast(null as integer) as 
    
    conversions_value
    
 , 
    cast(null as integer) as 
    
    view_through_conversions
    
 


        
    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        customer_id as account_id, 
        date as date_day, 
        
        coalesce(cast(ad_group_id as TEXT), 

    split_part(
        ad_group,
        'adGroups/',
        2
        )

) as ad_group_id,
        
        keyword_ad_group_criterion,
        ad_network_type,
        device,
        ad_id, 
        campaign_id, 
        coalesce(clicks, 0) as clicks, 
        coalesce(cost_micros, 0) / 1000000.0 as spend, 
        coalesce(impressions, 0) as impressions,
        coalesce(conversions, 0) as conversions,
        coalesce(conversions_value, 0) as conversions_value,
        coalesce(view_through_conversions, 0) as view_through_conversions

        





    from fields
)

select * from final


with base as (

    select * 
    from TEST.PUBLIC_pinterest_source.stg_pinterest_ads__ad_group_report_tmp
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
    
    ad_group_name
    
 , 
    cast(null as TEXT) as 
    
    ad_group_status
    
 , 
    cast(null as TEXT) as 
    
    advertiser_id
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    clickthrough_1
    
 , 
    cast(null as integer) as 
    
    clickthrough_2
    
 , 
    cast(null as timestamp) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impression_1
    
 , 
    cast(null as integer) as 
    
    impression_2
    
 , 
    cast(null as integer) as 
    
    spend_in_micro_dollar
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        date_trunc('day', date) as date_day,
        ad_group_id,
        ad_group_name,
        ad_group_status,
        campaign_id,
        advertiser_id,
        coalesce(impression_1,0) + coalesce(impression_2,0) as impressions,
        coalesce(clickthrough_1,0) + coalesce(clickthrough_2,0) as clicks,
        spend_in_micro_dollar / 1000000.0 as spend

        





    from fields
)

select *
from final
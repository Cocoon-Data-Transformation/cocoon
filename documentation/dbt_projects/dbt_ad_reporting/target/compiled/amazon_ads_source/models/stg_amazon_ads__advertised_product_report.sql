

with base as (

    select * 
    from TEST.PUBLIC_amazon_ads_source.stg_amazon_ads__advertised_product_report_tmp
),

fields as (

    select
        
    cast(null as integer) as 
    
    ad_group_id
    
 , 
    cast(null as integer) as 
    
    ad_id
    
 , 
    cast(null as TEXT) as 
    
    advertised_asin
    
 , 
    cast(null as TEXT) as 
    
    advertised_sku
    
 , 
    cast(null as float) as 
    
    campaign_budget_amount
    
 , 
    cast(null as TEXT) as 
    
    campaign_budget_currency_code
    
 , 
    cast(null as TEXT) as 
    
    campaign_budget_type
    
 , 
    cast(null as integer) as 
    
    campaign_id
    
 , 
    cast(null as integer) as 
    
    clicks
    
 , 
    cast(null as float) as 
    
    cost
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as integer) as 
    
    impressions
    
 


    
        


, cast('' as TEXT) as source_relation




    from base
),

final as (

    select
        source_relation, 
        cast(ad_id as TEXT) as ad_id,
        cast(ad_group_id as TEXT) as ad_group_id,
        advertised_asin,
        advertised_sku,
        campaign_budget_amount,
        campaign_budget_currency_code,
        campaign_budget_type,
        cast(campaign_id as TEXT) as campaign_id,
        clicks,
        cost,
        date as date_day,
        impressions

        




    from fields
)

select *
from final
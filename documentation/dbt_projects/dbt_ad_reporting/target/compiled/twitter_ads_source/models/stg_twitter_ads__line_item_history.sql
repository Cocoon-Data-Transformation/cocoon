

with source as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__line_item_history_tmp

),

fields as (

    select
    
        
    cast(null as TEXT) as 
    
    advertiser_domain
    
 , 
    cast(null as integer) as 
    
    advertiser_user_id
    
 , 
    cast(null as boolean) as 
    
    automatically_select_bid
    
 , 
    cast(null as integer) as 
    
    bid_amount_local_micro
    
 , 
    cast(null as TEXT) as 
    
    bid_type
    
 , 
    cast(null as TEXT) as 
    
    bid_unit
    
 , 
    cast(null as TEXT) as 
    
    campaign_id
    
 , 
    cast(null as TEXT) as 
    
    charge_by
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    creative_source
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as boolean) as 
    
    deleted
    
 , 
    cast(null as timestamp) as 
    
    end_time
    
 , 
    cast(null as TEXT) as 
    
    entity_status
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as TEXT) as 
    
    objective
    
 , 
    cast(null as TEXT) as 
    
    optimization
    
 , 
    cast(null as TEXT) as 
    
    primary_web_event_tag
    
 , 
    cast(null as TEXT) as 
    
    product_type
    
 , 
    cast(null as timestamp) as 
    
    start_time
    
 , 
    cast(null as integer) as 
    
    target_cpa_local_micro
    
 , 
    cast(null as integer) as 
    
    total_budget_amount_local_micro
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 


    
        


, cast('' as TEXT) as source_relation




    from source

), 

final as (

    select
        source_relation,
        advertiser_domain,
        advertiser_user_id,
        automatically_select_bid,
        bid_amount_local_micro,
        bid_type,
        bid_unit,
        campaign_id,
        charge_by,
        created_at as created_timestamp,
        creative_source,
        currency,
        deleted as is_deleted,
        end_time as end_timestamp,
        entity_status,
        id as line_item_id,
        name,
        objective,
        optimization,
        primary_web_event_tag,
        product_type,
        start_time as start_timestamp,
        target_cpa_local_micro,
        total_budget_amount_local_micro,
        updated_at as updated_timestamp,
        round(bid_amount_local_micro / 1000000.0,2) as bid_amount,
        round(total_budget_amount_local_micro / 1000000.0,2) as total_budget_amount,
        round(target_cpa_local_micro / 1000000.0,2) as target_cpa,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_latest_version
    
    from fields 
)

select * from final
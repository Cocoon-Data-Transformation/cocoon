

with source as (

    select *
    from TEST.PUBLIC_twitter_ads_source.stg_twitter_ads__campaign_history_tmp

),

fields as (

    select
    
        
    cast(null as TEXT) as 
    
    account_id
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    currency
    
 , 
    cast(null as integer) as 
    
    daily_budget_amount_local_micro
    
 , 
    cast(null as boolean) as 
    
    deleted
    
 , 
    cast(null as integer) as 
    
    duration_in_days
    
 , 
    cast(null as timestamp) as 
    
    end_time
    
 , 
    cast(null as TEXT) as 
    
    entity_status
    
 , 
    cast(null as integer) as 
    
    frequency_cap
    
 , 
    cast(null as TEXT) as 
    
    funding_instrument_id
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as boolean) as 
    
    servable
    
 , 
    cast(null as boolean) as 
    
    standard_delivery
    
 , 
    cast(null as timestamp) as 
    
    start_time
    
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
        account_id,
        created_at as created_timestamp,
        currency,
        daily_budget_amount_local_micro,
        deleted as is_deleted,
        duration_in_days,
        end_time as end_timestamp,
        entity_status,
        frequency_cap,
        funding_instrument_id,
        id as campaign_id,
        name as campaign_name,
        servable as is_servable,
        standard_delivery as is_standard_delivery,
        start_time as start_timestamp,
        total_budget_amount_local_micro,
        updated_at as updated_timestamp,
        round(daily_budget_amount_local_micro / 1000000.0,2) as daily_budget_amount,
        round(total_budget_amount_local_micro / 1000000.0,2) as total_budget_amount,
        row_number() over (partition by source_relation, id order by updated_at desc) = 1 as is_latest_version
    
    from fields 
)

select * from final
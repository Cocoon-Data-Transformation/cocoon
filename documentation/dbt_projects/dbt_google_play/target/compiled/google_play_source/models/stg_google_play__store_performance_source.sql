with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__store_performance_source_tmp
),

fields as (

    select
        
    cast(null as TEXT) as 
    
    _file
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    _line
    
 , 
    cast(null as timestamp) as 
    
    _modified
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    package_name
    
 , 
    cast(null as TEXT) as 
    
    search_term
    
 , 
    cast(null as integer) as 
    
    store_listing_acquisitions
    
 , 
    cast(null as float) as 
    
    store_listing_conversion_rate
    
 , 
    cast(null as integer) as 
    
    store_listing_visitors
    
 , 
    cast(null as TEXT) as 
    
    traffic_source
    
 , 
    cast(null as TEXT) as 
    
    utm_campaign
    
 , 
    cast(null as TEXT) as 
    
    utm_source
    
 



    from base
),

final as (

    select
        cast(date as date) as date_day,
        package_name,
        traffic_source,
        search_term,
        utm_campaign,
        utm_source,
        store_listing_acquisitions,
        store_listing_conversion_rate,
        store_listing_visitors,
        -- make a surrogate key as the PK involves quite a few columns
        md5(cast(coalesce(cast(date as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(package_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(traffic_source as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(search_term as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(utm_campaign as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(utm_source as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as traffic_source_unique_key,
        _fivetran_synced
    from fields
)

select *
from final
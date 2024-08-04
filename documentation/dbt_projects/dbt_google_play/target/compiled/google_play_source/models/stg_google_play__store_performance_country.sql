with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__store_performance_country_tmp
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
    cast(null as TEXT) as 
    
    country_region
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    package_name
    
 , 
    cast(null as integer) as 
    
    store_listing_acquisitions
    
 , 
    cast(null as float) as 
    
    store_listing_conversion_rate
    
 , 
    cast(null as integer) as 
    
    store_listing_visitors
    
 



    from base
),

final as (

    select
        cast(date as date) as date_day,
        country_region,
        package_name,
        sum(store_listing_acquisitions) as store_listing_acquisitions,
        avg(store_listing_conversion_rate) as store_listing_conversion_rate,
        sum(store_listing_visitors) as store_listing_visitors
    from fields
    group by 1,2,3
)

select *
from final
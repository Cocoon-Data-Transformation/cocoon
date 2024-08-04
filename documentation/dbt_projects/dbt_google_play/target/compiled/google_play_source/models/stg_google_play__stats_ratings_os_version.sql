with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_ratings_os_version_tmp
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
    
    android_os_version
    
 , 
    cast(null as TEXT) as 
    
    daily_average_rating
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    package_name
    
 , 
    cast(null as float) as 
    
    total_average_rating
    
 



    from base
),

final as (

    select
        cast(date as date) as date_day,
        android_os_version,
        package_name,
        case when android_os_version is null then null else cast( nullif(cast(daily_average_rating as TEXT), 'NA') as float ) end as average_rating,
        case when android_os_version is null then null else total_average_rating end as rolling_total_average_rating
    from fields
    group by 1,2,3,4,5
)

select *
from final
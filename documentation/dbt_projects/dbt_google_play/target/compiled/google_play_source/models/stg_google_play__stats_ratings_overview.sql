with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_ratings_overview_tmp
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
        package_name,
        cast( nullif(cast(daily_average_rating as TEXT), 'NA') as float ) as average_rating,
        total_average_rating as rolling_total_average_rating,
        _fivetran_synced
    from fields
)

select *
from final
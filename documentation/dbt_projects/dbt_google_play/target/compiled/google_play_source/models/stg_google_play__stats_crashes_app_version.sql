with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_crashes_app_version_tmp
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
    cast(null as integer) as 
    
    app_version_code
    
 , 
    cast(null as integer) as 
    
    daily_anrs
    
 , 
    cast(null as integer) as 
    
    daily_crashes
    
 , 
    cast(null as date) as 
    
    date
    
 , 
    cast(null as TEXT) as 
    
    package_name
    
 



    from base
),

final as (

    select
        cast(date as date) as date_day,
        app_version_code,
        package_name,
        sum(daily_anrs) as anrs,
        sum(daily_crashes) as crashes
    from fields
    group by 1,2,3
)

select *
from final
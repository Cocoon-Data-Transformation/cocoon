with base as (

    select *
    from TEST.PUBLIC_google_play_source.stg_google_play__stats_crashes_overview_tmp
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
        package_name,
        daily_anrs as anrs,
        daily_crashes as crashes,
        _fivetran_synced
    from fields
)

select *
from final
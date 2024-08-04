with base as (

    select * 
    from TEST.PUBLIC__source_amplitude.stg_amplitude__event_type_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as boolean) as 
    
    autohidden
    
 , 
    cast(null as boolean) as 
    
    deleted
    
 , 
    cast(null as TEXT) as 
    
    display
    
 , 
    cast(null as boolean) as 
    
    flow_hidden
    
 , 
    cast(null as boolean) as 
    
    hidden
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    in_waitroom
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as boolean) as 
    
    non_active
    
 , 
    cast(null as TEXT) as 
    
    project_name
    
 , 
    cast(null as boolean) as 
    
    timeline_hidden
    
 , 
    cast(null as integer) as 
    
    totals
    
 , 
    cast(null as integer) as 
    
    totals_delta
    
 , 
    cast(null as TEXT) as 
    
    value
    
 , 
    cast(null as TEXT) as 
    
    waitroom_approved
    
 


    from base
),

final as (
    
    select
        id as event_type_id,
        name as event_type_name,
        project_name,
        display,
        totals,
        totals_delta,
        value,
        flow_hidden as is_flow_hidden,
        hidden as is_hidden,
        in_waitroom as is_in_waitroom,
        non_active as is_non_active,
        autohidden as is_autohidden,
        deleted as is_deleted,
        timeline_hidden as is_timeline_hidden,
        waitroom_approved as is_waitroom_approved,
        _fivetran_deleted,
        _fivetran_synced
    from fields
),

surrogate as (

    select
        *,
        md5(cast(coalesce(cast(event_type_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(project_name as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as unique_event_type_id
    from final
)

select *
from surrogate
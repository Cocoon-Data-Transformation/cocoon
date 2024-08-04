with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__collection_tmp
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
    
    disjunctive
    
 , 
    cast(null as TEXT) as 
    
    handle
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    published_at
    
 , 
    cast(null as TEXT) as 
    
    published_scope
    
 , 
    cast(null as TEXT) as 
    
    rules
    
 , 
    cast(null as TEXT) as 
    
    sort_order
    
 , 
    cast(null as TEXT) as 
    
    title
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as collection_id,
        _fivetran_deleted as is_deleted,
        case 
            when disjunctive is null then null
            when disjunctive then 'disjunctive'
            else 'conjunctive' end as rule_logic,
        handle,
        published_scope,
        rules,
        sort_order,
        title,
        convert_timezone('UTC', 'UTC',
    cast(cast(published_at as timestamp) as timestamp)
) as published_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

    from fields
)

select *
from final
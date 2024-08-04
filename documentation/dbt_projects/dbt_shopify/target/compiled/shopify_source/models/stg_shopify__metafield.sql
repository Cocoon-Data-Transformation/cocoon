with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__metafield_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    description
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as TEXT) as 
    
    key
    
 , 
    cast(null as TEXT) as 
    
    namespace
    
 , 
    cast(null as integer) as 
    
    owner_id
    
 , 
    cast(null as TEXT) as 
    
    owner_resource
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as TEXT) as 
    
    value_type
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as TEXT) as 
    
    value
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        id as metafield_id,
        description,
        namespace,
        key,
        value,
        lower(coalesce(type, value_type)) as value_type,
        owner_id as owner_resource_id,
        lower(owner_resource) as owner_resource,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        lower(namespace || '_' || key) as metafield_reference,
        case when id is null and updated_at is null
            then row_number() over(partition by source_relation order by source_relation) = 1
            else row_number() over(partition by id, source_relation order by updated_at desc) = 1
        end as is_most_recent_record,
        source_relation
        
    from fields
)

select *
from final
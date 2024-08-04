with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout_discount_code_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as float) as 
    
    amount
    
 , 
    cast(null as integer) as 
    
    checkout_id
    
 , 
    cast(null as TEXT) as 
    
    code
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as integer) as 
    
    discount_id
    
 , 
    cast(null as integer) as 
    
    index
    
 , 
    cast(null as TEXT) as 
    
    type
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select 
        checkout_id,
        upper(code) as code,
        discount_id,
        amount,
        type,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(updated_at as timestamp) as timestamp)
) as updated_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation, 
        case when checkout_id is null and code is null and index is null
            then row_number() over(partition by source_relation order by source_relation)
            else row_number() over(partition by checkout_id, upper(code), source_relation order by index desc)
        end as index

    from fields
    
)

select *
from final
where index = 1
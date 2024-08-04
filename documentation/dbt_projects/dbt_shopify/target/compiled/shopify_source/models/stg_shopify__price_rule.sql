with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__price_rule_tmp
),

fields as (

    select
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as integer) as 
    
    allocation_limit
    
 , 
    cast(null as TEXT) as 
    
    allocation_method
    
 , 
    cast(null as timestamp) as 
    
    created_at
    
 , 
    cast(null as TEXT) as 
    
    customer_selection
    
 , 
    cast(null as timestamp) as 
    
    ends_at
    
 , 
    cast(null as integer) as 
    
    id
    
 , 
    cast(null as boolean) as 
    
    once_per_customer
    
 , 
    cast(null as float) as 
    
    prerequisite_quantity_range
    
 , 
    cast(null as float) as 
    
    prerequisite_shipping_price_range
    
 , 
    cast(null as float) as 
    
    prerequisite_subtotal_range
    
 , 
    cast(null as float) as 
    
    prerequisite_to_entitlement_purchase_prerequisite_amount
    
 , 
    cast(null as integer) as 
    
    quantity_ratio_entitled_quantity
    
 , 
    cast(null as integer) as 
    
    quantity_ratio_prerequisite_quantity
    
 , 
    cast(null as timestamp) as 
    
    starts_at
    
 , 
    cast(null as TEXT) as 
    
    target_selection
    
 , 
    cast(null as TEXT) as 
    
    target_type
    
 , 
    cast(null as TEXT) as 
    
    title
    
 , 
    cast(null as timestamp) as 
    
    updated_at
    
 , 
    cast(null as integer) as 
    
    usage_limit
    
 , 
    cast(null as float) as 
    
    value
    
 , 
    cast(null as TEXT) as 
    
    value_type
    
 



        


, cast('' as TEXT) as source_relation




    from base
),

final as (
    
    select
        id as price_rule_id,
        allocation_limit,
        allocation_method,
        customer_selection,
        once_per_customer as is_once_per_customer,
        prerequisite_quantity_range as prereq_min_quantity,
        prerequisite_shipping_price_range as prereq_max_shipping_price,
        prerequisite_subtotal_range as prereq_min_subtotal,
        prerequisite_to_entitlement_purchase_prerequisite_amount as prereq_min_purchase_quantity_for_entitlement,
        quantity_ratio_entitled_quantity as prereq_buy_x_get_this,
        quantity_ratio_prerequisite_quantity as prereq_buy_this_get_y,
        target_selection,
        target_type,
        title,
        usage_limit,
        value,
        value_type,
        convert_timezone('UTC', 'UTC',
    cast(cast(starts_at as timestamp) as timestamp)
) as starts_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(ends_at as timestamp) as timestamp)
) as ends_at,
        convert_timezone('UTC', 'UTC',
    cast(cast(created_at as timestamp) as timestamp)
) as created_at,
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
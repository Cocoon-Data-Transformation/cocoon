with base as (

    select * 
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line_tmp

),

fields as (

    select
    
        
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as numeric(28,6)) as 
    
    fulfillable_quantity
    
 , 
    cast(null as TEXT) as 
    
    fulfillment_status
    
 , 
    cast(null as boolean) as 
    
    gift_card
    
 , 
    cast(null as numeric(28,6)) as 
    
    grams
    
 , 
    cast(null as numeric(28,6)) as 
    
    id
    
 , 
    cast(null as numeric(28,6)) as 
    
    index
    
 , 
    cast(null as TEXT) as 
    
    name
    
 , 
    cast(null as numeric(28,6)) as 
    
    order_id
    
 , 
    cast(null as float) as 
    
    pre_tax_price
    
 , 
    cast(null as TEXT) as 
    
    pre_tax_price_set
    
 , 
    cast(null as float) as 
    
    price
    
 , 
    cast(null as TEXT) as 
    
    price_set
    
 , 
    cast(null as numeric(28,6)) as 
    
    product_id
    
 , 
    cast(null as numeric(28,6)) as 
    
    quantity
    
 , 
    cast(null as boolean) as 
    
    requires_shipping
    
 , 
    cast(null as TEXT) as 
    
    sku
    
 , 
    cast(null as boolean) as 
    
    taxable
    
 , 
    cast(null as TEXT) as 
    
    tax_code
    
 , 
    cast(null as TEXT) as 
    
    title
    
 , 
    cast(null as float) as 
    
    total_discount
    
 , 
    cast(null as TEXT) as 
    
    total_discount_set
    
 , 
    cast(null as numeric(28,6)) as 
    
    variant_id
    
 , 
    cast(null as TEXT) as 
    
    variant_title
    
 , 
    cast(null as TEXT) as 
    
    variant_inventory_management
    
 , 
    cast(null as TEXT) as 
    
    vendor
    
 , 
    cast(null as TEXT) as 
    
    properties
    
 



        


, cast('' as TEXT) as source_relation




    from base

),

final as (
    
    select 
        id as order_line_id,
        index,
        name,
        order_id,
        fulfillable_quantity,
        fulfillment_status,
        gift_card as is_gift_card,
        grams,
        pre_tax_price,
        pre_tax_price_set,
        price,
        price_set,
        product_id,
        quantity,
        requires_shipping as is_shipping_required,
        sku,
        taxable as is_taxable,
        tax_code,
        title,
        total_discount,
        total_discount_set,
        variant_id,
        variant_title,
        variant_inventory_management,
        vendor,
        properties,
        convert_timezone('UTC', 'UTC',
    cast(cast(_fivetran_synced as timestamp) as timestamp)
) as _fivetran_synced,
        source_relation

        





    from fields

)

select * 
from final
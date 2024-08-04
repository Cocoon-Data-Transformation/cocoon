with  __dbt__cte__shopify__orders__order_refunds as (
with refunds as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__refund

), order_line_refunds as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line_refund
    
), refund_join as (

    select 
        refunds.refund_id,
        refunds.created_at,
        refunds.order_id,
        refunds.user_id,
        refunds.source_relation,
        order_line_refunds.order_line_refund_id,
        order_line_refunds.order_line_id,
        order_line_refunds.restock_type,
        order_line_refunds.quantity,
        order_line_refunds.subtotal,
        order_line_refunds.total_tax

    from refunds
    left join order_line_refunds
        on refunds.refund_id = order_line_refunds.refund_id
        and refunds.source_relation = order_line_refunds.source_relation

)

select *
from refund_join
),  __dbt__cte__int_shopify__inventory_level__aggregates as (
with order_lines as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line
),

fulfillment as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__fulfillment
),

orders as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__order
    where not coalesce(is_deleted, false)
), 

refunds as (

    select *
    from __dbt__cte__shopify__orders__order_refunds

), refunds_aggregated as (
    
    select
        order_line_id,
        source_relation,
        sum(quantity) as quantity,
        sum(coalesce(subtotal, 0)) as subtotal

    from refunds
    group by 1,2
),

joined as (

    select
        order_lines.order_line_id,
        order_lines.variant_id,
        order_lines.source_relation,
        fulfillment.location_id, -- location id is stored in fulfillment rather than order
        orders.order_id,
        orders.customer_id,
        fulfillment.fulfillment_id,
        lower(orders.email) as email,
        order_lines.pre_tax_price,
        order_lines.quantity,
        orders.created_timestamp as order_created_timestamp,
        fulfillment.status as fulfillment_status, 
        refunds_aggregated.subtotal as subtotal_sold_refunds, 
        refunds_aggregated.quantity as quantity_sold_refunds

    from order_lines
    join orders
        on order_lines.order_id = orders.order_id
        and order_lines.source_relation = orders.source_relation
    join fulfillment
        on orders.order_id = fulfillment.order_id
        and orders.source_relation = fulfillment.source_relation
    left join refunds_aggregated
        on refunds_aggregated.order_line_id = order_lines.order_line_id
        and refunds_aggregated.source_relation = order_lines.source_relation
),

aggregated as (

    select
        variant_id,
        location_id,
        source_relation,
        sum(pre_tax_price) as subtotal_sold,
        sum(quantity) as quantity_sold,
        count(distinct order_id) as count_distinct_orders,
        count(distinct customer_id) as count_distinct_customers,
        count(distinct email) as count_distinct_customer_emails,
        min(order_created_timestamp) as first_order_timestamp,
        max(order_created_timestamp) as last_order_timestamp

        
        , count(distinct case when fulfillment_status = 'pending' then fulfillment_id end) as count_fulfillment_pending
        
        , count(distinct case when fulfillment_status = 'open' then fulfillment_id end) as count_fulfillment_open
        
        , count(distinct case when fulfillment_status = 'success' then fulfillment_id end) as count_fulfillment_success
        
        , count(distinct case when fulfillment_status = 'cancelled' then fulfillment_id end) as count_fulfillment_cancelled
        
        , count(distinct case when fulfillment_status = 'error' then fulfillment_id end) as count_fulfillment_error
        
        , count(distinct case when fulfillment_status = 'failure' then fulfillment_id end) as count_fulfillment_failure
        

        , sum(coalesce(subtotal_sold_refunds, 0)) as subtotal_sold_refunds
        , sum(coalesce(quantity_sold_refunds, 0)) as quantity_sold_refunds

    from joined

    group by 1,2,3
)

select *
from aggregated
), inventory_level as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__inventory_level
), 

inventory_item as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__inventory_item
),

location as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__location
),

product_variant as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_variant
),

product as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__product
),

inventory_level_aggregated as (

    select *
    from __dbt__cte__int_shopify__inventory_level__aggregates
),

joined_info as (

    select 
        inventory_level.*,
        inventory_item.sku,
        inventory_item.is_deleted as is_inventory_item_deleted,
        inventory_item.cost,
        inventory_item.country_code_of_origin,
        inventory_item.province_code_of_origin,
        inventory_item.is_shipping_required,
        inventory_item.is_inventory_quantity_tracked,
        inventory_item.created_at as inventory_item_created_at,
        inventory_item.updated_at as inventory_item_updated_at,

        location.name as location_name, 
        location.is_deleted as is_location_deleted,
        location.is_active as is_location_active,
        location.address_1,
        location.address_2,
        location.city,
        location.country,
        location.country_code,
        location.is_legacy as is_legacy_location,
        location.province,
        location.province_code,
        location.phone,
        location.zip,
        location.created_at as location_created_at,
        location.updated_at as location_updated_at,

        product_variant.variant_id,
        product_variant.product_id,
        product_variant.title as variant_title,
        product_variant.inventory_policy as variant_inventory_policy,
        product_variant.price as variant_price,
        product_variant.image_id as variant_image_id,
        product_variant.fulfillment_service as variant_fulfillment_service,
        product_variant.inventory_management as variant_inventory_management,
        product_variant.is_taxable as is_variant_taxable,
        product_variant.barcode as variant_barcode,
        product_variant.grams as variant_grams, 
        product_variant.inventory_quantity as variant_inventory_quantity,
        product_variant.weight as variant_weight,
        product_variant.weight_unit as variant_weight_unit,
        product_variant.option_1 as variant_option_1,
        product_variant.option_2 as variant_option_2,
        product_variant.option_3 as variant_option_3,
        product_variant.tax_code as variant_tax_code,
        product_variant.created_timestamp as variant_created_at,
        product_variant.updated_timestamp as variant_updated_at

        





    from inventory_level
    join inventory_item 
        on inventory_level.inventory_item_id = inventory_item.inventory_item_id 
        and inventory_level.source_relation = inventory_item.source_relation 
    join location 
        on inventory_level.location_id = location.location_id 
        and inventory_level.source_relation = location.source_relation 
    join product_variant 
        on inventory_item.inventory_item_id = product_variant.inventory_item_id 
        and inventory_item.source_relation = product_variant.source_relation

),

joined_aggregates as (

    select 
        joined_info.*,
        coalesce(inventory_level_aggregated.subtotal_sold, 0) as subtotal_sold,
        coalesce(inventory_level_aggregated.quantity_sold, 0) as quantity_sold,
        coalesce(inventory_level_aggregated.count_distinct_orders, 0) as count_distinct_orders,
        coalesce(inventory_level_aggregated.count_distinct_customers, 0) as count_distinct_customers,
        coalesce(inventory_level_aggregated.count_distinct_customer_emails, 0) as count_distinct_customer_emails,
        inventory_level_aggregated.first_order_timestamp,
        inventory_level_aggregated.last_order_timestamp,
        coalesce(inventory_level_aggregated.subtotal_sold_refunds, 0) as subtotal_sold_refunds,
        coalesce(inventory_level_aggregated.quantity_sold_refunds, 0) as quantity_sold_refunds

        
        , coalesce(count_fulfillment_pending, 0) as count_fulfillment_pending
        
        , coalesce(count_fulfillment_open, 0) as count_fulfillment_open
        
        , coalesce(count_fulfillment_success, 0) as count_fulfillment_success
        
        , coalesce(count_fulfillment_cancelled, 0) as count_fulfillment_cancelled
        
        , coalesce(count_fulfillment_error, 0) as count_fulfillment_error
        
        , coalesce(count_fulfillment_failure, 0) as count_fulfillment_failure
        

    from joined_info
    left join inventory_level_aggregated
        on joined_info.location_id = inventory_level_aggregated.location_id
        and joined_info.variant_id = inventory_level_aggregated.variant_id
        and joined_info.source_relation = inventory_level_aggregated.source_relation
),

final as (

    select 
        *,
        subtotal_sold - subtotal_sold_refunds as net_subtotal_sold,
        quantity_sold - quantity_sold_refunds as net_quantity_sold
    from joined_aggregates
)

select * 
from final
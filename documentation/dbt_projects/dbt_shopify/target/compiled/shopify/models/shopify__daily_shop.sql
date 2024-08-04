with  __dbt__cte__int_shopify__daily_orders as (
with orders as (

    select *
    from TEST.PUBLIC_shopify.shopify__orders

    where not coalesce(is_deleted, false)
),

order_lines as(

    select *
    from TEST.PUBLIC_shopify.shopify__order_lines
),

order_aggregates as (

    select
        source_relation,
        cast(date_trunc('day', created_timestamp) as date) as date_day,
        count(distinct order_id) as count_orders,
        sum(line_item_count) as count_line_items,
        avg(line_item_count) as avg_line_item_count,
        count(distinct customer_id) as count_customers,
        count(distinct email) as count_customer_emails,
        sum(order_adjusted_total) as order_adjusted_total,
        avg(order_adjusted_total) as avg_order_value,
        sum(shipping_cost) as shipping_cost,
        sum(order_adjustment_amount) as order_adjustment_amount,
        sum(order_adjustment_tax_amount) as order_adjustment_tax_amount,
        sum(refund_subtotal) as refund_subtotal,
        sum(refund_total_tax) as refund_total_tax,
        sum(total_discounts) as total_discounts,
        avg(total_discounts) as avg_discount,
        sum(shipping_discount_amount) as shipping_discount_amount,
        avg(shipping_discount_amount) as avg_shipping_discount_amount,
        sum(percentage_calc_discount_amount) as percentage_calc_discount_amount,
        avg(percentage_calc_discount_amount) as avg_percentage_calc_discount_amount,
        sum(fixed_amount_discount_amount) as fixed_amount_discount_amount,
        avg(fixed_amount_discount_amount) as avg_fixed_amount_discount_amount,
        sum(count_discount_codes_applied) as count_discount_codes_applied,
        count(distinct location_id) as count_locations_ordered_from,
        sum(case when count_discount_codes_applied > 0 then 1 else 0 end) as count_orders_with_discounts,
        sum(case when refund_subtotal > 0 then 1 else 0 end) as count_orders_with_refunds,
        min(created_timestamp) as first_order_timestamp,
        max(created_timestamp) as last_order_timestamp

    from orders
    group by 1,2

),

order_line_aggregates as (

    select
        order_lines.source_relation,
        cast(date_trunc('day', orders.created_timestamp) as date) as date_day,
        sum(order_lines.quantity) as quantity_sold,
        sum(order_lines.refunded_quantity) as quantity_refunded,
        sum(order_lines.quantity_net_refunds) as quantity_net,
        sum(order_lines.quantity) / count(distinct order_lines.order_id) as avg_quantity_sold,
        sum(order_lines.quantity_net_refunds) / count(distinct order_lines.order_id) as avg_quantity_net,
        count(distinct order_lines.variant_id) as count_variants_sold, 
        count(distinct order_lines.product_id) as count_products_sold, 
        sum(case when order_lines.is_gift_card then order_lines.quantity_net_refunds else 0 end) as quantity_gift_cards_sold,
        sum(case when order_lines.is_shipping_required then order_lines.quantity_net_refunds else 0 end) as quantity_requiring_shipping

    from order_lines
    left join orders -- just joining with order to get the created_timestamp
        on order_lines.order_id = orders.order_id
        and order_lines.source_relation = orders.source_relation

    group by 1,2
),

final as (

    select 
        order_aggregates.*,
        order_line_aggregates.quantity_sold,
        order_line_aggregates.quantity_refunded,
        order_line_aggregates.quantity_net,
        order_line_aggregates.count_variants_sold,
        order_line_aggregates.count_products_sold,
        order_line_aggregates.quantity_gift_cards_sold,
        order_line_aggregates.quantity_requiring_shipping,
        order_line_aggregates.avg_quantity_sold,
        order_line_aggregates.avg_quantity_net

    from order_aggregates
    left join order_line_aggregates
        on order_aggregates.date_day = order_line_aggregates.date_day
        and order_aggregates.source_relation = order_line_aggregates.source_relation
)

select *
from final
),  __dbt__cte__int_shopify__daily_abandoned_checkouts as (
with abandoned_checkout as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout

    -- "deleted" abandoned checkouts do not appear to have any data tying them to customers,
    -- discounts, or products (and should therefore not get joined in) but let's filter them out here
    where not coalesce(is_deleted, false)
),

abandoned_checkout_aggregates as (

    select
        source_relation,
        cast(date_trunc('day', created_at) as date) as date_day,
        count(distinct checkout_id) as count_abandoned_checkouts,
        count(distinct customer_id) as count_customers_abandoned_checkout,
        count(distinct email) as count_customer_emails_abandoned_checkout

    from abandoned_checkout
    group by 1,2
)

select * 
from abandoned_checkout_aggregates
), shop as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__shop
),

calendar as (

    select *
    from TEST.PUBLIC_shopify.shopify__calendar
    where cast(date_trunc('day', date_day) as date) = date_day
),

daily_orders as (

    select *
    from __dbt__cte__int_shopify__daily_orders
),

daily_abandoned_checkouts as (

    select *
    from __dbt__cte__int_shopify__daily_abandoned_checkouts
),



shop_calendar as (

    select
        cast(date_trunc('day', calendar.date_day) as date) as date_day,
        shop.shop_id,
        shop.name,
        shop.domain,
        shop.is_deleted,
        shop.currency,
        shop.enabled_presentment_currencies,
        shop.iana_timezone,
        shop.created_at,
        shop.source_relation

    from calendar
    join shop 
        on cast(shop.created_at as date) <= calendar.date_day
),

final as (

    select 
        shop_calendar.*,

        coalesce(daily_orders.count_orders, 0) as count_orders,
        coalesce(daily_orders.count_line_items, 0) as count_line_items,
        daily_orders.avg_line_item_count,
        coalesce(daily_orders.count_customers, 0) as count_customers,
        coalesce(daily_orders.count_customer_emails, 0) as count_customer_emails,
        coalesce(daily_orders.order_adjusted_total, 0) as order_adjusted_total,
        daily_orders.avg_order_value,
        coalesce(daily_orders.shipping_cost, 0) as shipping_cost,
        coalesce(daily_orders.order_adjustment_amount, 0) as order_adjustment_amount,
        coalesce(daily_orders.order_adjustment_tax_amount, 0) as order_adjustment_tax_amount,
        coalesce(daily_orders.refund_subtotal, 0) as refund_subtotal,
        coalesce(daily_orders.refund_total_tax, 0) as refund_total_tax,
        coalesce(daily_orders.total_discounts, 0) as total_discounts,
        daily_orders.avg_discount,
        coalesce(daily_orders.shipping_discount_amount, 0) as shipping_discount_amount,
        daily_orders.avg_shipping_discount_amount,
        coalesce(daily_orders.percentage_calc_discount_amount, 0) as percentage_calc_discount_amount,
        daily_orders.avg_percentage_calc_discount_amount,
        coalesce(daily_orders.fixed_amount_discount_amount, 0) as fixed_amount_discount_amount,
        daily_orders.avg_fixed_amount_discount_amount,
        coalesce(daily_orders.count_discount_codes_applied, 0) as count_discount_codes_applied,
        coalesce(daily_orders.count_locations_ordered_from, 0) as count_locations_ordered_from,
        coalesce(daily_orders.count_orders_with_discounts, 0) as count_orders_with_discounts,
        coalesce(daily_orders.count_orders_with_refunds, 0) as count_orders_with_refunds,
        daily_orders.first_order_timestamp,
        daily_orders.last_order_timestamp,

        coalesce(daily_orders.quantity_sold, 0) as quantity_sold,
        coalesce(daily_orders.quantity_refunded, 0) as quantity_refunded,
        coalesce(daily_orders.quantity_net, 0) as quantity_net,
        daily_orders.avg_quantity_sold,
        daily_orders.avg_quantity_net,
        coalesce(daily_orders.count_variants_sold, 0) as count_variants_sold,
        coalesce(daily_orders.count_products_sold, 0) as count_products_sold,
        coalesce(daily_orders.quantity_gift_cards_sold, 0) as quantity_gift_cards_sold,
        coalesce(daily_orders.quantity_requiring_shipping, 0) as quantity_requiring_shipping,

        coalesce(daily_abandoned_checkouts.count_abandoned_checkouts, 0) as count_abandoned_checkouts,
        coalesce(daily_abandoned_checkouts.count_customers_abandoned_checkout, 0) as count_customers_abandoned_checkout,
        coalesce(daily_abandoned_checkouts.count_customer_emails_abandoned_checkout, 0) as count_customer_emails_abandoned_checkout

        

    from shop_calendar
    left join daily_orders 
        on shop_calendar.source_relation = daily_orders.source_relation
        and shop_calendar.date_day = daily_orders.date_day
    left join daily_abandoned_checkouts 
        on shop_calendar.source_relation = daily_abandoned_checkouts.source_relation
        and shop_calendar.date_day = daily_abandoned_checkouts.date_day
    
    
)


select *
from final
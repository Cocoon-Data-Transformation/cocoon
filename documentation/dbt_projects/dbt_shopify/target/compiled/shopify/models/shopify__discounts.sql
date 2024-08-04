

with  __dbt__cte__int_shopify__discounts__order_aggregates as (
with order_discount_code as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_discount_code
),

orders as (

    select *
    from TEST.PUBLIC_shopify.shopify__orders
),

orders_aggregated as (

    select 
        order_discount_code.code,
        order_discount_code.type,
        order_discount_code.source_relation,
        avg(order_discount_code.amount) as avg_order_discount_amount,
        sum(order_discount_code.amount) as total_order_discount_amount,
        max(orders.total_line_items_price) as total_order_line_items_price, -- summing would multiply the total by the # of discount codes applied to an order
        max(orders.shipping_cost) as total_order_shipping_cost, -- summing would multiply the total by the # of discount codes applied to an order
        max(orders.refund_subtotal + orders.refund_total_tax) as total_order_refund_amount, -- summing would multiply the total by the # of discount codes applied to an order
        count(distinct customer_id) as count_customers,
        count(distinct email) as count_customer_emails,
        count(distinct order_discount_code.order_id) as count_orders

    from order_discount_code
    join orders 
        on order_discount_code.order_id = orders.order_id 
        and order_discount_code.source_relation = orders.source_relation

    group by 1,2,3
)

select *
from orders_aggregated
),  __dbt__cte__int_shopify__discounts__abandoned_checkouts as (
with abandoned_checkout as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout

    -- "deleted" abandoned checkouts do not appear to have any data tying them to customers,
    -- discounts, or products (and should therefore not get joined in) but let's filter them out here
    where not coalesce(is_deleted, false)
),

abandoned_checkout_discount_code as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout_discount_code

    -- we need the TYPE of discount (shipping, percentage, fixed_amount) to avoid fanning out of joins
    -- so filter out records that have this
    where coalesce(type, '') != ''
),

abandoned_checkout_shipping_line as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout_shipping_line
),

roll_up_shipping_line as (

    select 
        checkout_id,
        source_relation,
        sum(price) as price

    from abandoned_checkout_shipping_line
    group by 1,2
),

abandoned_checkouts_aggregated as (

    select 
        abandoned_checkout_discount_code.code,
        abandoned_checkout_discount_code.type,
        abandoned_checkout_discount_code.source_relation,
        sum(abandoned_checkout_discount_code.amount) as total_abandoned_checkout_discount_amount,
        sum(coalesce(abandoned_checkout.total_line_items_price, 0)) as total_abandoned_checkout_line_items_price,
        sum(coalesce(roll_up_shipping_line.price, 0)) as total_abandoned_checkout_shipping_price,
        count(distinct customer_id) as count_abandoned_checkout_customers,
        count(distinct email) as count_abandoned_checkout_customer_emails,
        count(distinct abandoned_checkout.checkout_id) as count_abandoned_checkouts

    from abandoned_checkout_discount_code
    left join abandoned_checkout
        on abandoned_checkout_discount_code.checkout_id = abandoned_checkout.checkout_id
        and abandoned_checkout_discount_code.source_relation = abandoned_checkout.source_relation
    left join roll_up_shipping_line
        on roll_up_shipping_line.checkout_id = abandoned_checkout_discount_code.checkout_id 
        and roll_up_shipping_line.source_relation = abandoned_checkout_discount_code.source_relation

    group by 1,2,3
)

select *
from abandoned_checkouts_aggregated
), discount as (

    select 
        *,
        md5(cast(coalesce(cast(source_relation as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(discount_code_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as discounts_unique_key
    from TEST.PUBLIC_stg_shopify.stg_shopify__discount_code

    
),

price_rule as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__price_rule
),

orders_aggregated as (

    select *
    from __dbt__cte__int_shopify__discounts__order_aggregates
),

abandoned_checkouts_aggregated as (

    select *
    from __dbt__cte__int_shopify__discounts__abandoned_checkouts
),

discount_price_rule_joined as (

    select
        discount.*,
        price_rule.target_selection,
        price_rule.target_type,
        price_rule.title,
        price_rule.usage_limit,
        price_rule.value,
        price_rule.value_type,
        price_rule.allocation_limit,
        price_rule.allocation_method,
        price_rule.is_once_per_customer,
        price_rule.customer_selection,
        -- the below are NULL if customer_selection = all
        price_rule.prereq_min_quantity,
        price_rule.prereq_max_shipping_price,
        price_rule.prereq_min_subtotal,
        price_rule.prereq_min_purchase_quantity_for_entitlement,
        price_rule.prereq_buy_x_get_this,
        price_rule.prereq_buy_this_get_y,
        price_rule.starts_at,
        price_rule.ends_at,
        price_rule.created_at as price_rule_created_at,
        price_rule.updated_at as price_rule_updated_at

    from discount
    left join price_rule
        on discount.price_rule_id = price_rule.price_rule_id
        and discount.source_relation = price_rule.source_relation
),

aggregates_joined as (

    select 
        discount_price_rule_joined.*,
        coalesce(orders_aggregated.count_orders, 0) as count_orders,
        coalesce(abandoned_checkouts_aggregated.count_abandoned_checkouts, 0) as count_abandoned_checkouts,
        orders_aggregated.avg_order_discount_amount,
        coalesce(orders_aggregated.total_order_discount_amount, 0) as total_order_discount_amount,
        coalesce(abandoned_checkouts_aggregated.total_abandoned_checkout_discount_amount, 0) as total_abandoned_checkout_discount_amount,
        coalesce(orders_aggregated.total_order_line_items_price, 0) as total_order_line_items_price,
        coalesce(orders_aggregated.total_order_shipping_cost, 0) as total_order_shipping_cost,
        coalesce(abandoned_checkouts_aggregated.total_abandoned_checkout_shipping_price, 0) as total_abandoned_checkout_shipping_price,
        coalesce(orders_aggregated.total_order_refund_amount, 0) as total_order_refund_amount,
        coalesce(orders_aggregated.count_customers, 0) as count_customers,
        coalesce(orders_aggregated.count_customer_emails, 0) as count_customer_emails,
        coalesce(abandoned_checkouts_aggregated.count_abandoned_checkout_customers, 0) as count_abandoned_checkout_customers,
        coalesce(abandoned_checkouts_aggregated.count_abandoned_checkout_customer_emails, 0) as count_abandoned_checkout_customer_emails

    from discount_price_rule_joined
    left join orders_aggregated
        on discount_price_rule_joined.code = orders_aggregated.code
        and discount_price_rule_joined.source_relation = orders_aggregated.source_relation
        -- in case one CODE can apply to both shipping and line items, percentages and fixed_amounts
        and (case 
                when discount_price_rule_joined.target_type = 'shipping_line' then 'shipping' -- when target_type = 'shipping', value_type = 'percentage'
                else discount_price_rule_joined.value_type end) = orders_aggregated.type
        
    left join abandoned_checkouts_aggregated
        on discount_price_rule_joined.code = abandoned_checkouts_aggregated.code
        and discount_price_rule_joined.source_relation = abandoned_checkouts_aggregated.source_relation
        -- in case one CODE can apply to both shipping and line items, percentages and fixed_amounts
        and (case 
                when discount_price_rule_joined.target_type = 'shipping_line' then 'shipping' -- when target_type = 'shipping', value_type = 'percentage'
                else discount_price_rule_joined.value_type end) = abandoned_checkouts_aggregated.type 
)

select * 
from aggregates_joined
with  __dbt__cte__shopify__customers__order_aggregates as (
with orders as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__order
    where customer_id is not null

), order_aggregates as (

    select *
    from TEST.PUBLIC_shopify.shopify__orders__order_line_aggregates

), transactions as (

    select *
    from TEST.PUBLIC_shopify.shopify__transactions

    where lower(status) = 'success'
    and lower(kind) not in ('authorization', 'void')
    and lower(gateway) != 'gift_card' -- redeeming a giftcard does not introduce new revenue

), transaction_aggregates as (
    -- this is necessary as customers can pay via multiple payment gateways
    select 
        order_id,
        source_relation,
        lower(kind) as kind,
        sum(currency_exchange_calculated_amount) as currency_exchange_calculated_amount

    from transactions
    group by 1,2,3

), customer_tags as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__customer_tag

), customer_tags_aggregated as (

    select 
        customer_id,
        source_relation,
        
    listagg(distinct cast(value as TEXT), ', ')

 as customer_tags

    from customer_tags
    group by 1,2

), aggregated as (

    select
        orders.customer_id,
        orders.source_relation,
        customer_tags_aggregated.customer_tags,
        min(orders.created_timestamp) as first_order_timestamp,
        max(orders.created_timestamp) as most_recent_order_timestamp,
        avg(transaction_aggregates.currency_exchange_calculated_amount) as avg_order_value,
        sum(transaction_aggregates.currency_exchange_calculated_amount) as lifetime_total_spent,
        sum(refunds.currency_exchange_calculated_amount) as lifetime_total_refunded,
        count(distinct orders.order_id) as lifetime_count_orders,
        avg(order_aggregates.order_total_quantity) as avg_quantity_per_order,
        sum(order_aggregates.order_total_tax) as lifetime_total_tax,
        avg(order_aggregates.order_total_tax) as avg_tax_per_order,
        sum(order_aggregates.order_total_discount) as lifetime_total_discount,
        avg(order_aggregates.order_total_discount) as avg_discount_per_order,
        sum(order_aggregates.order_total_shipping) as lifetime_total_shipping,
        avg(order_aggregates.order_total_shipping) as avg_shipping_per_order,
        sum(order_aggregates.order_total_shipping_with_discounts) as lifetime_total_shipping_with_discounts,
        avg(order_aggregates.order_total_shipping_with_discounts) as avg_shipping_with_discounts_per_order,
        sum(order_aggregates.order_total_shipping_tax) as lifetime_total_shipping_tax,
        avg(order_aggregates.order_total_shipping_tax) as avg_shipping_tax_per_order

    from orders
    left join transaction_aggregates 
        on orders.order_id = transaction_aggregates.order_id
        and orders.source_relation = transaction_aggregates.source_relation
        and transaction_aggregates.kind in ('sale','capture')
    left join transaction_aggregates as refunds
        on orders.order_id = refunds.order_id
        and orders.source_relation = refunds.source_relation
        and refunds.kind = 'refund'
    left join order_aggregates
        on orders.order_id = order_aggregates.order_id
        and orders.source_relation = order_aggregates.source_relation
    left join customer_tags_aggregated
        on orders.customer_id = customer_tags_aggregated.customer_id
        and orders.source_relation = customer_tags_aggregated.source_relation
    
    group by 1,2,3
)

select *
from aggregated
), customers as (

    select 
        
*
/* No columns were returned. Maybe the relation doesn't exist yet 
or all columns were excluded. This star is only output during  
dbt compile, and exists to keep SQLFluff happy. */
            
    from TEST.PUBLIC_stg_shopify.stg_shopify__customer

), orders as (

    select *
    from __dbt__cte__shopify__customers__order_aggregates

), abandoned as (

    select 
        customer_id,
        source_relation,
        count(distinct checkout_id) as lifetime_abandoned_checkouts
    from TEST.PUBLIC_stg_shopify.stg_shopify__abandoned_checkout
    where customer_id is not null
    group by 1,2

), joined as (

    select 
        customers.*,
        coalesce(abandoned.lifetime_abandoned_checkouts, 0) as lifetime_abandoned_checkouts,
        orders.first_order_timestamp,
        orders.most_recent_order_timestamp,
        orders.customer_tags,
        orders.avg_order_value,
        coalesce(orders.lifetime_total_spent, 0) as lifetime_total_spent,
        coalesce(orders.lifetime_total_refunded, 0) as lifetime_total_refunded,
        (coalesce(orders.lifetime_total_spent, 0) - coalesce(orders.lifetime_total_refunded, 0)) as lifetime_total_net,
        coalesce(orders.lifetime_count_orders, 0) as lifetime_count_orders,
        orders.avg_quantity_per_order,
        coalesce(orders.lifetime_total_tax, 0) as lifetime_total_tax,
        orders.avg_tax_per_order,
        coalesce(orders.lifetime_total_discount, 0) as lifetime_total_discount,
        orders.avg_discount_per_order,
        coalesce(orders.lifetime_total_shipping, 0) as lifetime_total_shipping,
        orders.avg_shipping_per_order,
        coalesce(orders.lifetime_total_shipping_with_discounts, 0) as lifetime_total_shipping_with_discounts,
        orders.avg_shipping_with_discounts_per_order,
        coalesce(orders.lifetime_total_shipping_tax, 0) as lifetime_total_shipping_tax,
        orders.avg_shipping_tax_per_order

    from customers
    left join orders
        on customers.customer_id = orders.customer_id
        and customers.source_relation = orders.source_relation
    left join abandoned
        on customers.customer_id = abandoned.customer_id
        and customers.source_relation = abandoned.source_relation
)

select *
from joined
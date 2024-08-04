

with  __dbt__cte__int_shopify__order__shipping_aggregates as (
with order_shipping_line as (

    select
        order_id,
        source_relation,
        order_shipping_line_id,
        sum(price) as shipping_price,
        sum(discounted_price) as discounted_shipping_price
        
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_shipping_line
    group by 1,2,3

), order_shipping_tax_line as (

    select
        order_shipping_line_id,
        source_relation,
        sum(price) as shipping_tax

    from TEST.PUBLIC_stg_shopify.stg_shopify__order_shipping_tax_line
    group by 1,2 

), aggregated as (

    select 
        order_shipping_line.order_id,
        order_shipping_line.source_relation,
        sum(order_shipping_line.shipping_price) as shipping_price,
        sum(order_shipping_line.discounted_shipping_price) as discounted_shipping_price,
        sum(order_shipping_tax_line.shipping_tax) as shipping_tax

    from order_shipping_line
    left join order_shipping_tax_line
        on order_shipping_line.order_shipping_line_id = order_shipping_tax_line.order_shipping_line_id
        and order_shipping_line.source_relation = order_shipping_tax_line.source_relation
    group by 1,2
)

select * 
from aggregated
), order_line as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__order_line

), tax as (

    select
        *
    from TEST.PUBLIC_stg_shopify.stg_shopify__tax_line

), shipping as (

    select
        *
    from __dbt__cte__int_shopify__order__shipping_aggregates

), tax_aggregates as (

    select
        order_line_id,
        source_relation,
        sum(price) as price

    from tax
    group by 1,2

), order_line_aggregates as (

    select 
        order_line.order_id,
        order_line.source_relation,
        count(*) as line_item_count,
        sum(order_line.quantity) as order_total_quantity,
        sum(tax_aggregates.price) as order_total_tax,
        sum(order_line.total_discount) as order_total_discount

    from order_line
    left join tax_aggregates
        on tax_aggregates.order_line_id = order_line.order_line_id
        and tax_aggregates.source_relation = order_line.source_relation
    group by 1,2

), final as (

    select
        order_line_aggregates.order_id,
        order_line_aggregates.source_relation,
        order_line_aggregates.line_item_count,
        order_line_aggregates.order_total_quantity,
        order_line_aggregates.order_total_tax,
        order_line_aggregates.order_total_discount,
        shipping.shipping_price as order_total_shipping,
        shipping.discounted_shipping_price as order_total_shipping_with_discounts,
        shipping.shipping_tax as order_total_shipping_tax

    from order_line_aggregates
    left join shipping
        on shipping.order_id = order_line_aggregates.order_id
        and shipping.source_relation = order_line_aggregates.source_relation
)

select *
from final






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
), validation_errors as (

    select
        variant_id, location_id, source_relation
    from __dbt__cte__int_shopify__inventory_level__aggregates
    group by variant_id, location_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



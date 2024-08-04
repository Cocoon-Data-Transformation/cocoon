with  __dbt__cte__int_shopify__products_with_aggregates as (
with products as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__product
), 

collection_product as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__collection_product
),

collection as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__collection
    where not coalesce(is_deleted, false) -- limit to only active collections
),

product_tag as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_tag
),

product_variant as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_variant
),

product_image as (

    select *
    from TEST.PUBLIC_stg_shopify.stg_shopify__product_image
),


collections_aggregated as (

    select
        collection_product.product_id,
        collection_product.source_relation,
        
    listagg(collection.title, ', ')

 as collections
    from collection_product 
    join collection 
        on collection_product.collection_id = collection.collection_id
        and collection_product.source_relation = collection.source_relation
    group by 1,2
),

tags_aggregated as (

    select 
        product_id,
        source_relation,
        
    listagg(value, ', ')

 as tags
    
    from product_tag
    group by 1,2
),

variants_aggregated as (

    select 
        product_id,
        source_relation,
        count(variant_id) as count_variants

    from product_variant
    group by 1,2

),

images_aggregated as (

    select 
        product_id,
        source_relation,
        count(*) as count_images
    from product_image
    group by 1,2
),

joined as (

    select
        products.*,
        collections_aggregated.collections,
        tags_aggregated.tags,
        variants_aggregated.count_variants,
        coalesce(images_aggregated.count_images, 0) > 0 as has_product_image

    from products
    left join collections_aggregated
        on products.product_id = collections_aggregated.product_id
        and products.source_relation = collections_aggregated.source_relation
    left join tags_aggregated
        on products.product_id = tags_aggregated.product_id
        and products.source_relation = tags_aggregated.source_relation
    left join variants_aggregated
        on products.product_id = variants_aggregated.product_id
        and products.source_relation = variants_aggregated.source_relation
    left join images_aggregated
        on products.product_id = images_aggregated.product_id
        and products.source_relation = images_aggregated.source_relation
)

select *
from joined
),  __dbt__cte__int_shopify__product__order_line_aggregates as (
with order_lines as (

    select *
    from TEST.PUBLIC_shopify.shopify__order_lines

), orders as (

    select *
    from TEST.PUBLIC_shopify.shopify__orders

), product_aggregated as (
    select 
        order_lines.product_id,
        order_lines.source_relation,

        -- moved over from shopify__products
        sum(order_lines.quantity) as quantity_sold,
        sum(order_lines.pre_tax_price) as subtotal_sold,
        sum(order_lines.quantity_net_refunds) as quantity_sold_net_refunds,
        sum(order_lines.subtotal_net_refunds) as subtotal_sold_net_refunds,
        min(orders.created_timestamp) as first_order_timestamp,
        max(orders.created_timestamp) as most_recent_order_timestamp,

        -- new columns
        sum(order_lines.total_discount) as product_total_discount,
        sum(order_lines.order_line_tax) as product_total_tax,
        avg(order_lines.quantity) as avg_quantity_per_order_line,
        avg(order_lines.total_discount) as product_avg_discount_per_order_line,
        avg(order_lines.order_line_tax) as product_avg_tax_per_order_line

    from order_lines
    left join orders
        on order_lines.order_id = orders.order_id
        and order_lines.source_relation = orders.source_relation
    group by 1,2

)

select *
from product_aggregated
), products as (

    select *
    from __dbt__cte__int_shopify__products_with_aggregates

), product_order_lines as (

    select *
    from __dbt__cte__int_shopify__product__order_line_aggregates

), joined as (

    select
        products.*,
        coalesce(product_order_lines.quantity_sold,0) as total_quantity_sold,
        coalesce(product_order_lines.subtotal_sold,0) as subtotal_sold,
        coalesce(product_order_lines.quantity_sold_net_refunds,0) as quantity_sold_net_refunds,
        coalesce(product_order_lines.subtotal_sold_net_refunds,0) as subtotal_sold_net_refunds,
        product_order_lines.first_order_timestamp,
        product_order_lines.most_recent_order_timestamp,
        product_order_lines.avg_quantity_per_order_line as avg_quantity_per_order_line,
        coalesce(product_order_lines.product_total_discount,0) as product_total_discount,
        product_order_lines.product_avg_discount_per_order_line as product_avg_discount_per_order_line,
        coalesce(product_order_lines.product_total_tax,0) as product_total_tax,
        product_order_lines.product_avg_tax_per_order_line as product_avg_tax_per_order_line

    from products
    left join product_order_lines
        on products.product_id = product_order_lines.product_id
        and products.source_relation = product_order_lines.source_relation
)

select *
from joined
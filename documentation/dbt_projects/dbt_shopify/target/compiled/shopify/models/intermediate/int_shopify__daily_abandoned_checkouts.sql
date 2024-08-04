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
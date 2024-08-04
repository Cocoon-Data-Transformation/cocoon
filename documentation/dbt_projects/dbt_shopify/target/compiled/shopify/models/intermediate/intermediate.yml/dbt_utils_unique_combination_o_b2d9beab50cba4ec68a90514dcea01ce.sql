





with validation_errors as (

    select
        email, source_relation
    from TEST.PUBLIC_shopify.int_shopify__customer_email_rollup
    group by email, source_relation
    having count(*) > 1

)

select *
from validation_errors



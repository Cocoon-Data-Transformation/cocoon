





with validation_errors as (

    select
        email, source_relation
    from TEST.PUBLIC_shopify.shopify__customer_emails
    group by email, source_relation
    having count(*) > 1

)

select *
from validation_errors



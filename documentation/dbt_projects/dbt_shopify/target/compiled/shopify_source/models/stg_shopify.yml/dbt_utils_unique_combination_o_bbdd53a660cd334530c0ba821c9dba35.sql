





with validation_errors as (

    select
        price_rule_id, source_relation
    from TEST.PUBLIC_stg_shopify.stg_shopify__price_rule
    group by price_rule_id, source_relation
    having count(*) > 1

)

select *
from validation_errors



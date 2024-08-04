
    
    

with all_values as (

    select
        value_type as value_field,
        count(*) as n_records

    from TEST.PUBLIC_stg_shopify.stg_shopify__price_rule
    group by value_type

)

select *
from all_values
where value_field not in (
    'percentage','fixed_amount'
)



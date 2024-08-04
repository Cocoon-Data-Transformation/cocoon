
    
    

with all_values as (

    select
        target_type as value_field,
        count(*) as n_records

    from TEST.PUBLIC_stg_shopify.stg_shopify__price_rule
    group by target_type

)

select *
from all_values
where value_field not in (
    'line_item','shipping_line'
)



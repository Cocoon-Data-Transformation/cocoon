
    
    

select
    order_lines_unique_key as unique_field,
    count(*) as n_records

from TEST.PUBLIC_shopify.shopify__order_lines
where order_lines_unique_key is not null
group by order_lines_unique_key
having count(*) > 1



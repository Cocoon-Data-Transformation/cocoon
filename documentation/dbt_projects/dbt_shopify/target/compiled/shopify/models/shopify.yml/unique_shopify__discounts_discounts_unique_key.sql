
    
    

select
    discounts_unique_key as unique_field,
    count(*) as n_records

from TEST.PUBLIC_shopify.shopify__discounts
where discounts_unique_key is not null
group by discounts_unique_key
having count(*) > 1



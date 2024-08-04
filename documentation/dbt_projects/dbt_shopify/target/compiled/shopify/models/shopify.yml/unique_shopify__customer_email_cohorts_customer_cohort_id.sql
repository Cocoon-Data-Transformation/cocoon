
    
    

select
    customer_cohort_id as unique_field,
    count(*) as n_records

from TEST.PUBLIC_shopify.shopify__customer_email_cohorts
where customer_cohort_id is not null
group by customer_cohort_id
having count(*) > 1



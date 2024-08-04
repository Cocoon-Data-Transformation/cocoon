

with engagements as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement



), contacts as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_contact

), contacts_agg as (

    select 
        engagement_id,
        
    array_agg(contact_id)
 as contact_ids
    from contacts
    group by 1





), deals as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_deal
 
), deals_agg as (

    select 
        engagement_id,
        
    array_agg(deal_id)
 as deal_ids
    from deals
    group by 1





), companies as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_company

), companies_agg as (

    select 
        engagement_id,
        
    array_agg(company_id)
 as company_ids
    from companies
    group by 1



), joined as (

    select 
         contacts_agg.contact_ids, 
         deals_agg.deal_ids, 
         companies_agg.company_ids, 
        engagements.*
    from engagements
     left join contacts_agg using (engagement_id) 
     left join deals_agg using (engagement_id) 
     left join companies_agg using (engagement_id) 

)

select *
from joined
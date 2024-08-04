

with companies as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__company



), engagements as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__engagements

), engagement_companies as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_company

), engagement_companies_joined as (

    select
        engagements.engagement_type,
        engagement_companies.company_id
    from engagements
    inner join engagement_companies
        using (engagement_id)

), engagement_companies_agg as (

    

    select
        company_id,
        count(case when engagement_type = 'NOTE' then company_id end) as count_engagement_notes,
        count(case when engagement_type = 'TASK' then company_id end) as count_engagement_tasks,
        count(case when engagement_type = 'CALL' then company_id end) as count_engagement_calls,
        count(case when engagement_type = 'MEETING' then company_id end) as count_engagement_meetings,
        count(case when engagement_type = 'EMAIL' then company_id end) as count_engagement_emails,
        count(case when engagement_type = 'INCOMING_EMAIL' then company_id end) as count_engagement_incoming_emails,
        count(case when engagement_type = 'FORWARDED_EMAIL' then company_id end) as count_engagement_forwarded_emails
    from engagement_companies_joined
    group by 1



), joined as (

    select 
        companies.*,
        
        coalesce(engagement_companies_agg.count_engagement_notes,0) as count_engagement_notes ,
        
        coalesce(engagement_companies_agg.count_engagement_tasks,0) as count_engagement_tasks ,
        
        coalesce(engagement_companies_agg.count_engagement_calls,0) as count_engagement_calls ,
        
        coalesce(engagement_companies_agg.count_engagement_meetings,0) as count_engagement_meetings ,
        
        coalesce(engagement_companies_agg.count_engagement_emails,0) as count_engagement_emails ,
        
        coalesce(engagement_companies_agg.count_engagement_incoming_emails,0) as count_engagement_incoming_emails ,
        
        coalesce(engagement_companies_agg.count_engagement_forwarded_emails,0) as count_engagement_forwarded_emails 
        
    from companies
    left join engagement_companies_agg
        using (company_id)

)

select *
from joined


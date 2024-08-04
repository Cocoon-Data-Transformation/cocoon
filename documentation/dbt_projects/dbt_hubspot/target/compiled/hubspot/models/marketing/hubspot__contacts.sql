



with  __dbt__cte__int_hubspot__engagement_metrics__by_contact as (


with engagements as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__engagements

), engagement_contacts as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_contact

), engagement_contacts_joined as (

    select
        engagements.engagement_type,
        engagement_contacts.contact_id
    from engagements
    inner join engagement_contacts
        using (engagement_id)

), engagement_contacts_agg as (

    

    select
        contact_id,
        count(case when engagement_type = 'NOTE' then contact_id end) as count_engagement_notes,
        count(case when engagement_type = 'TASK' then contact_id end) as count_engagement_tasks,
        count(case when engagement_type = 'CALL' then contact_id end) as count_engagement_calls,
        count(case when engagement_type = 'MEETING' then contact_id end) as count_engagement_meetings,
        count(case when engagement_type = 'EMAIL' then contact_id end) as count_engagement_emails,
        count(case when engagement_type = 'INCOMING_EMAIL' then contact_id end) as count_engagement_incoming_emails,
        count(case when engagement_type = 'FORWARDED_EMAIL' then contact_id end) as count_engagement_forwarded_emails
    from engagement_contacts_joined
    group by 1



)

select *
from engagement_contacts_agg
), contacts as (

    select *
    from TEST.PUBLIC_hubspot.int_hubspot__contact_merge_adjust 


), email_sends as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__email_sends

), email_metrics as (
    
    select 
        recipient_email_address,
        
    from email_sends
    group by 1

), email_joined as (

    select 
        contacts.*,
        
    from contacts
    left join email_metrics
        on contacts.email = email_metrics.recipient_email_address







), engagements as (

    select *
    from __dbt__cte__int_hubspot__engagement_metrics__by_contact

), engagements_joined as (

    select 
        email_joined.*,
        
        coalesce(engagements.count_engagement_notes,0) as count_engagement_notes ,
        
        coalesce(engagements.count_engagement_tasks,0) as count_engagement_tasks ,
        
        coalesce(engagements.count_engagement_calls,0) as count_engagement_calls ,
        
        coalesce(engagements.count_engagement_meetings,0) as count_engagement_meetings ,
        
        coalesce(engagements.count_engagement_emails,0) as count_engagement_emails ,
        
        coalesce(engagements.count_engagement_incoming_emails,0) as count_engagement_incoming_emails ,
        
        coalesce(engagements.count_engagement_forwarded_emails,0) as count_engagement_forwarded_emails 
        
    from email_joined
    left join engagements
        using (contact_id)

)

select *
from engagements_joined




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
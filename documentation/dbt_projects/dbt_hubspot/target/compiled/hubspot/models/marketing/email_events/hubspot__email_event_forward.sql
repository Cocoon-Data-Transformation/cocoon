



with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event_forward

), events as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__email_event


), contacts as (

    select *
    from TEST.PUBLIC_hubspot.int_hubspot__contact_merge_adjust 


), events_joined as (

    select 
        base.*,
        events.created_timestamp,
        events.email_campaign_id,
        events.recipient_email_address,
        events.sent_timestamp as email_send_timestamp,
        events.sent_by_event_id as email_send_id
    from base
    left join events
        using (event_id)


), contacts_joined as (

    select 
        events_joined.*,
        contacts.contact_id,
        coalesce(contacts.is_contact_deleted, false) as is_contact_deleted
    from events_joined
    left join contacts
        on events_joined.recipient_email_address = contacts.email

)

select *
from contacts_joined



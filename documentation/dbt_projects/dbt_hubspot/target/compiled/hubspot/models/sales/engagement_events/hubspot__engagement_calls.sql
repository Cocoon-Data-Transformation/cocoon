



with base as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__engagement_call

), engagements as (

    select *
    from TEST.PUBLIC_hubspot.hubspot__engagements

), joined as (

    select 
        
*
/* No columns were returned. Maybe the relation doesn't exist yet 
or all columns were excluded. This star is only output during  
dbt compile, and exists to keep SQLFluff happy. */
            ,
         engagements.contact_ids, 
         engagements.deal_ids, 
         engagements.company_ids, 
        coalesce(engagements.is_active, not base._fivetran_deleted) as is_active,
        coalesce(engagements.created_timestamp, base.created_timestamp) as created_timestamp,
        coalesce(engagements.occurred_timestamp, base.occurred_timestamp) as occurred_timestamp,
        coalesce(engagements.owner_id, base.owner_id) as owner_id
    from base
    left join engagements
        on base.engagement_id = engagements.engagement_id

)

select *
from joined


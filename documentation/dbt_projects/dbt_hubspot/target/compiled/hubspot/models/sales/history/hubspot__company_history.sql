

with history as (

    select *
    from TEST.PUBLIC_stg_hubspot.stg_hubspot__company_property_history

), windows as (

    select
        company_id,
        field_name,
        change_source,
        change_source_id,
        change_timestamp as valid_from,
        new_value,
        lead(change_timestamp) over (partition by company_id, field_name order by change_timestamp) as valid_to
    from history

), surrogate as (

    select 
        windows.*,
        md5(cast(coalesce(cast(field_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(company_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(valid_from as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as id
    from windows

)

select *
from surrogate
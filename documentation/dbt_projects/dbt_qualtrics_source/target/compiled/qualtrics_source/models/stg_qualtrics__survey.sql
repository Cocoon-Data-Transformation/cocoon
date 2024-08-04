with base as (

    select * 
    from TEST.PUBLIC_qualtrics_source.stg_qualtrics__survey_tmp
),

fields as (

    select
        
    cast(null as boolean) as 
    
    _fivetran_deleted
    
 , 
    cast(null as timestamp) as 
    
    _fivetran_synced
    
 , 
    cast(null as TEXT) as 
    
    auto_scoring_category
    
 , 
    cast(null as TEXT) as 
    
    brand_base_url
    
 , 
    cast(null as TEXT) as 
    
    brand_id
    
 , 
    cast(null as TEXT) as 
    
    bundle_short_name
    
 , 
    cast(null as TEXT) as 
    
    composition_type
    
 , 
    cast(null as TEXT) as 
    
    creator_id
    
 , 
    cast(null as TEXT) as 
    
    default_scoring_category
    
 , 
    cast(null as TEXT) as 
    
    division_id
    
 , 
    cast(null as TEXT) as 
    
    id
    
 , 
    cast(null as timestamp) as 
    
    last_accessed
    
 , 
    cast(null as timestamp) as 
    
    last_activated
    
 , 
    cast(null as timestamp) as 
    
    last_modified
    
 , 
    cast(null as TEXT) as 
    
    owner_id
    
 , 
    cast(null as TEXT) as 
    
    project_category
    
 , 
    cast(null as TEXT) as 
    
    project_type
    
 , 
    cast(null as TEXT) as 
    
    registry_sha
    
 , 
    cast(null as TEXT) as 
    
    registry_version
    
 , 
    cast(null as TEXT) as 
    
    schema_version
    
 , 
    cast(null as boolean) as 
    
    scoring_summary_after_questions
    
 , 
    cast(null as boolean) as 
    
    scoring_summary_after_survey
    
 , 
    cast(null as TEXT) as 
    
    scoring_summary_category
    
 , 
    cast(null as TEXT) as 
    
    survey_name
    
 , 
    cast(null as TEXT) as 
    
    survey_status
    
 



        


, cast('' as TEXT) as source_relation



            
    from base
),

final as (
    
    select 
        id as survey_id,
        survey_name,
        survey_status,
        brand_base_url,
        brand_id,
        bundle_short_name,
        composition_type,
        auto_scoring_category,
        default_scoring_category,
        division_id,
        creator_id as creator_user_id,
        owner_id as owner_user_id,
        project_category,
        project_type,
        registry_sha,
        registry_version,
        schema_version,
        scoring_summary_after_questions,
        scoring_summary_after_survey,
        scoring_summary_category,
        cast(last_accessed as timestamp) as last_accessed_at,
        cast(last_activated as timestamp) as last_activated_at,
        cast(last_modified as timestamp) as last_modified_at,
        _fivetran_deleted as is_deleted,
        _fivetran_synced,
        source_relation

        





    from fields
)

select *
from final
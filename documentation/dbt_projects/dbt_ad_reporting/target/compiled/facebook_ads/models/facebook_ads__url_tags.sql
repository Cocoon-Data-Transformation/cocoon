

with base as (

    select *
    from TEST.PUBLIC_facebook_ads_source.stg_facebook_ads__creative_history
    where is_most_recent_record = true
), 

required_fields as (

    select
        source_relation,
        _fivetran_id,
        creative_id,
        url_tags
    from base
    where url_tags is not null
), 



  cleaned_fields as (

      select
          source_relation,
          _fivetran_id,
          creative_id,
          parse_json(url_tags) as url_tags
      from required_fields
      where url_tags is not null
  ), 

  fields as (

      select
          source_relation,
          _fivetran_id,
          creative_id,
          url_tags.value:key::string as key,
          url_tags.value:value::string as value,
          url_tags.value:type::string as type
      from cleaned_fields,
      lateral flatten( input => url_tags ) as url_tags
  )

 

select *
from fields
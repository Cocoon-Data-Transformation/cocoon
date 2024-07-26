{{ config(enabled=var('ad_reporting__amazon_ads_enabled', True)) }}

{# This intermediate model creates a dummy portfolio table if the user does not use portfolios. 
If they are using them, the normal portfolio_history will be used. #}

with portfolios as (
    select
    {% if var('amazon_ads__portfolio_history_enabled', True) %}
        *
        from {{ var('portfolio_history') }}
        where is_most_recent_record = True
    {% else %}
        cast(null as {{ dbt.type_string() }}) as source_relation,
        {# uses the columns macro from the source package to populate column names #}
        {%- set columns = amazon_ads_source.get_portfolio_history_columns() -%}
        {% for column in columns %}
            {# set null for each column #}
            {%- if column['name'] == 'id' -%}
                cast(null as {{ dbt.type_string() }}) as portfolio_id
            {%- elif column['name'] == 'name' -%}
                cast(null as {{ dbt.type_string() }}) as portfolio_name
            {%- elif column['name'] == 'profile_id' -%}
                cast(null as {{ dbt.type_string() }}) as profile_id
            {%- else -%}
                cast(null as {{ column['datatype'] }}) as {{ column['name'] }}
            {%- endif -%}
            {# add comma if not the last column #}
            {%- if not loop.last -%} , {% endif -%}
        {% endfor %}
    {% endif %}
)

select * 
from portfolios
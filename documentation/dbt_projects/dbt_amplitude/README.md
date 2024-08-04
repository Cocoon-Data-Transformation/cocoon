<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_amplitude/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Amplitude Modeling dbt Package ([Docs](https://fivetran.github.io/dbt_amplitude/))

# 📣 What does this dbt package do?
- Produces modeled tables that leverage Amplitude data from [Fivetran's connector](https://fivetran.com/docs/applications/amplitude) in the format described by [this ERD](https://fivetran.com/docs/applications/amplitude#schemainformation) and builds off the output of our [Amplitude source package](https://github.com/fivetran/dbt_amplitude_source).

- Enables users to do the following:
  - Leverage event data that is enhanced with additional event type and pivoted custom property fields for later downstream use
  - View aggregated metrics for each unique session
  - View aggregated metrics for each unique user
  - View daily performance metrics for each event type
  - Use the enhanced event data to leverage dbt metrics to generate additional analytics
  - Incorporate the [dbt Product Analytics](https://github.com/mjirv/dbt_product_analytics) package to further enhance Amplitude data, like for funnel and retention analysis

<!--section="amplitude_transformation_model"-->
This package also generates a comprehensive data dictionary of your source and modeled Amplitude data through the [dbt docs site](https://fivetran.github.io/dbt_amplitude/). You can also refer to the table below for a detailed view of all models materialized within this package by default.

|**model**|**description**
-----|-----
| [amplitude__event_enhanced](https://fivetran.github.io/dbt_amplitude/#!/model/model.amplitude.amplitude__event_enhanced)     | Each record represents event data, enhanced with event type data and unnested event, group, and user properties. 
| [amplitude__sessions](https://fivetran.github.io/dbt_amplitude/#!/model/model.amplitude.amplitude__sessions)         | Each record represents a distinct session with aggregated metrics for that session.
| [amplitude__user_enhanced](https://fivetran.github.io/dbt_amplitude/#!/model/model.amplitude.amplitude__user_enhanced)               | Each record represents a distinct user with aggregated metrics for that user.
| [amplitude__daily_performance](https://fivetran.github.io/dbt_amplitude/#!/model/model.amplitude.amplitude__daily_performance)               | Each record represents performance metrics for each distinct day and event type.

<!--section-end-->

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Amplitude connector syncing data into your destination. 
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

### Databricks dispatch configuration
If you are using a Databricks destination with this package, you must add the following (or a variation of the following) dispatch configuration within your `dbt_project.yml` file. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 2: Install the package
Include the following Amplitude package version in your `packages.yml` file:
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/amplitude
    version: [">=0.4.0", "<0.5.0"] # we recommend using ranges to capture non-breaking changes automatically
```

Do NOT include the `amplitude_source` package in this file. The transformation package itself has a dependency on it and will install the source package as well.

## Step 3: Define database and schema variables
By default, this package will run using your target database and the `amplitude` schema. If this is not where your Amplitude data is, add the following configuration to your root `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    amplitude_database: your_database_name    
    amplitude_schema: your_schema_name
```
## Step 4: Configure event date range
Because of the typical volume of event data, you may want to limit this package's models to work with a recent date range. However, note that the `amplitude__daily_performance`, `amplitude__event_enhanced`, and `amplitude__sessions` final models are materialized as incremental tables.

The default date range for the [stg_amplitude__event](https://github.com/fivetran/dbt_amplitude_source/blob/main/models/stg_amplitude__event.sql) model starts at '2020-01-01' and ends one month past the current day. Conversely, for the [date spine](https://github.com/fivetran/dbt_amplitude/blob/main/models/intermediate/int_amplitude__date_spine.sql) model in this package the default date range starts at `2020-01-01` and ends one day after the current day. To customize the date range, add the following configurations to your root `dbt_project.yml` file:
```yml
# dbt_project.yml
...
vars:
    amplitude__date_range_start: '2022-01-01' # your start date here
    amplitude__date_range_end: '2022-12-01' # your end date here
```
If you adjust the date range variables, we recommend running `dbt run --full-refresh` to ensure no data quality issues within the adjusted date range.
## (Optional) Step 5: Additional configurations
<details><summary>Expand for configurations</summary>

### Change source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See the package's source [`dbt_project.yml`](https://github.com/fivetran/dbt_amplitude_source/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
# dbt_project.yml
...
config-version: 2
vars:
    <package_name>__<default_source_table_name>_identifier: your_table_name
```

### Change build schema
By default, this package builds the GitHub staging models within a schema titled (<target_schema> + `_stg_amplitude`) in your target database. If this is not where you would like your GitHub staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
# dbt_project.yml
models:
    amplitude_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```
### Pivot out nested fields containing custom properties
The Amplitude schema allows for custom properties to be passed as nested fields (for example, `user_properties: {"Cohort":"Test A"}`). To pivot out the properties, add the following configurations to your root `dbt_project.yml` file:
```yml
# dbt_project.yml
...
vars:
    event_properties_to_pivot: ['event_property_1','event_property_2']
    group_properties_to_pivot: ['group_property_1','group_property_2']
    user_properties_to_pivot: ['user_property_1','user_property_2']
```
</details>
<br>

## (Optional) Step 6: Using this package with the dbt Product Analytics package
<details><summary>Expand for configurations</summary>

The [dbt_product_analytics](https://github.com/mjirv/dbt_product_analytics) package contains macros that allows for further exploration such as event flow, funnel, and retention analysis. To leverage this in conjunction with this package, add the following configuration to your project's `packages.yml` file:
```yml
packages:
  - package: mjirv/dbt_product_analytics
    version: [">=0.1.0"]
```

Refer to the [dbt_product_analytics](https://github.com/mjirv/dbt_product_analytics) usage instructions and the example below:
```sql
-- # product_analytics_funnel.sql
{% set events =
  dbt_product_analytics.event_stream(
    from=ref('amplitude__event_enhanced'),
    event_type_col="event_type",
    user_id_col="amplitude_user_id",
    date_col="event_day",
    start_date="your_start_date",
    end_date="your_end_date")
%}

{% set steps = ["event_type_1", "event_type_2", "event_type_3"] %}

{{ dbt_product_analytics.funnel(steps=steps, event_stream=events) }}

```

</details>
<br>

## (Optional) Step 7: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand for details</summary>
<br>

Fivetran offers the ability for you to orchestrate your dbt project through the [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt) product. Refer to the linked docs for more information on how to setup your project for orchestration through Fivetran. 


</details>

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
```yml
packages:
    - package: fivetran/amplitude_source
      version: [">=0.3.0", "<0.4.0"]

    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]

    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package **only** maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/amplitude/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_amplitude/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Opinionated Decisions
In creating this package, which is meant for a wide range of use cases, we had to take opinionated stances on a few different questions we came across during development. We've consolidated significant choices we made in the [DECISIONLOG.md](https://github.com/fivetran/dbt_amplitude/blob/main/DECISIONLOG.md), and will continue to update as the package evolves. We are always open to and encourage feedback on these choices, and the package in general.

## Contributions
These dbt packages are developed by a small team of analytics engineers at Fivetran. However, the packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package!

# 🏪 Are there any resources available?
- If you encounter any questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_amplitude/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran, or would like to request a future dbt package to be developed, then feel free to fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to just say hi? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or send us an email at solutions@fivetran.com.

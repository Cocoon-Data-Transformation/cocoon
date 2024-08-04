<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_linkedin/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
    <a alt="Fivetran Quickstart Compatible"
        href="https://fivetran.com/docs/transformations/dbt/quickstart">
        <img src="https://img.shields.io/badge/Fivetran_Quickstart_Compatible%3F-yes-green.svg" /></a>
</p>

# LinkedIn Ad Analytics Transformation dbt Package ([docs](https://fivetran.github.io/dbt_linkedin/))
# 📣 What does this dbt package do?
- Produces modeled tables that leverage Linkedin Ad Analytics data from [Fivetran's connector](https://fivetran.com/docs/applications/linkedin-ads) in the format described by [this ERD](https://fivetran.com/docs/applications/linkedin-ads#schemainformation) and builds off the output of our [Linkedin Ads source package](https://github.com/fivetran/dbt_linkedin_source).
- Enables you to better understand the performance of your ads across varying grains:
  - Providing an account, campaign (ad groups in other ad platforms), campaign group (campaigns in other ad platforms), creative, and utm/url level reports.
- Materializes output models designed to work simultaneously with our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting).
- Generates a comprehensive data dictionary of your source and modeled Linkedin Ad Analytics data through the [dbt docs site](https://fivetran.github.io/dbt_linkedin/).

<!--section="linkedin_ads_transformation_model"-->
The following table provides a detailed list of all models materialized within this package by default. 
> TIP: See more details about these models in the package's [dbt docs site](https://fivetran.github.io/dbt_linkedin/#!/overview?g_v=1&g_e=seeds).

| **Model**                          | **Description**                                                                                                        |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| [linkedin_ads__account_report](https://github.com/fivetran/dbt_linkedin/blob/main/models/linkedin_ads__account_report.sql)        | Each record represents the daily ad performance of each account.                                                       |
| [linkedin_ads__campaign_report](https://github.com/fivetran/dbt_linkedin/blob/main/models/linkedin_ads__campaign_report.sql)       | Each record represents the daily ad performance of each campaign. Linkedin campaigns map onto ad groups in other ad platforms.                                                      |
| [linkedin_ads__campaign_group_report](https://github.com/fivetran/dbt_linkedin/blob/main/models/linkedin_ads__campaign_group_report.sql) | Each record represents the daily ad performance of each campaign group. Linkedin                                                 |
| [linkedin_ads__creative_report](https://github.com/fivetran/dbt_linkedin/blob/main/models/linkedin_ads__creative_report.sql) | Each record represents the daily ad performance of each creative.                                                |
| [linkedin_ads__url_report](https://github.com/fivetran/dbt_linkedin/blob/main/models/linkedin_ads__url_report.sql) | Each record represents the daily ad performance of each url.                                                |
<!--section-end-->

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Linkedin Ad Analytics onnector syncing data into your destination. 
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

### Databricks Dispatch Configuration
If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 2: Install the package
Include the following Linkedin Ads package version in your `packages.yml` file:
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages
```yml
# packages.yml
packages:
  - package: fivetran/linkedin
    version: [">=0.8.0", "<0.9.0"]
```
Do **NOT** include the `linkedin_source` package in this file. The transformation package itself has a dependency on it and will install the source package as well. 

## Step 3: Define database and schema variables
By default, this package runs using your destination and the `linkedin_ads` schema. If this is not where your Linkedin Ad Analytics data is (for example, if your Linkedin schema is named `linkedin_ads_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
# dbt_project.yml
vars:
    linkedin_ads_schema: your_schema_name
    linkedin_ads_database: your_destination_name 
```

## (Optional) Step 4: Additional configurations
### Union multiple connectors
If you have multiple linkedin connectors in Fivetran and would like to use this package on all of them simultaneously, we have provided functionality to do so. The package will union all of the data together and pass the unioned table into the transformations. You will be able to see which source it came from in the `source_relation` column of each model. To use this functionality, you will need to set either the `linkedin_ads_union_schemas` OR `linkedin_ads_union_databases` variables (cannot do both) in your root `dbt_project.yml` file:

```yml
vars:
    linkedin_ads_union_schemas: ['linkedin_usa','linkedin_canada'] # use this if the data is in different schemas/datasets of the same database/project
    linkedin_ads_union_databases: ['linkedin_usa','linkedin_canada'] # use this if the data is in different databases/projects but uses the same schema name
```
Please be aware that the native `source.yml` connection set up in the package will not function when the union schema/database feature is utilized. Although the data will be correctly combined, you will not observe the sources linked to the package models in the Directed Acyclic Graph (DAG). This happens because the package includes only one defined `source.yml`.

To connect your multiple schema/database sources to the package models, follow the steps outlined in the [Union Data Defined Sources Configuration](https://github.com/fivetran/dbt_fivetran_utils/tree/releases/v0.4.latest#union_data-source) section of the Fivetran Utils documentation for the union_data macro. This will ensure a proper configuration and correct visualization of connections in the DAG.

### Switching to Local Currency
Additionally, the package allows you to select whether you want to add in costs in USD or the local currency of the ad. By default, the package uses USD. If you would like to have costs in the local currency, add the following variable to your `dbt_project.yml` file:

```yml
# dbt_project.yml
vars:
    linkedin_ads__use_local_currency: True # false by default -- uses USD
```

### Passing Through Additional Metrics
By default, this package will select `clicks`, `impressions`, and `cost` from the source reporting tables to store into the staging models. If you would like to pass through additional metrics to the staging models, add the below configurations to your `dbt_project.yml` file. These variables allow for the pass-through fields to be aliased (`alias`) if desired, but not required. Use the below format for declaring the respective pass-through variables:

>**Note** Please ensure you exercised due diligence when adding metrics to these models. The metrics added by default (taps, impressions, and spend) have been vetted by the Fivetran team maintaining this package for accuracy. There are metrics included within the source reports, for example metric averages, which may be inaccurately represented at the grain for reports created in this package. You will want to ensure whichever metrics you pass through are indeed appropriate to aggregate at the respective reporting levels provided in this package.

```yml
# dbt_project.yml
vars:
    linkedin_ads__campaign_passthrough_metrics: # pulls from ad_analytics_by_campaign
        - name: "new_custom_field"
          alias: "custom_field"
        - name: "unique_int_field"
          alias: "field_id"
        - name: "that_field"
    linkedin_ads__creative_passthrough_metrics: # pulls from ad_analytics_by_creative
        - name: "new_custom_field"
          alias: "custom_field"
        - name: "unique_int_field"
```
### Changing the Build Schema
By default this package will build the LinkedIn Ad Analytics staging models within a schema titled (<target_schema> + `_linkedin_ads_source`) and the LinkedIn Ad Analytics final models within a schema titled (<target_schema> + `_linkedin_ads`) in your target database. If this is not where you would like your modeled LinkedIn data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml
models:
    linkedin:
      +schema: my_new_schema_name # leave blank for just the target_schema
    linkedin_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_linkedin/blob/main/dbt_project.yml) variable declarations to see the expected names.
    
```yml
# dbt_project.yml
vars:
    linkedin_ads_<default_source_table_name>_identifier: your_table_name 
```

## (Optional) Step 5: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand for more details</summary>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).

</details>

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
```yml
packages:
    - package: fivetran/linkedin_source
      version: [">=0.8.0", "<0.9.0"]
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]
    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]
    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```

# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/linkedin/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_linkedin/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions!

# 🏪 Are there any resources available?
- If you have questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_linkedin/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to be part of the community discourse? Create a post in the [Fivetran community](https://community.fivetran.com/t5/user-group-for-dbt/gh-p/dbt-user-group) and our team along with the community can join in on the discussion!

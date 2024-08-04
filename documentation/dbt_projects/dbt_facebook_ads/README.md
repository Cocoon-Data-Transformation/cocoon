<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_facebook_ads/blob/main/LICENSE">
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

# Facebook Ads Transformation dbt Package ([Docs](https://fivetran.github.io/dbt_facebook_ads/))
# 📣 What does this dbt package do?
- Produces modeled tables that leverage Facebook Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/facebook-ads) in the format described by [this ERD](https://fivetran.com/docs/applications/facebook-ads#schemainformation) and builds off the output of our [Facebook Ads source package](https://github.com/fivetran/dbt_facebook_ads_source).
- Enables you to better understand the performance of your ads across varying grains:
  - Providing an account, campaign, ad group, keyword, ad, and utm level reports.
- Materializes output models designed to work simultaneously with our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting).
- Generates a comprehensive data dictionary of your source and modeled Facebook Ads data through the [dbt docs site](https://fivetran.github.io/dbt_facebook_ads/).

<!--section="facebook_ads_transformation_model"-->
The following table provides a detailed list of all models materialized within this package by default. 
> TIP: See more details about these models in the package's [dbt docs site](https://fivetran.github.io/dbt_facebook_ads/#!/overview?g_v=1&g_e=seeds).

| **Model**                | **Description**                                                                                                                                |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| [facebook_ads__account_report](https://fivetran.github.io/dbt_facebook_ads/#!/model/model.facebook_ads.facebook_ads__account_report)             | Each record in this table represents the daily performance at the account level. |
| [facebook_ads__campaign_report](https://fivetran.github.io/dbt_facebook_ads/#!/model/model.facebook_ads.facebook_ads__campaign_report)            | Each record in this table represents the daily performance of a campaign at the campaign/advertising_channel/advertising_channel_subtype level. |
| [facebook_ads__ad_set_report](https://fivetran.github.io/dbt_facebook_ads/#!/model/model.facebook_ads.facebook_ads__ad_set_report)            | Each record in this table represents the daily performance at the ad set level. |
| [facebook_ads__ad_report](https://fivetran.github.io/dbt_facebook_ads/#!/model/model.facebook_ads.facebook_ads__ad_report)            | Each record in this table represents the daily performance at the ad level. |
| [facebook_ads__utm_report](https://fivetran.github.io/dbt_facebook_ads/#!/model/model.facebook_ads.facebook_ads__utm_report)            | Each record in this table represents the daily performance of URLs at the ad level. |
<!--section-end-->

# 🎯 How do I use the dbt package?

## Step 1: Prerequisites
To use this dbt package, you must have the following:

- At least one Fivetran Facebook Ads connector syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.
- You will need to configure your Facebook Ads connector to pull the `basic_ad` pre-built report. This pre-built report should be enabled in your connector by default. However, to confirm this pre-built report is actively syncing you may perform the following steps:
    1. Navigate to the connector schema tab.
    2. Search for `basic_ad` and confirm it is selected.
    3. If not selected, do so and sync. If already selected you are ready to run the models!

### Databricks Dispatch Configuration
If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 2: Install the package
Include the following facebook_ads package version in your `packages.yml` file:
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/facebook_ads
    version: [">=0.7.0", "<0.8.0"] # we recommend using ranges to capture non-breaking changes automatically
```

Do NOT include the `facebook_ads_source` package in this file. The transformation package itself has a dependency on it and will install the source package as well.

## Step 3: Define database and schema variables
By default, this package runs using your destination and the `facebook_ads` schema. If this is not where your Facebook Ads data is (for example, if your Facebook Ads schema is named `facebook_ads_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    facebook_ads_database: your_destination_name
    facebook_ads_schema: your_schema_name 
```

## (Optional) Step 4: Additional configurations

### Union multiple connectors
If you have multiple facebook_ads connectors in Fivetran and would like to use this package on all of them simultaneously, we have provided functionality to do so. The package will union all of the data together and pass the unioned table into the transformations. You will be able to see which source it came from in the `source_relation` column of each model. To use this functionality, you will need to set either the `facebook_ads_union_schemas` OR `facebook_ads_union_databases` variables (cannot do both) in your root `dbt_project.yml` file:

```yml
vars:
    facebook_ads_union_schemas: ['facebook_ads_usa','facebook_ads_canada'] # use this if the data is in different schemas/datasets of the same database/project
    facebook_ads_union_databases: ['facebook_ads_usa','facebook_ads_canada'] # use this if the data is in different databases/projects but uses the same schema name
```
Please be aware that the native `source.yml` connection set up in the package will not function when the union schema/database feature is utilized. Although the data will be correctly combined, you will not observe the sources linked to the package models in the Directed Acyclic Graph (DAG). This happens because the package includes only one defined `source.yml`.

To connect your multiple schema/database sources to the package models, follow the steps outlined in the [Union Data Defined Sources Configuration](https://github.com/fivetran/dbt_fivetran_utils/tree/releases/v0.4.latest#union_data-source) section of the Fivetran Utils documentation for the union_data macro. This will ensure a proper configuration and correct visualization of connections in the DAG.

### Passing Through Additional Metrics
By default, this package will select `clicks`, `impressions`, and `cost` from the source reporting tables to store into the staging models. If you would like to pass through additional metrics to the staging models, add the below configurations to your `dbt_project.yml` file. These variables allow for the pass-through fields to be aliased (`alias`) if desired, but not required. Use the below format for declaring the respective pass-through variables:

>**Note** Please ensure you exercised due diligence when adding metrics to these models. The metrics added by default (taps, impressions, and spend) have been vetted by the Fivetran team maintaining this package for accuracy. There are metrics included within the source reports, for example metric averages, which may be inaccurately represented at the grain for reports created in this package. You will want to ensure whichever metrics you pass through are indeed appropriate to aggregate at the respective reporting levels provided in this package.

```yml
vars:
    facebook_ads__basic_ad_passthrough_metrics: 
      - name: "new_custom_field"
        alias: "custom_field"
      - name: "another_one"
```
### Change the build schema
By default, this package builds the Facebook Ads staging models within a schema titled (`<target_schema>` + `_facebook_ads_source`) and your Facebook Ads modeling models within a schema titled (`<target_schema>` + `_facebook_ads`) in your destination. If this is not where you would like your Facebook Ads data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    facebook_ads_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
    facebook_ads:
      +schema: my_new_schema_name # leave blank for just the target_schema
```
    
### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:

> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_facebook_ads/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
vars:
    facebook_ads_<default_source_table_name>_identifier: your_table_name 
```

## (Optional) Step 5: Orchestrate your models with Fivetran Transformations for dbt Core™    
<details><summary>Expand for more details</summary>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).

</details>

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
    
```yml
packages:
    - package: fivetran/facebook_ads_source
      version: [">=0.7.0", "<0.8.0"]

    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]

    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/facebook_ads/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_facebook_ads/blob/main/CHANGELOG.md), [DECISIONLOG](https://github.com/fivetran/dbt_facebook_ads/blob/main/DECISIONLOG.md) and release notes for more information on changes across versions.

## Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package!

# 🏪 Are there any resources available?
- If you have questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_facebook_ads/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to be part of the community discourse? Create a post in the [Fivetran community](https://community.fivetran.com/t5/user-group-for-dbt/gh-p/dbt-user-group) and our team along with the community can join in on the discussion!

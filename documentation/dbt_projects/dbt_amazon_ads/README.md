<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_amazon_ads/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Amazon Ads dbt Package ([Docs](https://fivetran.github.io/dbt_amazon_ads/))
# 📣 What does this dbt package do?
- Produces modeled tables that leverage Amazon Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/amazon-ads) in the format described by [this ERD](https://fivetran.com/docs/applications/amazon-ads#schemainformation) and builds off the output of our [Amazon Ads source package](https://github.com/fivetran/dbt_amazon_ads_source).
- Provides insight into your ad performance across the following grains:
  - Account, portfolio, campaign, ad group, ad, keyword, and search term
- Materializes output models designed to work simultaneously with our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting).
- Generates a comprehensive data dictionary of your source and modeled Amazon Ads data through the [dbt docs site](https://fivetran.github.io/dbt_amazon_ads/).

The following table lists all models that are materialized within this package by default. 
> TIP: See more details about these models in the package's [dbt docs site](https://fivetran.github.io/dbt_amazon_ads/#!/overview?g_v=1&g_e=seeds).

| **Model**                | **Description**                                                                                                                                |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| [amazon_ads__account_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__account_report)             | Each record in this table represents the daily performance at the account level. |
| [amazon_ads__portfolio_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__portfolio_report)            | Each record in this table represents the daily performance at the portfolio level. |
| [amazon_ads__campaign_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__campaign_report)            | Each record in this table represents the daily performance at the campaign level. |
| [amazon_ads__ad_group_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__ad_group_report)            | Each record in this table represents the daily performance at the ad group level. |
| [amazon_ads__search_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__search_report)            | Each record in this table represents the daily performance at the search term level. |
| [amazon_ads__keyword_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__keyword_report)            | Each record in this table represents the daily performance at the keyword level. |
| [amazon_ads__ad_report](https://fivetran.github.io/dbt_amazon_ads/#!/model/model.amazon_ads.amazon_ads__ad_report)            | Each record in this table represents the daily performance at the ad level. 

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:

- At least one Fivetran Amazon Ads connector syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

### Databricks Dispatch Configuration
If you are using a Databricks destination with this package, you will need to add the following dispatch configuration (or a variation) within your `dbt_project.yml`. This is necessary to ensure that this package searches for macros in the `dbt-labs/spark_utils` package before searching the `dbt-labs/dbt_utils` package.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 2: Install the package
Include the following amazon_ads package version in your `packages.yml` file:
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read dbt's Package Management documentation](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/amazon_ads
    version: [">=0.3.0", "<0.4.0"] # we recommend using ranges to capture non-breaking changes automatically
```

Do NOT include the `amazon_ads_source` package in this file. The transformation package itself has a dependency on it and will install the source package as well.


## Step 3: Define database and schema variables
By default, this package uses your destination and the `amazon_ads` schema. If your Amazon Ads data is in a different database or schema (for example, if your Amazon Ads schema is named `amazon_ads_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    amazon_ads_database: your_destination_name
    amazon_ads_schema: your_schema_name 
```

## Step 4: Disable models for non-existent sources
Your Amazon Ads connector may not sync every table that this package expects. If you do not have the `PORTFOLIO_HISTORY` table synced, add the following variable to your root `dbt_project.yml` file:

```yml
vars:
    amazon_ads__portfolio_history_enabled: False   # Disable if you do not have the portfolio table. Default is True.
```

## (Optional) Step 5: Additional configurations
### Union multiple connectors
If you have multiple amazon_ads connectors in Fivetran and would like to use this package on all of them simultaneously, we have provided functionality to do so. The package will union all of the data together and pass the unioned table into the transformations. You will be able to see which source it came from in the `source_relation` column of each model. To use this functionality, you will need to set either the `amazon_ads_union_schemas` OR `amazon_ads_union_databases` variables (cannot do both) in your root `dbt_project.yml` file:

```yml
vars:
    amazon_ads_union_schemas: ['amazon_ads_usa','amazon_ads_canada'] # use this if the data is in different schemas/datasets of the same database/project
    amazon_ads_union_databases: ['amazon_ads_usa','amazon_ads_canada'] # use this if the data is in different databases/projects but uses the same schema name
```
Please be aware that the native `source.yml` connection set up in the package will not function when the union schema/database feature is utilized. Although the data will be correctly combined, you will not observe the sources linked to the package models in the Directed Acyclic Graph (DAG). This happens because the package includes only one defined `source.yml`.

To connect your multiple schema/database sources to the package models, follow the steps outlined in the [Union Data Defined Sources Configuration](https://github.com/fivetran/dbt_fivetran_utils/tree/releases/v0.4.latest#union_data-source) section of the Fivetran Utils documentation for the union_data macro. This will ensure a proper configuration and correct visualization of connections in the DAG.

### Passing Through Additional Metrics
By default, this package will select `clicks`, `impressions`, and `cost` from the source reporting tables to store into the staging models. If you would like to pass through additional metrics to the staging models, add the following configurations to your `dbt_project.yml` file. These variables allow the pass-through fields to be aliased (`alias`) if desired, but not required. Use the following format for declaring the respective pass-through variables:

> **Note** Ensure that you exercised due diligence when adding metrics to these models. The metrics added by default (clicks, impressions, and cost) have been vetted by the Fivetran team maintaining this package for accuracy. There are metrics included within the source reports, for example, metric averages, which may be inaccurately represented at the grain for reports created in this package. You want to ensure whichever metrics you pass through are indeed appropriate to aggregate at the respective reporting levels provided in this package.

```yml
vars:
    amazon_ads__campaign_passthrough_metrics: 
      - name: "new_custom_field"
        alias: "custom_field"
    amazon_ads__ad_group_passthrough_metrics:
      - name: "unique_string_field"
        alias: "field_id"
    amazon_ads__advertised_product_passthrough_metrics: 
      - name: "new_custom_field"
        alias: "custom_field"
      - name: "a_second_field"
    amazon_ads__targeting_keyword_passthrough_metrics:
      - name: "this_field"
    amazon_ads__search_term_ad_keyword_passthrough_metrics:
      - name: "unique_string_field"
        alias: "field_id"
```

### Changing the Build Schema
By default, this package will build the Amazon_ads staging models within a schema titled (<target_schema> + `amazon_ads_source`) in your destination. If this is not where you would like your Amazon Ads staging data to be written, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    amazon_ads_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
    amazon_ads:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:

> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_amazon_ads_source/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
vars:
    amazon_ads_<default_source_table_name>_identifier: your_table_name 
```
## (Optional) Step 6: Orchestrate your models with Fivetran Transformations for dbt Core™    
<details><summary>Expand for more details</summary>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).

</details>

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Be aware that these dependencies are installed by default within this package. For more information on these packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of the dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
    
```yml
packages:
    - package: fivetran/amazon_ads_source
      version: [">=0.3.0", "<0.4.0"]

    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/amazon_ads/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_amazon_ads/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Opinionated Decisions
In creating this package, which is meant for a wide range of use cases, we had to take opinionated stances on certain decisions, such as logic choices or column selection. Therefore, we have documented significant choices in the [DECISIONLOG.md](https://github.com/fivetran/dbt_amazon_ads/blob/main/DECISIONLOG.md) and will continue to update this as the package evolves. We are always open to and encourage feedback on these choices and the package in general.

## Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, these packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package!

# 🏪 Are there any resources available?
- If you have questions or want to reach out for help, refer to the [GitHub Issue](https://github.com/fivetran/dbt_amazon_ads/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to just say hi? Book a time during our office hours [on Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com.

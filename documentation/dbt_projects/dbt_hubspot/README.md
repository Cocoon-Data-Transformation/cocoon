<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_hubspot/blob/main/LICENSE">
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

# HubSpot Transformation dbt Package ([Docs](https://fivetran.github.io/dbt_hubspot/))
# 📣 What does this dbt package do?
- Produces modeled tables that leverage HubSpot data from [Fivetran's connector](https://fivetran.com/docs/applications/hubspot) in the format described by [this ERD](https://fivetran.com/docs/applications/hubspot#schemainformation) and build off the output of our [HubSpot source package](https://github.com/fivetran/dbt_hubspot_source).
- Enables you to better understand your HubSpot email and engagement performance. The package achieves this by performing the following:
    - Generates models for contacts, companies, and deals with enriched email and engagement metrics.
    - Provides analysis-ready event tables for email and engagement activities.
- Generates a comprehensive data dictionary of your source and modeled HubSpot data through the [dbt docs site](https://fivetran.github.io/dbt_hubspot/).

<!--section="hubspot_transformation_model"-->
The following table provides a detailed list of all models materialized within this package by default.
> TIP: See more details about these models in the package's [dbt docs site](https://fivetran.github.io/dbt_hubspot/#!/overview?g_v=1).

| **model**                | **description**                                                                                                      |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------- |
| [hubspot__companies](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__companies)         | Each record represents a company in Hubspot, enriched with metrics about engagement activities.                      |
| [hubspot__company_history](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__company_history) | Each record represents a change to a company in Hubspot, with `valid_to` and `valid_from` information.               |
| [hubspot__contacts](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__contacts)        | Each record represents a contact in Hubspot, enriched with metrics about email and engagement activities.            |
| [hubspot__contact_history](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__contact_history) | Each record represents a change to a contact in Hubspot, with `valid_to` and `valid_from` information.               |
| [hubspot__contact_lists](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__contact_lists)   | Each record represents a contact list in Hubspot, enriched with metrics about email activities.                      |
| [hubspot__deals](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__deals)            | Each record represents a deal in Hubspot, enriched with metrics about engagement activities.                         |
| [hubspot__deal_stages](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__deal_stages)            | Each record represents when a deal stage changes in Hubspot, enriched with metrics about deal activities.                         |
| [hubspot__deal_history](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__deal_history)    | Each record represents a change to a deal in Hubspot, with `valid_to` and `valid_from` information.                  |
| [hubspot__tickets](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__tickets)    | Each record represents a ticket in Hubspot, enriched with metrics about engagement activities and information on associated deals, contacts, companies, and owners.                  |
| [hubspot__daily_ticket_history](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__daily_ticket_history)    | Each record represents a ticket's day in Hubspot with tracked properties pivoted out into columns.               |
| [hubspot__email_campaigns](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__email_campaigns) | Each record represents a email campaign in Hubspot, enriched with metrics about email activities.                    |
| [hubspot__email_event_*](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__email_event_bounce)   | Each record represents an email event in Hubspot, joined with relevant tables to make them analysis-ready.           |
| [hubspot__email_sends](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__email_sends)     | Each record represents a sent email in Hubspot, enriched with metrics about opens, clicks, and other email activity. |
| [hubspot__engagement_*](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__engagement_calls)    | Each record represents an engagement event in Hubspot, joined with relevant tables to make them analysis-ready.      |
<!--section-end-->

# 🎯 How do I use the dbt package?

## Step 1: Prerequisites
To use this dbt package, you must have the following:

- At least one Fivetran HubSpot connector syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

### Databricks Dispatch Configuration
If you are using a Databricks destination with this package you will need to add the below (or a variation of the below) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

### Database Incremental Strategies 
Some of the models (`+hubspot__daily_ticket_history`) in this package are materialized incrementally. We have chosen `insert_overwrite` as the default strategy for **BigQuery** and **Databricks** databases, as it is only available for these dbt adapters. For **Snowflake**, **Redshift**, and **Postgres** databases, we have chosen `delete+insert` as the default strategy.

`insert_overwrite` is our preferred incremental strategy because it will be able to properly handle updates to records that exist outside the immediate incremental window. That is, because it leverages partitions, `insert_overwrite` will appropriately update existing rows that have been changed upstream instead of inserting duplicates of them--all without requiring a full table scan.

`delete+insert` is our second-choice as it resembles `insert_overwrite` but lacks partitions. This strategy works most of the time and appropriately handles incremental loads that do not contain changes to past records. However, if a past record has been updated and is outside of the incremental window, `delete+insert` will insert a duplicate record. 😱
> Because of this, we highly recommend that **Snowflake**, **Redshift**, and **Postgres** users periodically run a `--full-refresh` to ensure a high level of data quality and remove any possible duplicates.

## Step 2: Install the package
Include the following hubspot package version in your `packages.yml` file:
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/hubspot
    version: [">=0.17.0", "<0.18.0"] # we recommend using ranges to capture non-breaking changes automatically

```
Do **NOT** include the `hubspot_source` package in this file. The transformation package itself has a dependency on it and will install the source package as well.

### Databricks dispatch configuration
If you are using a Databricks destination with this package, you must add the following (or a variation of the following) dispatch configuration within your `dbt_project.yml`. This is required in order for the package to accurately search for macros within the `dbt-labs/spark_utils` then the `dbt-labs/dbt_utils` packages respectively.
```yml
dispatch:
  - macro_namespace: dbt_utils
    search_order: ['spark_utils', 'dbt_utils']
```

## Step 3: Define database and schema variables
By default, this package runs using your destination and the `hubspot` schema. If this is not where your hubspot data is (for example, if your hubspot schema is named `hubspot_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    hubspot_database: your_destination_name
    hubspot_schema: your_schema_name
```

## Step 4: Disable models for non-existent sources
When setting up your Hubspot connection in Fivetran, it is possible that not every table this package expects will be synced. This can occur because you either don't use that functionality in Hubspot or have actively decided to not sync some tables. In order to disable the relevant functionality in the package, you will need to add the relevant variables. By default, all variables are assumed to be `true` (with exception of `hubspot_service_enabled`, `hubspot_ticket_deal_enabled`, `hubspot_contact_merge_audit_enabled`, and `hubspot_merged_deal_enabled`). You only need to add variables within your root `dbt_project.yml` for the tables you would like to disable or enable respectively:

```yml
vars:
  # Marketing

  hubspot_marketing_enabled: false                        # Disables all marketing models
  hubspot_contact_enabled: false                          # Disables the contact models
  hubspot_contact_list_enabled: false                     # Disables contact list models
  hubspot_contact_list_member_enabled: false              # Disables contact list member models
  hubspot_contact_property_enabled: false                 # Disables the contact property models
  hubspot_contact_property_history_enabled: false         # Disables the contact property history models
  hubspot_email_event_enabled: false                      # Disables all email_event models and functionality
  hubspot_email_event_bounce_enabled: false
  hubspot_email_event_click_enabled: false
  hubspot_email_event_deferred_enabled: false
  hubspot_email_event_delivered_enabled: false
  hubspot_email_event_dropped_enabled: false
  hubspot_email_event_forward_enabled: false
  hubspot_email_event_open_enabled: false
  hubspot_email_event_print_enabled: false
  hubspot_email_event_sent_enabled: false
  hubspot_email_event_spam_report_enabled: false
  hubspot_email_event_status_change_enabled: false

  hubspot_contact_merge_audit_enabled: true               # Enables the use of the CONTACT_MERGE_AUDIT table (deprecated by Hubspot v3 API) for removing merged contacts in the final models.
                                                          # If false, ~~~contacts will still be merged~~~, but using the CONTACT.property_hs_calculated_merged_vids field (introduced in v3 of the Hubspot CRM API)
                                                          # Default = false

  # Sales

  hubspot_sales_enabled: false                            # Disables all sales models
  hubspot_company_enabled: false
  hubspot_company_property_history_enabled: false         # Disables the company property history models
  hubspot_deal_enabled: false
  hubspot_merged_deal_enabled: true                       # Enables the merged_deal table, which will be used to filter out merged deals from the final deal models. False by default. Note that `hubspot_sales_enabled` and `hubspot_deal_enabled` must not be set to False.
  hubspot_deal_company_enabled: false
  hubspot_deal_contact_enabled: false
  hubspot_deal_property_history_enabled: false            # Disables the deal property history models
  hubspot_engagement_enabled: false                       # Disables all engagement models and functionality
  hubspot_engagement_contact_enabled: false
  hubspot_engagement_company_enabled: false
  hubspot_engagement_deal_enabled: false
  hubspot_engagement_call_enabled: false
  hubspot_engagement_email_enabled: false
  hubspot_engagement_meeting_enabled: false
  hubspot_engagement_note_enabled: false
  hubspot_engagement_task_enabled: false
  hubspot_owner_enabled: false
  hubspot_property_enabled: false                         # Disables property and property_option tables
  
  # Service
  hubspot_service_enabled: true                           # Enables all service/ticket models. Default = false
  hubspot_ticket_deal_enabled: true                       # Default = false
```
## (Optional) Step 5: Additional configurations

### Configure email metrics
This package allows you to specify which email metrics (total count and total unique count) you would like to be calculated for specified fields within the `hubspot__email_campaigns` model. By default, the `email_metrics` variable below includes all the shown fields. If you would like to remove any field metrics from the final model, you may copy and paste the below snippet within your root `dbt_project.yml` and remove any fields you want to be ignored in the final model.

```yml
vars:
  email_metrics: ['bounces',      #Remove if you do not want metrics in final model.
                  'clicks',       #Remove if you do not want metrics in final model.
                  'deferrals',    #Remove if you do not want metrics in final model.
                  'deliveries',   #Remove if you do not want metrics in final model.
                  'drops',        #Remove if you do not want metrics in final model.
                  'forwards',     #Remove if you do not want metrics in final model.
                  'opens',        #Remove if you do not want metrics in final model.
                  'prints',       #Remove if you do not want metrics in final model.
                  'spam_reports', #Remove if you do not want metrics in final model.
                  'unsubscribes'  #Remove if you do not want metrics in final model.
                  ]
```
### Include passthrough columns
This package includes all source columns defined in the macros folder. We highly recommend including custom fields in this package as models now only bring in a few fields for the `company`, `contact`, `deal`, and `ticket` tables. You can add more columns using our pass-through column variables. These variables allow for the pass-through fields to be aliased (`alias`) and casted (`transform_sql`) if desired, but not required. Datatype casting is configured via a sql snippet within the `transform_sql` key. You may add the desired sql while omitting the `as field_name` at the end and your custom pass-though fields will be casted accordingly. Use the below format for declaring the respective pass-through variables in your root `dbt_project.yml`.

```yml
vars:
  hubspot__deal_pass_through_columns:
    - name:           "property_field_new_id"
      alias:          "new_name_for_this_field_id"
      transform_sql:  "cast(new_name_for_this_field as int64)"
    - name:           "this_other_field"
      transform_sql:  "cast(this_other_field as string)"
  hubspot__contact_pass_through_columns:
    - name:           "wow_i_can_add_all_my_custom_fields"
      alias:          "best_field"
  hubspot__company_pass_through_columns:
    - name:           "this_is_radical"
      alias:          "radical_field"
      transform_sql:  "cast(radical_field as string)"
  hubspot__ticket_pass_through_columns:
    - name:           "property_mmm"
      alias:          "mmm"
    - name:           "property_bop"
      alias:          "bop"
```
**Alternatively**, if you would like to simply pass through **all columns** in the above four tables, add the following configuration to your dbt_project.yml. Note that this will override any `hubspot__[table_name]_pass_through_columns` variables.

```yml
vars:
  hubspot__pass_through_all_columns: true # default is false
```
### Adding property label
For `property_hs_*` columns, you can enable the corresponding, human-readable `property_option`.`label` to be included in the staging models. 

#### Important! 
- You must have sources `property` and `property_option` enabled to enable labels. By default, these sources are enabled.  
- You CANNOT enable labels if using `hubspot__pass_through_all_columns: true`.
- We recommend being selective with the label columns you add. As you add more label columns, your run time will increase due to the underlying logic requirements.

To enable labels for a given property, set the property attribute `add_property_label: true`, using the below format.

```yml
vars:
  hubspot__ticket_pass_through_columns:
    - name: "property_hs_fieldname"
      alias: "fieldname"
      add_property_label: true
```
  Alternatively, you can enable labels for all passthrough properties by using variable `hubspot__enable_all_property_labels: true`, formatted like the below example. 

```yml
vars:
  hubspot__enable_all_property_labels: true
  hubspot__ticket_pass_through_columns:
    - name: "property_hs_fieldname1"
    - name: "property_hs_fieldname2"
```

### Including calculated fields
This package also provides the ability to pass calculated fields through to the `company`, `contact`, `deal`, and `ticket` staging models. If you would like to add a calculated field to any of the mentioned staging models, you may configure the respective `hubspot__[table_name]_calculated_fields` variables with the `name` of the field you would like to create, and the `transform_sql` which will be the actual calculation that will make up the calculated field.
```yml
vars:
  hubspot__deal_calculated_fields:
    - name:          "deal_calculated_field"
      transform_sql: "existing_field * other_field"
  hubspot__company_calculated_fields:
    - name:          "company_calculated_field"
      transform_sql: "concat(name_field, '_company_name')"
  hubspot__contact_calculated_fields:
    - name:          "contact_calculated_field"
      transform_sql: "contact_revenue - contact_expense"
  hubspot__ticket_calculated_fields:
    - name:          "ticket_calculated_field"
      transform_sql: "total_field / other_total_field"
```
### Filtering email events
When leveraging email events, HubSpot customers may take advantage of filtering out specified email events. These filtered email events are present within the `stg_hubspot__email_events` model and are identified by the `is_filtered_event` boolean field. By default, these events are included in the staging and downstream models generated from this package. However, if you wish to remove these filtered events you may do so by setting the `hubspot_using_all_email_events` variable to false. See below for exact configurations you may provide in your `dbt_project.yml` file:
```yml
vars:
  hubspot_using_all_email_events: false # True by default
```

### Daily ticket history
The `hubspot__daily_ticket_history` model is disabled by default, but will materialize if `hubspot_service_enabled` is set to `true`. See additional configurations for this model below.

> **Note**: `hubspot__daily_ticket_history` and its parent intermediate models are incremental. After making any of the below configurations, you will need to run a full refresh.

#### **Tracking ticket properties**
By default, `hubspot__daily_ticket_history` will track each ticket's state, pipeline, and pipeline stage and pivot these properties into columns. However, any property from the source `TICKET_PROPERTY_HISTORY` table can be tracked and pivoted out into columns. To add other properties to this end model, add the following configuration to your `dbt_project.yml` file:

```yml
vars:
  hubspot__ticket_property_history_columns:
    - the
    - list
    - of 
    - property
    - names
```

#### **Extending ticket history past closing date**
This package will create a row in `hubspot__daily_ticket_history` for each day that a ticket is open, starting at its creation date. A Hubspot ticket can be altered after being closed, so its properties can change after this date.

By default, the package will track a ticket up to its closing date (or the current date if still open). To capture post-closure changes, you may want to extend a ticket's history past the close date. To do so, add the following configuration to your root dbt_project.yml file:

```yml
vars:
  hubspot:
    ticket_history_extension_days: integer_number_of_days # default = 0
```

### Changing the Build Schema
By default this package will build the HubSpot staging models within a schema titled (<target_schema> + `_stg_hubspot`) and HubSpot final models within a schema titled (<target_schema> + `hubspot`) in your target database. If this is not where you would like your modeled HubSpot data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    hubspot:
      +schema: my_new_schema_name # leave blank for just the target_schema
    hubspot_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:

> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_hubspot_source/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
vars:
    hubspot_<default_source_table_name>_identifier: your_table_name
```

## (Optional) Step 6: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand for details</summary>
<br>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).
</details>

# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.

```yml
packages:
    - package: fivetran/hubspot_source
      version: [">=0.14.0", "<0.15.0"]

    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]

    - package: dbt-labs/spark_utils
      version: [">=0.3.0", "<0.4.0"]
```
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/hubspot/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_hubspot/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions!

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) on the best workflow for contributing to a package!

# 🏪 Are there any resources available?
- If you have questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_hubspot/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).

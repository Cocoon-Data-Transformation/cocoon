# dbt_hubspot v0.17.2
[PR #142](https://github.com/fivetran/dbt_hubspot/pull/142) includes the following updates:

## 🪲 Bug Fixes 🪛
- Fixed the `fivetran_utils.enabled_vars` conditional by adding the `hubspot_contact_list_member_enabled` variable in the `hubspot__contact_lists` model. This solves for compilation errors when the `contact_list` source table is not synced in the destination. If `hubspot_contact_list_member_enabled` is `true`, `int_hubspot__email_metrics__by_contact_list` is brought in as a dependency, and ignored otherwise. 

## 🚘 Under the Hood 🚘
- Updated the `integration_tests/dbt_project.yml` variables to be global to ensure more effective testing of our seed data.
- Updated `property_closed_date` and `property_createdate` datatypes in `ticket_data` to cast as timestamp to fix datetime data type issues in BigQuery tests.
- Updated the maintainer PR template to resemble the most up to date format.
- Removed the check docs GitHub Action as it is no longer necessary.

# dbt_hubspot v0.17.1
[PR #140](https://github.com/fivetran/dbt_hubspot/pull/140) includes the following updates:

## Bug Fixes
- Included explicit datatype casts to `{{ dbt.type_string() }}` within the join of `contact_merge_audit.vid_to_merge` to `contacts.contact_id` in the `int_hubspot__contact_merge_adjust` model.
  - This update was required to address a bug where the IDs in the join would overflow to bigint or be interpreted as strings. This change ensures the join fields have matching datatypes.

# dbt_hubspot v0.17.0
[PR #137](https://github.com/fivetran/dbt_hubspot/pull/137) includes the following updates:

## 🚨 Breaking Changes: Variable Bug Fixes 🚨 
- The following are now dependent on the `hubspot_email_event_sent_enabled` variable being defined as `true`:
  -`hubspot__contact_lists` email metric fields
  -`hubspot__contact` email metric fields
  -`hubspot__email_campaigns` model
  -`int_hubspot__email_metrics__by_contact_list` model
> **Note**: This is a breaking change for users who have the `hubspot_email_event_sent_enabled` variable set to `false` as this update will change the above behaviors of the package. For all other users, these changes will not be breaking. 

# dbt_hubspot v0.16.0
[PR #135](https://github.com/fivetran/dbt_hubspot/pull/135) includes the following updates:

## 🚨 Breaking Changes 🚨
- Added unique tests on `event_id` for event-based models, `contact_id` for `hubspot__contacts`, `contact_list_id` for `hubspot__contact_lists`, `deal_id` for `hubspot__deals`, `deal_stage_id` for `hubspot__deal_stages`, and `company_id` for `hubspot__companies`, on the condition the titular fields have not been deleted. We would advise running through these to ensure they work successfully.

## Features
- Updates the `hubspot__deal_stages` and `hubspot__deals` models to remove stale deals that have been merged since into other deals. In addition we've introduced a new field `merged_deal_ids` that lists all historic merged deals for each deal. 
   - **Please note** you must have the underlying `merged_deals` table to take advantage of the above mentioned merged deal update. This may be enabled by setting `hubspot_merged_deal_enabled` to True (by default this will be False). Also, `hubspot_sales_enabled` and `hubspot_deal_enabled` must not be set to False (by default these are True). See [Step 4 of the README](https://github.com/fivetran/dbt_hubspot#step-4-disable-models-for-non-existent-sources) for more details. 

## Variable Bug Fixes
- The following adjustments have been made concerning the `hubspot_contact_enabled` variable:
  - The `email_events_joined()` macro now includes conditional logic to include contact information only if the `hubspot_contact_enabled` variable is defined as `true`.
  - The `int_hubspot__email_metrics__by_contact_list` model is now dependent on the `hubspot_contact_enabled` variable being defined as `true`.
  - The `hubspot__contact_lists` model now takes into consideration the `hubspot_contact_enabled` variable being defined as `true` before joining in email metric information to the contact lists data.
- Modified the config enabled logic within the `hubspot__email_sends` model to be dependent on the `hubspot_email_event_sent_enabled` variable being `true` in addition to the `hubspot_marketing_enabled` and `hubspot_email_event_enabled` variables.

## Under the Hood
- Added quickstart.yml for Quickstart customers.
- Added `not_null` tests that were previously missing to `deal_id` for `hubspot__deals` and `deal_stage_id` for `hubspot__deal_stages`.

# dbt_hubspot v0.15.1
[PR #129](https://github.com/fivetran/dbt_hubspot/pull/129) includes the following updates:

## Bug Fixes
- Updated model `int_hubspot__deals_enhanced` so that fields from the `owner` source are not included when `hubspot_owner_enabled` is set to false. 

## Under the Hood
- Included auto-releaser GitHub Actions workflow to automate future releases.

# dbt_hubspot v0.15.0

[PR #127](https://github.com/fivetran/dbt_hubspot/pull/127) includes the following updates:

## Bug fixes
- Updated variables used to determine if engagements are enabled in `hubspot__contacts` to also check variable `hubspot_engagement_contact_enabled`.

## Features
- The following changes stem from changes made in the source package. See the [source package v0.14.0 CHANGELOG entry](https://github.com/fivetran/dbt_hubspot_source/blob/main/CHANGELOG.md#dbt_hubspot_source-v0140) for more details. 

- Added the following staging models, along with documentation and tests:
  - `stg_hubspot__property`
  - `stg_hubspot__property_option`
  - These tables can be disabled by setting `hubspot_property_enabled: False` in your dbt_project.yml vars. See [Step 4 of the README](https://github.com/fivetran/dbt_hubspot#step-4-disable-models-for-non-existent-sources) for more details. 

- When including a passthrough `property_hs_*` column, you now have the option to include the corresponding, human-readable labels. 
  - The above-mentioned `property` tables are required for this feature. If you do not have them and have to disable them, unfortunately you will not be able to use this feature.
  - See the [Adding property label section](https://github.com/fivetran/dbt_hubspot#adding-property-label) of the README for more details on how to enable this feature! 
  - We recommend being selective with the label columns you add. As you add more label columns, your run time will increase due to the underlying logic requirements.
  - This update applies to models:
    - `hubspot__companies`
    - `hubspot__contacts`
    - `hubspot__deals`
    - `hubspot__tickets` 

# dbt_hubspot v0.14.0

## 🚨 Breaking Changes 🚨
- Within the source package the `created_at` and `closed_at` fields in the below mentioned staging models have been renamed to `created_date` and `closed_date` respectively to be consistent with the source data. Additionally, this will ensure there are no duplicate column errors when passing through all `property_*` columns, which could potentially conflict with `property_created_at` or `property_closed_at`. ([PR #119](https://github.com/fivetran/dbt_hubspot_source/pull/119))
  - `stg_hubspot__company`
    - Impacts `hubspot__companies`
  - `stg_hubspot__contact`
    - Impacts `hubspot__contacts`
  - `stg_hubspot__deal`
    - Impacts `hubspot__deals`
  - `stg_hubspot__ticket`
    - Impacts `hubspot__tickets`

## New Model Alert 😮
Introducing Service end models! These are disabled by default but can be enabled by setting `hubspot_service_enabled` to `true` ([PR #123](https://github.com/fivetran/dbt_hubspot/pull/123)):
  - `hubspot__tickets` - [Docs](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__tickets)
  - `hubspot__daily_ticket_history` - [Docs](https://fivetran.github.io/dbt_hubspot/#!/model/model.hubspot.hubspot__daily_ticket_history)
    - See additional configurations for the history model in [README](https://github.com/fivetran/dbt_hubspot/tree/main#daily-ticket-history)

## Features
- Addition of the following variables to allow the disabling of the `*_property_history` models if they are not being leveraged. All variables are `true` by default. ([PR #122](https://github.com/fivetran/dbt_hubspot/pull/122))
  - `hubspot_company_property_history_enabled`
  - `hubspot_contact_property_history_enabled`
  - `hubspot_deal_property_history_enabled`

## Under the Hood
- Updates to the seed files and seed file configurations for the package integration tests to ensure updates are properly tested. ([PR #122](https://github.com/fivetran/dbt_hubspot/pull/122))

# dbt_hubspot v0.13.0
## 🚨 Breaking Changes 🚨
- This release will be a breaking change due to the removal of below dependencies.
## Dependency Updates
- Removes the dependencies on [dbt-expectations](https://github.com/calogica/dbt-expectations/releases) and [dbt-date](https://github.com/calogica/dbt-date/releases). ([PR #118](https://github.com/fivetran/dbt_hubspot/pull/118))

## Under the Hood
- Specifically we removed the `dbt_expectations.expect_column_values_to_be_unique` test that was used to validate uniqueness under given conditions for the primary keys among the end models. We will be working to replace this with a similar test. ([PR #118](https://github.com/fivetran/dbt_hubspot/pull/118))

# dbt_hubspot v0.12.0

## 🚨 Breaking Changes 🚨
- This release includes breaking changes as a result of upstream changes within the `v0.12.0` release of the dbt_hubspot_source package. Please see below for the relevant breaking change release notes from the source package. ([PR #120](https://github.com/fivetran/dbt_hubspot/pull/120))
- The following models in the dbt_hubspot_source package now use a custom macro to remove the property_hs_ prefix in staging columns, while also preventing duplicates. If de-prefixed columns match existing ones (e.g., `property_hs_meeting_outcome` vs. `meeting_outcome`), the macro favors the `property_hs_`field, aligning with the latest HubSpot API update. ([PR #115](https://github.com/fivetran/dbt_hubspot_source/pull/115))
  - `stg_hubspot__engagement_call`
  - `stg_hubspot__engagement_company`
  - `stg_hubspot__engagement_contact`
  - `stg_hubspot__engagement_deal`
  - `stg_hubspot__engagement_email`
  - `stg_hubspot__engagement_meeting`
  - `stg_hubspot__engagement_note`
  - `stg_hubspot__engagement_task`
  - `stg_hubspot__ticket`
  - `stg_hubspot__ticket_company`
  - `stg_hubspot__ticket_contact`
  - `stg_hubspot__ticket_deal`
  - `stg_hubspot__ticket_engagement`
  - `stg_hubspot__ticket_property_history`

# dbt_hubspot v0.11.0
[PR #114](https://github.com/fivetran/dbt_hubspot/pull/114) includes the following updates:
## 🚨 Breaking Changes 🚨
This change is made breaking in part to updates applied to the upstream [dbt_hubspot_source](https://github.com/fivetran/dbt_hubspot_source/pull/112) package following upgrades to ensure compatibility with the HubSpot v3 API updates. Please see below for the relevant upstream changes:

- Following the [May 2023 connector update](https://fivetran.com/docs/applications/hubspot/changelog#may2023) the HubSpot connector now syncs the below parent and child tables from the new v3 API. As a result the dependent fields and field names from the downstream staging models have changed depending on the fields available in your HubSpot data. Now the respective staging models will sync the required fields for the dbt_hubspot downstream transformations and **all** of your `property_hs_*` fields. Please be aware that the `property_hs_*` will be truncated from the field name in the staging and downstream models. The impacted sources (and relevant staging models) are below:
```txt
  - `ENGAGEMENT`
    - `ENGAGEMENT_CALL`
    - `ENGAGEMENT_COMPANY`
    - `ENGAGEMENT_CONTACT`
    - `ENGAGEMENT_DEAL`
    - `ENGAGEMENT_EMAIL`
    - `ENGAGEMENT_MEETING`
    - `ENGAGEMENT_NOTE`
    - `ENGAGEMENT_TASK`
  - `TICKET`
    - `TICKET_COMPANY`
    - `TICKET_CONTACT`
    - `TICKET_DEAL`
    - `TICKET_ENGAGEMENT`
    - `TICKET_PROPERTY_HISTORY`
```
  - Please note that while these changes are breaking, the package has been updated to ensure backwards compatibility with the pre HubSpot v3 API updates. As a result, you may see some `null` fields which are artifacts of the pre v3 API HubSpot version. Be sure to inspect the relevant field descriptions for an understanding of which fields remain for backwards compatibility purposes. These fields will be removed once all HubSpot connectors are upgraded to the v3 API.

- The `engagements_joined` macro has been adjusted to account for the HubSpot v3 API changes. In particular, the fields that used to only be available in the `engagements` source are now available in the individual `engagement_[type]` sources. As such, coalesce statements were added to ensure the correct populated fields are used following the join. Further, to avoid ambiguous columns a `dbt-utils.star` was added to remove the explicitly declared columns within the coalesce statements.
  - The coalesce is only included for backwards compatibility. This will be removed in a future release when all HubSpot connectors are on the latest API version.

## Under the Hood
- The `base_model` argument used for the `engagements_joined` macro has been updated to be an explicit `ref` as opposed to the previously used `var` within the below models:
  - `hubspot__engagement_calls`
  - `hubspot__engagement_emails`
  - `hubspot__engagement_meetings`
  - `hubspot__engagement_notes`
  - `hubspot__engagement_tasks`
    - This update was applied as the `var` result was producing inconsistent results during compile and runtime when leveraging the `dbt-utils.star` macro. However, the explicit `ref` always provided consistent results. 

## Documentation Updates
- As new fields were added in the v3 API updates, and old fields were removed, the documentation was updated to reflect the v3 API consistent fields. Please take note if you are still using the pre v3 API, you will find the following end models no longer have complete field documentation coverage:
  - `hubspot__engagement_calls`
  - `hubspot__engagement_emails`
  - `hubspot__engagement_meetings`
  - `hubspot__engagement_notes`
  - `hubspot__engagement_tasks`
# dbt_hubspot v0.10.1

## 🪲 Bug Fixes
Explicitly casts join fields (`engagement_id` and `deal_id`) in `hubspot__deals` as the appropriate data types to avoid potential errors in joining. [PR #113](https://github.com/fivetran/dbt_hubspot/pull/113)

# dbt_hubspot v0.10.0
## 🚨 Breaking Changes 🚨
These changes are made breaking due to changes in the source. 
- Columns `updated_at` and `created_at` were added to the following sources and their corresponding staging models in the [source package](https://github.com/fivetran/dbt_hubspot_source):
  - `DEAL_PIPELINE`
  - `DEAL_PIPELINE_STAGE`
  - `TICKET_PIPELINE`
  - `TICKET_PIPELINE_STAGE`
- As a result, the following columns have been added ([#111](https://github.com/fivetran/dbt_hubspot/pull/111)): 
  - Model `hubspot__deals`:
    - `deal_pipeline_created_at`
    - `deal_pipeline_updated_at`
  - Model `hubspot__deal_stages`:
    - `deal_pipeline_stage_created_at`
    - `deal_pipeline_stage_updated_at`
- Documentation has also been updated with these new columns. ([#111](https://github.com/fivetran/dbt_hubspot/pull/111))

## 🎉 Feature Updates
- Updated README to include the variables `hubspot_ticket_deal_enabled` and `hubspot_owner_enabled`. ([#111](https://github.com/fivetran/dbt_hubspot/pull/111))

## 🚘 Under the Hood
- Modified the `unnest` logic in the `merge_contacts` macro for **Redshift** users to reduce runtime of the `int_hubspot__contact_merge_adjust` model. ([#110](https://github.com/fivetran/dbt_hubspot/pull/110))
- Updated seed data for testing newly added columns. ([#111](https://github.com/fivetran/dbt_hubspot/pull/111))

## Contributors
- @kcraig-ats ([#110](https://github.com/fivetran/dbt_hubspot/pull/110))

See upstream `hubspot_source` release notes [here](https://github.com/fivetran/dbt_hubspot_source/blob/main/CHANGELOG.md).

# dbt_hubspot v0.9.1

## 🎉 Feature Updates
- A new variable was added `hubspot_using_all_email_events` to allow package users to remove filtered email events from the `stg_hubspot__email_event` staging model as well as the relevant downstream reporting models. This is crucial for HubSpot users who greatly take advantage of marking events as filtered in order to provide accurate reporting. ([#104](https://github.com/fivetran/dbt_hubspot/pull/104))
  - The `hubspot_using_all_email_events` variable is `true` by default. Set the variable to `false` to filter out specified email events in your staging and downstream models. ([#104](https://github.com/fivetran/dbt_hubspot/pull/104))

## 🪲 Bug Fixes
- Introduced new macro `adjust_email_metrics` to prevent failures that may occur when certain tables are disabled or enabled. This macro removes any metrics that are unavailable from the default `email_metrics` list, ensuring that the models runs smoothly. It's worth noting that you can still manually set the email_metrics list as described in the README's [(Optional) Step 5: Additional configurations](https://github.com/fivetran/dbt_hubspot/#optional-step-5-additional-configurations). ([#105](https://github.com/fivetran/dbt_hubspot/pull/105))

## 🚘 Under the Hood
- The `email_event_data.csv` seed file was updated to include events that are listed as `true` for filtered_events. This is to effectively test the above mentioned feature update. ([#104](https://github.com/fivetran/dbt_hubspot/pull/104))
- Included `hubspot_using_all_email_events: false` as a variable declared in the final `run_models.sh` step to ensure our integration tests gain coverage over this new feature and variable. ([#104](https://github.com/fivetran/dbt_hubspot/pull/104))
  - See the source package [CHANGELOG](https://github.com/fivetran/dbt_hubspot_source/blob/main/CHANGELOG.md) for updates made to the staging layer in `dbt_hubspot_source v0.9.1`.
- Updated the following models to utilize the `adjust_email_metrics` macro ([#105](https://github.com/fivetran/dbt_hubspot/pull/105)):
  - hubspot__contacts
  - hubspot__contact_lists
  - hubspot__email_campaigns
  - int_hubspot__email_metrics__by_contact_list
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([#103](https://github.com/fivetran/dbt_hubspot/pull/103))
- Updated the pull request [templates](/.github). ([#103](https://github.com/fivetran/dbt_hubspot/pull/103))

# dbt_hubspot v0.9.0

## 🚨 Breaking Changes 🚨
In [November 2022](https://fivetran.com/docs/applications/hubspot/changelog#november2022), the Fivetran Hubspot connector switched to v3 of the Hubspot CRM API, which deprecated the `CONTACT_MERGE_AUDIT` table and stored merged contacts in a field in the `CONTACT` table. **This has not been rolled out to BigQuery warehouses yet.** BigQuery connectors with the `CONTACT_MERGE_AUDIT` table enabled will continue to sync this table until the new `CONTACT.property_hs_calculated_merged_vids` field and API version becomes available to them.

This release introduces breaking changes around how contacts are merged in order to align with the above connector changes. It is, however, backwards-compatible.

[PR #100](https://github.com/fivetran/dbt_hubspot/pull/100) applies the following changes:
- Updates logic around the recently deprecated `CONTACT_MERGE_AUDIT` table.
  - The package now leverages the new `property_hs_calculated_merged_vids` field to filter out merged contacts. This is the default behavior for all destinations, _including BigQuery_ (the package will run successfully but not actually merge any contacts). This is achieved by the package's new `merge_contacts()` macro.
  - **Backwards-compatibility:** the package will only reference the old `CONTACT_MERGE_AUDIT` table to merge contacts if `hubspot_contact_merge_audit_enabled` is explicitly set to `true` in your root `dbt_project.yml` file.
  - The `int_hubspot__contact_merge_adjust` model (where the package performs contact merging) is now materialized as a table by default. This used to be ephemeral, but the reworked merge logic requires this model to be either a table or view.

## Under the Hood
[PR #100](https://github.com/fivetran/dbt_hubspot/pull/100) applies the following changes:
- Updates seed data to test new merging paradigm.

See the source package [CHANGELOG](https://github.com/fivetran/dbt_hubspot_source/blob/main/CHANGELOG.md) for updates made to the staging layer in `dbt_hubspot_source v0.9.0`.

# dbt_hubspot v0.8.2
## Bug Fixes
- Following the release of `v0.8.0`, the end model uniqueness tests were not updated to account for the added flexibility of the inclusion of deleted records. As such the respective end model tests have been adjusted to test uniqueness only on non-deleted records. ([#94](https://github.com/fivetran/dbt_hubspot/pull/94))

## Under the Hood
- Addition of the dbt-expectations package to be used for more robust testing of uniqueness for end models. ([#94](https://github.com/fivetran/dbt_hubspot/pull/94))

# dbt_hubspot v0.8.0

## 🚨 Breaking Changes 🚨:
[PR #92](https://github.com/fivetran/dbt_hubspot/pull/92) incorporates the following changes:

- The below models/macros have new soft deleted record flags **explicitly** added to them:
  - `is_contact_deleted` added in `macros/email_events_joined` which can affect the following downstream models found in `models/marketing/email_events/`:
    - `hubspot__email_event_bounce`
    - `hubspot__email_event_clicks`
    - `hubspot__email_event_deferred`
    - `hubspot__email_event_delivered`
    - `hubspot__email_event_dropped`
    - `hubspot__email_event_forward`
    - `hubspot__email_event_open`
    - `hubspot__email_event_print`
    - `hubspot__email_event_sent`
    - `hubspot__email_event_spam_report`
    - `hubspot__email_event_status_change`
  - `is_deal_pipeline_deleted` and `is_deal_pipeline_stage_deleted` added in `models/sales/intermediate/int_hubspot__deals_enhanced` which can affect the following downstream models found in `models/sales/`:
    - `hubspot__deal_stages`
    - `hubspot__deals`
  - `is_deal_pipeline_deleted`, `is_deal_pipeline_stage_deleted` and `is_deal_deleted` added in `models/sales/hubspot__deal_stages`

- Soft deleted records are also now **implicitly** inherited (e.g. via a `select *`) from the `dbt_hubspot_source` package's staging models and can affect the below final models (for more information, see [dbt_hubspot_source PR #96](https://github.com/fivetran/dbt_hubspot_source/pull/96)):
  - Soft deleted company records (`companies.is_company_deleted`) included in the below models:
    - `sales/hubspot__companies`
  - Soft deleted deal records (`deals.is_deal_deleted`) included in the below models:
    - `sales/hubspot__deal_stages`
    - `sales/hubspot__deals`
  - Soft deleted contact list records (`contact_lists.is_contact_list_deleted`) included in the below models:
    - `marketing/hubspot__contact_lists`
  - Soft deleted contact records (`contacts.is_contact_deleted`) included in the below models:
    - `marketing/hubspot__contacts`
  - Soft deleted email sends records (`sends.is_contact_deleted`) included in the below models:
    - `marketing/hubspot__email_sends`

- For completeness, soft deleted records are also now included for `ticket*` tables, however does not currently affect this package directly and includes the following staging models:
    - `stg_hubspot__ticket` (`is_ticket_deleted`)
    - `stg_hubspot__ticket_pipeline_stage`(`is_ticket_pipeline_stage_deleted`)
    - `stg_hubspot__ticket_pipeline` (`is_ticket_pipeline_deleted`)

# dbt_hubspot v0.7.0

## 🚨 Breaking Changes 🚨:
[PR #86](https://github.com/fivetran/dbt_hubspot/pull/86) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- `dbt_utils.surrogate_key` has also been updated to `dbt_utils.generate_surrogate_key`. Since the method for creating surrogate keys differ, we suggest all users do a `full-refresh` for the most accurate data. For more information, please refer to dbt-utils [release notes](https://github.com/dbt-labs/dbt-utils/releases) for this update.
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

## 🎉 Features
- 🧱 Databricks compatibility! [(PR #89)](https://github.com/fivetran/dbt_hubspot/pull/89)

# dbt_hubspot v0.6.3
PR [#84](https://github.com/fivetran/dbt_hubspot/pull/84) incorporates the following updates:
## Fixes
- Added column descriptions that were missing in [our documentation](https://fivetran.github.io/dbt_hubspot/#!/overview).

# dbt_hubspot v0.6.2
## Under the Hood
- Updated the docs as there were issues with the previous deployment. ([#82](https://github.com/fivetran/dbt_hubspot/pull/82))
- Introduced a GitHub workflow to ensure docs are re-built prior to merges to `main`. ([#82](https://github.com/fivetran/dbt_hubspot/pull/82))
# dbt_hubspot v0.6.1
## Fixes
- The README had holdover merge artifacts included within it. Those artifacts have since been removed in this release. [#80](https://github.com/fivetran/dbt_hubspot/pull/80)

## Contributors
- [@cristianwebber](https://github.com/cristianwebber) ([#80](https://github.com/fivetran/dbt_hubspot/pull/80))

# dbt_hubspot v0.6.0
## 🎉 Documentation and Feature Updates
- Updated README documentation updates for easier navigation and setup of the dbt package ([#67](https://github.com/fivetran/dbt_hubspot/pull/67)).
- Included `hubspot_[source_table_name]_identifier` variable for additional flexibility within the package when source tables are named differently ([#67](https://github.com/fivetran/dbt_hubspot/pull/67)).
- Adds `hubspot_ticket_deal_enabled` variable (default value=`False`) to disable modelling and testing of the `ticket_deal` source table. If there are no associations between tickets and deals in your Hubspot environment, this table will not exist ([#79](https://github.com/fivetran/dbt_hubspot_source/pull/79)).

## 🚨 Breaking Changes 🚨
- The `hubspot__deal_stages` model has undergone two major changes ([#78](https://github.com/fivetran/dbt_hubspot/pull/78)):
  1. The stage and pipeline label columns now reflect where the deal was at a certain point of time (from `date_stage_entered` to `date_stage_exited`). Previously, this information reflected the deal's _current_ stage and pipeline in every record associated with the deal.
  2. This model previously passed through _all_ fields from the parent deals model. We removed these fields, as they are all present in `hubspot__deals` final model and do not change across deal stages. If you would like to join `DEAL` fields into the `hubspot__deal_stages` model, join `hubspot__deal_stages` with `hubspot__deals` on `deal_id`.
- Consistently renames `property_dealname`, `property_closedate`, and `property_createdate` to `deal_name`, `closed_at`, and `created_at`, respectively, in the `deals` model. Previously, if `hubspot__pass_through_all_columns = true`, only the prefix `property_` was removed from the names of these fields, while they were completely renamed to `deal_name`, `closed_at`, and `created_at` if `hubspot__pass_through_all_columns = false` ([#79](https://github.com/fivetran/dbt_hubspot_source/pull/79)).

# dbt_hubspot v0.5.4
## Fixes
- Typo fix and spelling correction within the README. ([#70](https://github.com/fivetran/dbt_hubspot/pull/70))
- Spelling correction of the variable names within the README. ([#74](https://github.com/fivetran/dbt_hubspot/pull/74))

## Contributors
- [@moreaupascal56](https://github.com/moreaupascal56) ([#70](https://github.com/fivetran/dbt_hubspot/pull/70), [#74](https://github.com/fivetran/dbt_hubspot/pull/74))

# dbt_hubspot v0.5.3
## Under the Hood
- Added integration testing to support the new `stg_hubspot__deal_contact` model to the `dbt_hubspot_source` package.
- Updated the below models such that the respective `lead()` functions also account for `field_name` in partitions
  - `hubspot__contact_history`
  - `hubspot__company_history`
  - `hubspot__deal_history`
- Added test cases for the above models that can be found, respectively, in: 
  - `models/marketing/history/history.yml`
  - `models/sales/history/history.yml`
# dbt_hubspot v0.5.2
## Under the Hood
- Updated the `engagements_joined` [macro](https://github.com/fivetran/dbt_hubspot/blob/main/macros/engagements_joined.sql) to conditionally include relevant fields if their respective variables are enabled. Previously if a variable was disabled then the `hubspot__engagement_calls` model, which depends on the `engagements_joined` macro, would error out on the missing fields that were from the disabled variables. ([#65](https://github.com/fivetran/dbt_hubspot/pull/65))

# dbt_hubspot v0.5.1
## Under the Hood
- Modified the join conditions within the `deal_fields_joined` cte of int_hubspot__deals_enhanced model to leverage the more appropriate `left join` rather than the `using` condition. This is to allow for correct and accurate joins across warehouses. ([#60](https://github.com/fivetran/dbt_hubspot/pull/60))

# dbt_hubspot v0.5.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_hubspot_source`. Additionally, the latest `dbt_hubspot_source` package has a dependency on the latest `dbt_fivetran_utils`. Further, the latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_hubspot v0.1.0 -> v0.4.1
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!

# dbt_pinterest v0.10.0
[PR #30](https://github.com/fivetran/dbt_pinterest/pull/30) includes the following updates:

## Breaking changes
- Updated the following identifiers for consistency with the source name and compatibility with the union schema feature:

| current  | previous |
|----------|----------|
| pinterest_ads_ad_group_history_identifier | pinterest_ad_group_history_identifier |
| pinterest_ads_campaign_history_identifier | pinterest_campaign_history_identifier |
| pinterest_ads_pin_promotion_report_identifier | pinterest_pin_promotion_report_identifier |
| pinterest_ads_keyword_history_identifier | pinterest_keyword_history_identifier |
| pinterest_ads_keyword_report_identifier | pinterest_keyword_report_identifier |
| pinterest_ads_ad_group_report_identifier | pinterest_ad_group_report_identifier |
| pinterest_ads_campaign_report_identifier | pinterest_campaign_report_identifier |
| pinterest_ads_advertiser_history_identifier | pinterest_advertiser_history_identifier |
| pinterest_ads_advertiser_report_identifier | pinterest_advertiser_report_identifier |

- If you are using the previous identifier, be sure to update to the current version!

## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple pinterest connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_pinterest/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- In the source package, updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging and downstream model and applied the `fivetran_utils.source_relation` macro.
  - The `source_relation` column is included in all joins in the transform package. 
- Updated tests to account for the new `source_relation` column.

# dbt_pinterest v0.9.0

# Pinterest Ads v5 Upgrade
## 🚨 Breaking Changes 🚨:
[PR #26](https://github.com/fivetran/dbt_pinterest/pull/26) introduces the following changes:

- Following Pinterest Ads deprecating the v4 API on June 30, 2023 in place of v5, the Pinterest Ads Fivetran connector now leverages the Pinterest v5 API. The following fields have been deprecated/introduced:

| **Model** | **Removed**  | **New**   |
|---|---|---|
|  [pinterest_ads__advertiser_report](https://fivetran.github.io/dbt_pinterest/#!/model/model.pinterest.pinterest_ads__advertiser_report) | `billing_type`, `status`  |   |

## Under the Hood:
- Following the v5 upgrade, `ad_account_id` is a net new field within `ad_group_history` and `pin_promotion_history` source tables synced via the connector. However, to keep these fields standard across the package, we have renamed them as `advertiser_id` within the respective staging models.
- Seed data were updated with new/removed fields following the v5 upgrade


# dbt_pinterest v0.8.0
- This was an accidental release

# dbt_pinterest v0.7.1
## Features
- Addition of the `pinterest__using_keywords` (default=`true`) variable that allows users to disable the relevant keyword reports in the downstream Pinterest models if they are not used. ([#25](https://github.com/fivetran/dbt_pinterest/pull/25))

## Under the Hood:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([PR #24](https://github.com/fivetran/dbt_pinterest/pull/24))
- Updated the pull request [templates](/.github). ([PR #24](https://github.com/fivetran/dbt_pinterest/pull/24))

# dbt_pinterest v0.7.0

## 🚨 Breaking Changes 🚨:
[PR #22](https://github.com/fivetran/dbt_pinterest/pull/22) includes the following breaking changes:
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
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.

## 🎉 Features 🎉
- For use in the [dbt_ad_reporting package](https://github.com/fivetran/dbt_ad_reporting), users can now allow records having nulls in url fields to be included in the `ad_reporting__url_report` model. See the [dbt_ad_reporting README](https://github.com/fivetran/dbt_ad_reporting) for more details ([#23](https://github.com/fivetran/dbt_pinterest/pull/23)).
## 🚘 Under the Hood 🚘
- Disabled the `not_null` test for `pinterest_ads__url_report` when null urls are allowed ([#23](https://github.com/fivetran/dbt_pinterest/pull/23)).


# dbt_pinterest v0.6.0
PR [#21](https://github.com/fivetran/dbt_pinterest/pull/21) includes the following changes:
## 🚨 Breaking Changes 🚨
- The `pin_promotion_report_pass_through_metric` variable has been renamed to `pinterest__pin_promotion_report_passthrough_metrics`.
- The declaration of passthrough variables within your root `dbt_project.yml` has changed. To allow for more flexibility and better tracking of passthrough columns, you will now want to define passthrough metrics in the following format:
> This applies to all passthrough metrics within the `dbt_pinterest` package and not just the `pinterest__pin_promotion_report_passthrough_metrics` example.
```yml
vars:
  pinterest__pin_promotion_report_passthrough_metrics:
    - name: "my_field_to_include" # Required: Name of the field within the source.
      alias: "field_alias" # Optional: If you wish to alias the field within the staging model.
```
- The `pinterest_ads__ad_adapter` has been renamed to `pinterest_ads__url_report`.
- The `pinterest_ads__ad_group_ad_report` has been renamed to `pinterest_ads__ad_group_report`.
- The `pinterest_ads__campaign_ad_report` has been renamed to `pinterest_ads__campaign_report`.
## 🎉 Feature Enhancements 🎉
- Addition of the following new end models: 
  - `pinterest_ads__pin_promotion_report`
    - Each record in this table represents the daily performance at the pin level.
  - `pinterest_ads__advertiser_report`
    - Each record in this table represents the daily performance at the advertiser level.
  - `pinterest_ads__keyword_report`
    - Each record in this table represents the daily performance at the ad group level for keywords.

- Inclusion of additional passthrough metrics: 
  - `pinterest__ad_group_report_passthrough_metrics`
  - `pinterest__campaign_report_passthrough_metrics`
  - `pinterest__advertiser_report_passthrough_metrics`
  - `pinterest__keyword_report_passthrough_metrics`

- README updates for easier navigation and use of the package. 
- Included grain uniqueness tests for each end model. 

## Contributors
- [@bnealdefero](https://github.com/bnealdefero) [#21](https://github.com/fivetran/dbt_pinterest/pull/21)
# dbt_pinterest v0.5.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_pinterest_source`. Additionally, the latest `dbt_pinterest_source` package has a dependency on the latest `dbt_fivetran_utils`. Further, the latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_pinterest v0.1.0 -> v0.4.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!

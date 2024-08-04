# dbt_amplitude v0.4.0

## Breaking Changes
- This release removes the pre-defined dbt-metric configurations within the package. These metrics relied on an old version of dbt-metrics which has since been sunset. ([PR #15](https://github.com/fivetran/dbt_amplitude/pull/15))
    - If you found these metrics to be useful and would still like to leverage them within the package, we encourage you to open a PR on this repository to convert the pre-defined metrics so they may support the new dbt Labs Metric Flow configs and requirements. 

## Under the Hood:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job. ([PR #11](https://github.com/fivetran/dbt_amplitude/pull/11))
- Updated the pull request [templates](/.github). ([PR #11](https://github.com/fivetran/dbt_amplitude/pull/11))

# dbt_amplitude v0.3.0
## 🚨 Breaking Changes 🚨:
[PR #9](https://github.com/fivetran/dbt_amplitude/pull/9) includes the following changes:
- Rename `date_range_start` and `date_range_end` variables to `amplitude__date_range_start` and `amplitude__date_range_end` and make them global variables.
- The date range filter using `amplitude__date_range_start` and `amplitude__date_range_end` variables have been moved further upstream to `stg_amplitude__event`. 
- Removal of the configuration within the dbt_project.yml that erroneously materialized all models as tables. The models will now properly run incrementally following the initial run.
- Removal of the recursive subqueries within model incremental logic. These subqueries have been reformatted into their own CTE's to address warehouses errors that arise when handling a potential recursive relationship. The incremental logic have been updated in the following models:
   - `int_amplitude__date_spine`
   - `amplitude__daily_performance`
   - `amplitude__event_enhanced`
   - `amplitude__sessions`

- Change the coalesce clause used for deduplicating events to a case-when statement. This assures that for the scenario where `_insert_id` is null, that those respective records are not being considered and grouped as 1 event.
- Please note, a `dbt run --full-refresh` will be required after upgrading to this version in order to capture the updates.


## Under the Hood
- Add an additional dbt run to our integration testing so that we're not just running on fresh data, and so that the second run uses the same data and runs with the incremental strategy. 

# dbt_amplitude v0.2.0

## 🚨 Breaking Changes 🚨:
[PR #4](https://github.com/fivetran/dbt_amplitude/pull/4) includes the following breaking changes:
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

## Under the Hood
- Updated the metric attribute names to be in alignment with the current version of dbt metrics: `sql` -> `expression` and `type` -> `calculation_method`.
# dbt_amplitude v0.1.0
🎉 Initial Release 🎉
- This is the initial release of our Amplitude package. For more information refer to the [README](https://github.com/fivetran/dbt_amplitude/blob/main/README.md).
- This package outputs an enhanced events model, along with a daily performance, sessions, and enhanced user final model. 
- In addition, this package can be used in conjunction with the[ dbt metrics package](https://github.com/dbt-labs/dbt_metrics) and the [dbt product analytics package](https://github.com/mjirv/dbt_product_analytics) for further analysis. Information on configuration as well as example use cases are included in the [README](https://github.com/fivetran/dbt_amplitude/blob/main/README.md).

Currently the package supports Postgres, Redshift, BigQuery, Databricks and Snowflake. Additionally, this package is designed to work with dbt versions [">=1.0.0", "<2.0.0"].

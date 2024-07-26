# dbt_amazon_ads v0.3.0
[PR #11](https://github.com/fivetran/dbt_amazon_ads/pull/11) includes the following updates:
## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple amazon_ads connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_amazon_ads/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- In the source package, updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging and downstream model and applied the `fivetran_utils.source_relation` macro.
  - The `source_relation` column is included in all joins in the transform package. 
- Updated tests to account for the new `source_relation` column.

# dbt_amazon_ads v0.2.0
[PR #6](https://github.com/fivetran/dbt_amazon_ads/pull/6) includes the following updates:
## 🚨 Breaking changes
- This release is labeled breaking since changes made in [dbt_amazon_ads_source](https://github.com/fivetran/dbt_amazon_ads_source) are breaking. Note that columns in this package are unchanged.
- Further details are available in the [dbt_amazon_ads_source CHANGELOG](https://github.com/fivetran/dbt_amazon_ads_source/blob/main/CHANGELOG.md).
## 🎉 Features
- Updated documentation to reference changes in the source package.

 ## 🚘 Under the Hood
- Updated testing seed data to reflect the source seed changes.

 [PR #4](https://github.com/fivetran/dbt_amazon_ads/pull/4) includes the following updates:
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job.
- Updated the pull request [templates](/.github).

 # dbt_amazon_ads v0.1.0
🎉 This is the initial release of this package! 🎉
## 📣 What does this dbt package do?
- Produces modeled tables that leverage Amazon Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/amazon-ads) in the format described by [this ERD](https://fivetran.com/docs/applications/amazon-ads#schemainformation) and builds off the output of our [Amazon Ads source package](https://github.com/fivetran/dbt_amazon_ads_source).
- Provides insight into your ad performance across the following grains:
  - Account, portfolio, campaign, ad group, ad, keyword, and search term
- Materializes output models designed to work simultaneously with our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting).
- Generates a comprehensive data dictionary of your source and modeled Amazon Ads data through the [dbt docs site](https://fivetran.github.io/dbt_amazon_ads/).

# Decision Log

## `facebook_ads__utm_report` Design Decisions
Currently, your UTM report will only include:
- UTM reporting for the creative associated with the most recent `ad_id` located in the `ad_history` source table
- UTM reporting for creatives that have a value for at least ONE of the following UTM fields as to reduce the size of the end model and eliminate irrelevant data:
    - `utm_source`
    - `utm_campaign`
    - `utm_content`
    - `utm_medium`
    - `utm_term`
- Only the most recent UTM parameters for each creative is used, based on the `_fivetran_synced` column located in `creative_history` as Facebook does not currently provide `updated_at` timestamp in this data.

## Most Recent Record Logic for History Tables
For source history tables that provide a `updated_at` field, the most recent record in the respective history tables are calculated using `updated_at`; otherwise, we use `_fivetran_synced` as a proxy field to calculate the most recent record. 

## Passing Through Metrics Not Available 
Please note that additional pass through metrics are only available for the source models as additional metrics such as `cpc`, `cpm` and `ctr` are already aggregated metrics that should not be rolled up into higher levels of reporting.

## Why don't metrics add up across different grains (Ex. ad level vs campaign level)?
Not all ads are served at the ad level. In other words, there are some ads that are served only at the ad group, campaign, etc. levels. The implications are that since not ads are included in the ad-level report, their associated spend, for example, won't be included at that grain. Therefore your spend totals may differ across the ad grain and another grain. 

This is a reason why we have broken out the ad reporting packages into separate hierarchical end models (Ad, Ad Group, Campaign, and more). Because if we only used ad-level reports, we could be missing data.
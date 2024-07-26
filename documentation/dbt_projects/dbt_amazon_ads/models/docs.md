{% docs _fivetran_deleted %}
Boolean created by Fivetran to indicate whether the record has been deleted.
{% enddocs %}

{% docs _fivetran_id %}
Unique ID used by Fivetran to sync and dedupe data.
{% enddocs %}

{% docs _fivetran_synced %}
Timestamp of when a record was last synced.
{% enddocs %}

{% docs account_id %}
Identifier for sellers and vendors. Note that this value is not unique and may be the same across marketplaces.
{% enddocs %}

{% docs account_name %}
Account Name. Not currently populated for sellers.
{% enddocs %}

{% docs ad_group_id %}
The ID of the AdGroup.
{% enddocs %}

{% docs ad_group_name %}
The name of the AdGroup.
{% enddocs %}

{% docs ad_id %}
The ID of the Ad.
{% enddocs %}

{% docs ad_keyword_status %}
Current status of a keyword.
{% enddocs %}

{% docs advertised_asin %}
The ASIN associated to an advertised product.
{% enddocs %}

{% docs advertised_sku %}
The SKU being advertised. 
{% enddocs %}

{% docs bid_keyword %}
Bid associated with this keyword.
{% enddocs %}

{% docs campaign_applicable_budget_rule_id %}
The ID associated to the active budget rule for a campaign.
{% enddocs %}

{% docs campaign_applicable_budget_rule_name %}
The name associated to the active budget rule for a campaign.
{% enddocs %}

{% docs campaign_bidding_strategy %}
The bidding strategy associated with a campaign.
{% enddocs %}

{% docs campaign_budget_amount %}
Total budget allocated to the campaign.
{% enddocs %}

{% docs campaign_budget_currency_code %}
The currency code associated with the campaign.
{% enddocs %}

{% docs campaign_budget_type %}
One of: daily or lifetime.
{% enddocs %}

{% docs campaign_id %}
The ID of the Campaign.
{% enddocs %}

{% docs campaign_name %}
The name of the Campaign.
{% enddocs %}

{% docs campaign_rule_based_budget_amount %}
The value of the rule-based budget for a campaign.
{% enddocs %}

{% docs clicks %}
Total number of ad clicks.
{% enddocs %}

{% docs cost %}
Total cost of ad clicks.
{% enddocs %}

{% docs country_code %}
The code for a given country.
{% enddocs %}

{% docs creation_date %}
The date of creation of the record.
{% enddocs %}

{% docs currency_code %}
The currency used for all monetary values for entities under this profile.
{% enddocs %}

{% docs default_bid %}
The date of creation of the record.
{% enddocs %}

{% docs impressions %}
Total number of ad impressions.
{% enddocs %}

{% docs is_most_recent_record %}
Boolean indicating whether record was the most recent instance.
{% enddocs %}

{% docs keyword_bid %}
Bid associated with a keyword or targeting expression.
{% enddocs %}

{% docs keyword_id %}
The ID of the keyword.
{% enddocs %}

{% docs keyword_match_type %}
One of (broad, exact, or phrase.)
{% enddocs %}

{% docs keyword_text %}
The exact text for the keyword.
{% enddocs %}

{% docs keyword_type %}
Type of matching for the keyword used in bid. One of: BROAD, PHRASE, or EXACT.
{% enddocs %}

{% docs last_updated_date %}
Date of last update to record.
{% enddocs %}

{% docs match_type %}
Type of matching for the keyword used in bid. One of: BROAD, PHRASE, or EXACT.
{% enddocs %}

{% docs negative_keyword_id %}
The ID of the negative keyword.
{% enddocs %}

{% docs portfolio_id %}
The ID of the Portfolio.
{% enddocs %}

{% docs portfolio_name %}
The name of the Portfolio.
{% enddocs %}

{% docs profile_id %}
The profile ID associated with your Amazon Ads account. Advertisers who operate in more than one marketplace (for example, Amazon.com, Amazon.co.uk, Amazon.co.jp) will have one profile associated with each marketplace.
{% enddocs %}

{% docs report_date %}
The date of the report.
{% enddocs %}

{% docs search_term %}
The search term used by the customer.
{% enddocs %}

{% docs serving_status %}
The current serving status of the record.
{% enddocs %}

{% docs state %}
The state of the record (enabled, paused, or archived).
{% enddocs %}

{% docs targeting %}
A string representation of the expression object used in the targeting clause.
{% enddocs %}

{% docs source_relation %}
The source of the record if the unioning functionality is being used. If not this field will be empty.
{% enddocs %}
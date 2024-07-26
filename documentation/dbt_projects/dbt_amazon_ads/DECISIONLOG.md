# Decision Log

## Amazon Ads Accounts and Portfolios
- The models `amazon_ads__account_report` and `amazon_ads__portfolio_report` are aggregated from the campaign-level reports provided by Amazon Ads. This approach was necessary since Amazon Ads does not provide reporting at these levels, and the campaign reports are the broadest Amazon Ads provides.
- Accounts:
    - Broadest grain report
    - While the term "account" by Amazon Ad's definition would summarize all metrics under one advertiser and definitively result in a one-line report, the account report uses `profile_id` as the grain. Our understanding is that Amazon provides a `profile_id` for each market/country in which an advertiser operates, and the intention is to provide a more meaningful aggregation at the country level if it applies.  
- Portfolios:
    - Grain is narrower than Accounts but broader than Campaigns
    - This is a newer feature that is optional, so not all advertisers may not utilize portfolios. It is also possible that even if portfolios are being used, not all campaigns may be assigned to a portfolio. Arguably this report may not be entirely necessary, however since portfolios are a budgeting aid, we wanted to include a report with this grain.

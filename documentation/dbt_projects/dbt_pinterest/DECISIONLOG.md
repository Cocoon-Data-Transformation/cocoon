# Decision Log
## UTM Report Filtering
This package contains a `pinterest_ads__url_report` which provides daily metrics for your utm compatible ads. It is important to note that not all Ads within Pinterest's `pin_promotion_report` source table leverage utm parameters. Therefore, this package takes an opinionated approach to filter out any records that do not contain utm parameters or leverage a url within the promoted pin.

If you would like to leverage a report that contains all promoted pins and their daily metrics, we would suggest you leverage the `pinterest_ads__ad_report` which does not apply any filtering.
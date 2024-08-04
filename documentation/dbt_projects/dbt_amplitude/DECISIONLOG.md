# Decision Log
## amplitude_user_id and user_id
Not all customers may be using `user_id` since the field in Amplitude is optional. Therefore, when handling user-based metrics we take the opinionated stance to coalesce `user_id` and `amplitude_user_id`. This way, if your Amplitude account does not utilize `user_id` you may still take advantage of user-based metrics with the `amplitude_user_id`.

## Event De-duplication logic
With the manner at which events fire and get received there is a possibility that events are duplicated. According to [Amplitude](https://amplitude.engineering/dedupe-events-at-scale-f9e416e46ca9), events get de-duplicated based on `_insert_id`.

- "Now, to address this issue we recommended sending a unique identifier viz. insert identifier with each ingested event. We do deduplication of any subsequent events sent (within the last 7 days) with the same insert identifier."

To add to Amplitude's de-duplication process, in the `amplitude__event_enhanced` and `amplitude__sessions` model, given that `_insert_id` is null, we de-duplicate based on events having the same following fields:
- `event_id`
- `device_id`
- `client_event_time`
- `amplitude_user_id`

We then order the respective records with same aforementioned fields by `client_upload_time` and filter for the most recent. The reason we select records using `client_upload_time` is there may be a lag between `client_event_time` and `client_upload_time`, such as when the client's device is on airplane mode. Please refer to [Amplitude's documentation](https://help.amplitude.com/hc/en-us/articles/229313067#Raw-Data-Fields) for more.
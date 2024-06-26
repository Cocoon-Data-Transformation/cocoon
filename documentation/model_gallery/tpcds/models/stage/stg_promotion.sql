-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"promotion_renamed" AS (
    -- Rename: Renaming columns
    -- P_PROMO_SK -> promotion_sku
    -- P_PROMO_ID -> promotion_id
    -- P_START_DATE_SK -> start_date
    -- P_END_DATE_SK -> end_date
    -- P_ITEM_SK -> item_sku
    -- P_COST -> promotion_cost
    -- P_RESPONSE_TARGE -> response_target
    -- P_PROMO_NAME -> promotion_name
    -- P_CHANNEL_DMAIL -> direct_mail_channel
    -- P_CHANNEL_EMAIL -> email_channel
    -- P_CHANNEL_CATALOG -> catalog_channel
    -- P_CHANNEL_TV -> tv_channel
    -- P_CHANNEL_RADIO -> radio_channel
    -- P_CHANNEL_PRESS -> press_channel
    -- P_CHANNEL_EVENT -> event_channel
    -- P_CHANNEL_DEMO -> demo_channel
    -- P_CHANNEL_DETAILS -> channel_details
    -- P_PURPOSE -> purpose
    -- P_DISCOUNT_ACTIVE -> discount_active
    SELECT 
        "P_PROMO_SK" AS "promotion_sku",
        "P_PROMO_ID" AS "promotion_id",
        "P_START_DATE_SK" AS "start_date",
        "P_END_DATE_SK" AS "end_date",
        "P_ITEM_SK" AS "item_sku",
        "P_COST" AS "promotion_cost",
        "P_RESPONSE_TARGE" AS "response_target",
        "P_PROMO_NAME" AS "promotion_name",
        "P_CHANNEL_DMAIL" AS "direct_mail_channel",
        "P_CHANNEL_EMAIL" AS "email_channel",
        "P_CHANNEL_CATALOG" AS "catalog_channel",
        "P_CHANNEL_TV" AS "tv_channel",
        "P_CHANNEL_RADIO" AS "radio_channel",
        "P_CHANNEL_PRESS" AS "press_channel",
        "P_CHANNEL_EVENT" AS "event_channel",
        "P_CHANNEL_DEMO" AS "demo_channel",
        "P_CHANNEL_DETAILS" AS "channel_details",
        "P_PURPOSE" AS "purpose",
        "P_DISCOUNT_ACTIVE" AS "discount_active"
    FROM "promotion"
),

"promotion_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "promotion_sku",
        "promotion_id",
        "start_date",
        "end_date",
        "item_sku",
        "promotion_cost",
        "response_target",
        "promotion_name",
        "direct_mail_channel",
        "email_channel",
        "catalog_channel",
        "tv_channel",
        "radio_channel",
        "press_channel",
        "event_channel",
        "demo_channel",
        "purpose",
        "discount_active",
        TRIM("channel_details") AS "channel_details"
    FROM "promotion_renamed"
),

"promotion_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- promotion_name: The problem is that all three values in the promotion_name column are unusual and incomplete. They appear to be fragments of words rather than full promotion names. 'able' could be part of 'available' or 'affordable', 'ought' might be part of 'bought', and 'pri' could be the beginning of 'price' or 'prime'. Without more context or information about the intended promotion names, it's impossible to determine the correct full names. Therefore, the best approach is to map these incomplete values to an empty string, indicating that the promotion name is unknown or not specified. 
    -- tv_channel: The problem is that 'N' is the only value in the tv_channel column, and it's unclear what it represents. A single letter 'N' is not a typical TV channel designation. It could be an abbreviation for "None" or "Not Applicable", indicating that the content is not associated with a specific TV channel. Without more context or information about other possible values in this column, it's difficult to determine the exact meaning. However, since it's the only value present, we can assume it's intentional but perhaps not ideally formatted. 
    -- channel_details: The problem is that all values in the channel_details column are incomplete phrases that don't convey clear, distinct categories. These phrases appear to be truncated or nonsensical snippets of text, which don't provide any meaningful information about channel details. The correct values cannot be inferred from the given data, as there's no clear pattern or context to derive proper categories. In this case, it's best to map all these unusual values to an empty string, indicating that the data is invalid or missing. 
    SELECT
        "promotion_sku",
        "promotion_id",
        "start_date",
        "end_date",
        "item_sku",
        "promotion_cost",
        "response_target",
        CASE
            WHEN "promotion_name" = 'able' THEN ''
            WHEN "promotion_name" = 'ought' THEN ''
            WHEN "promotion_name" = 'pri' THEN ''
            ELSE "promotion_name"
        END AS "promotion_name",
        "direct_mail_channel",
        "email_channel",
        "catalog_channel",
        CASE
            WHEN "tv_channel" = 'N' THEN 'None'
            ELSE "tv_channel"
        END AS "tv_channel",
        "radio_channel",
        "press_channel",
        "event_channel",
        "demo_channel",
        "purpose",
        "discount_active",
        CASE
            WHEN "channel_details" = 'Companies shall not pr' THEN ''
            WHEN "channel_details" = 'Men will not say merely. Old, available' THEN ''
            WHEN "channel_details" = 'So willing buildings coul' THEN ''
            ELSE "channel_details"
        END AS "channel_details"
    FROM "promotion_renamed_trimmed"
),

"promotion_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- promotion_name: ['']
    -- tv_channel: ['None']
    -- channel_details: ['']
    SELECT 
        CASE
            WHEN "promotion_name" = '' THEN NULL
            ELSE "promotion_name"
        END AS "promotion_name",
        CASE
            WHEN "tv_channel" = 'None' THEN NULL
            ELSE "tv_channel"
        END AS "tv_channel",
        CASE
            WHEN "channel_details" = '' THEN NULL
            ELSE "channel_details"
        END AS "channel_details",
        "press_channel",
        "purpose",
        "promotion_sku",
        "catalog_channel",
        "response_target",
        "email_channel",
        "end_date",
        "promotion_cost",
        "demo_channel",
        "direct_mail_channel",
        "promotion_id",
        "item_sku",
        "start_date",
        "radio_channel",
        "event_channel",
        "discount_active"
    FROM "promotion_renamed_trimmed_cleaned"
),

"promotion_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- end_date: from INT to DATE
    -- start_date: from INT to DATE
    SELECT
        "promotion_name",
        "tv_channel",
        "channel_details",
        "press_channel",
        "purpose",
        "promotion_sku",
        "catalog_channel",
        "response_target",
        "email_channel",
        "promotion_cost",
        "demo_channel",
        "direct_mail_channel",
        "promotion_id",
        "item_sku",
        "radio_channel",
        "event_channel",
        "discount_active",
        DATE '1858-11-17' + (CAST("end_date" AS INTEGER) - 2400000) AS "end_date",
        julian(DATE '1858-11-17' + (CAST("start_date" - 2400001 AS INTEGER) * INTERVAL '1 day')) AS "start_date"
    FROM "promotion_renamed_trimmed_cleaned_null"
),

"promotion_renamed_trimmed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 2 columns with unacceptable missing values
    -- promotion_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- tv_channel has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "channel_details",
        "press_channel",
        "purpose",
        "promotion_sku",
        "catalog_channel",
        "response_target",
        "email_channel",
        "promotion_cost",
        "demo_channel",
        "direct_mail_channel",
        "promotion_id",
        "item_sku",
        "radio_channel",
        "event_channel",
        "discount_active",
        "end_date",
        "start_date"
    FROM "promotion_renamed_trimmed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "promotion_renamed_trimmed_cleaned_null_casted_missing_handled"
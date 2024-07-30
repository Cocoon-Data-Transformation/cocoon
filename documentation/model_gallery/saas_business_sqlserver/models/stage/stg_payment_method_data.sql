-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-30 02:45:59.724835+00:00
WITH 
"payment_method_data_projected" AS (
    -- Projection: Selecting 14 out of 15 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "billing_detail_address_city",
        "billing_detail_address_country",
        "billing_detail_address_line_1",
        "billing_detail_address_line_2",
        "billing_detail_address_postal_code",
        "billing_detail_address_state",
        "billing_detail_email",
        "billing_detail_name",
        "billing_detail_phone",
        "created",
        "customer_id",
        "livemode",
        "type"
    FROM "MyAppDB"."dbo"."payment_method_data"
),

"payment_method_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> payment_method_id
    -- billing_detail_address_city -> billing_city
    -- billing_detail_address_country -> billing_country
    -- billing_detail_address_line_1 -> billing_address_line1
    -- billing_detail_address_line_2 -> billing_address_line2
    -- billing_detail_address_postal_code -> billing_postal_code
    -- billing_detail_address_state -> billing_state
    -- billing_detail_email -> billing_email
    -- billing_detail_name -> billing_name
    -- billing_detail_phone -> billing_phone
    -- created -> creation_date
    -- livemode -> is_live
    -- type -> payment_type
    SELECT 
        "id" AS "payment_method_id",
        "billing_detail_address_city" AS "billing_city",
        "billing_detail_address_country" AS "billing_country",
        "billing_detail_address_line_1" AS "billing_address_line1",
        "billing_detail_address_line_2" AS "billing_address_line2",
        "billing_detail_address_postal_code" AS "billing_postal_code",
        "billing_detail_address_state" AS "billing_state",
        "billing_detail_email" AS "billing_email",
        "billing_detail_name" AS "billing_name",
        "billing_detail_phone" AS "billing_phone",
        "created" AS "creation_date",
        "customer_id",
        "livemode" AS "is_live",
        "type" AS "payment_type"
    FROM "payment_method_data_projected"
),

"payment_method_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- billing_postal_code: The problem is that all values in the billing_postal_code column appear to be MD5 hashes rather than standard postal codes. MD5 hashes are 32-character hexadecimal strings, which is what we see in all these values. Postal codes typically consist of numbers or a combination of numbers and letters in a specific format depending on the country. Since we cannot reverse MD5 hashes to obtain the original postal codes, and we don't have any additional information about what these hashes represent, we cannot map them to correct postal codes. In this situation, the best approach is to map all these hash values to an empty string, indicating that the correct postal code information is not available.
    -- is_live: The problem is that the is_live column appears to be a boolean column, but it only contains the value '1'. This is unusual because a boolean column typically has both '0' and '1' values to represent false and true states respectively. The absence of '0' values suggests that either all entries are live (which is possible but uncommon), or that non-live entries are being represented in a different way (perhaps as NULL or an empty string, which are not shown in the provided value list).
    SELECT
        "payment_method_id",
        "billing_city",
        "billing_country",
        "billing_address_line1",
        "billing_address_line2",
        CASE
            WHEN "billing_postal_code" = '37a6259cc0c1dae299a7866489dff0bd' THEN NULL
            WHEN "billing_postal_code" = '4674554ec907d598a620d5b131a9f685' THEN NULL
            WHEN "billing_postal_code" = '44fdc5ad1a08aace32d53264bc95a4b7' THEN NULL
            WHEN "billing_postal_code" = '489981404dd301a023c9f75abed505f3' THEN NULL
            WHEN "billing_postal_code" = '61ee93b89af4fccf77f604ddbdbfc508' THEN NULL
            WHEN "billing_postal_code" = '65e512403849d438dc08889bf6461073' THEN NULL
            WHEN "billing_postal_code" = '8f84fb5cdc0dd814d6aeb4e78fc41845' THEN NULL
            WHEN "billing_postal_code" = '94472fbf2a4233129e7eb05c77f3321e' THEN NULL
            WHEN "billing_postal_code" = 'd41d8cd98f00b204e9800998ecf8427e' THEN NULL
            WHEN "billing_postal_code" = 'f55e51631ea375b777ec380d7d6804b8' THEN NULL
            WHEN "billing_postal_code" = 'fbed5cdfc14c8acab8bfc6fc608b57f3' THEN NULL
            ELSE "billing_postal_code"
        END AS "billing_postal_code",
        "billing_state",
        "billing_email",
        "billing_name",
        "billing_phone",
        "creation_date",
        "customer_id",
        "is_live",
        "payment_type"
    FROM "payment_method_data_projected_renamed"
),

"payment_method_data_projected_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- billing_address_line1: from FLOAT to VARCHAR
    -- billing_address_line2: from FLOAT to VARCHAR
    -- billing_city: from FLOAT to VARCHAR
    -- billing_country: from FLOAT to VARCHAR
    -- billing_phone: from FLOAT to VARCHAR
    -- billing_state: from FLOAT to VARCHAR
    -- creation_date: from VARCHAR to DATETIME
    -- is_live: from VARCHAR to BOOLEAN
    SELECT
        "payment_method_id",
        "billing_postal_code",
        "billing_email",
        "billing_name",
        "customer_id",
        "payment_type",
        CAST("billing_address_line1" AS VARCHAR) 
        AS "billing_address_line1",
        CAST("billing_address_line2" AS VARCHAR(MAX)) 
        AS "billing_address_line2",
        CAST("billing_city" AS VARCHAR(255)) 
        AS "billing_city",
        CAST("billing_country" AS VARCHAR) 
        AS "billing_country",
        CAST("billing_phone" AS VARCHAR) 
        AS "billing_phone",
        CAST("billing_state" AS VARCHAR) 
        AS "billing_state",
        CAST("creation_date" AS DATETIME) 
        AS "creation_date",
        CAST("is_live" AS BIT) 
        AS "is_live"
    FROM "payment_method_data_projected_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "payment_method_data_projected_renamed_cleaned_casted"
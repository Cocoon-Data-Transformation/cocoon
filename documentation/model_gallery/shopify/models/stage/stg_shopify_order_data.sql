-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"shopify_order_data_projected" AS (
    -- Projection: Selecting 65 out of 66 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "note",
        "email",
        "taxes_included",
        "currency",
        "subtotal_price",
        "total_tax",
        "total_price",
        "created_at",
        "updated_at",
        "name",
        "shipping_address_name",
        "shipping_address_first_name",
        "shipping_address_last_name",
        "shipping_address_company",
        "shipping_address_phone",
        "shipping_address_address_1",
        "shipping_address_address_2",
        "shipping_address_city",
        "shipping_address_country",
        "shipping_address_country_code",
        "shipping_address_province",
        "shipping_address_province_code",
        "shipping_address_zip",
        "shipping_address_latitude",
        "shipping_address_longitude",
        "billing_address_name",
        "billing_address_first_name",
        "billing_address_last_name",
        "billing_address_company",
        "billing_address_phone",
        "billing_address_address_1",
        "billing_address_address_2",
        "billing_address_city",
        "billing_address_country",
        "billing_address_country_code",
        "billing_address_province",
        "billing_address_province_code",
        "billing_address_zip",
        "billing_address_latitude",
        "billing_address_longitude",
        "customer_id",
        "location_id",
        "user_id",
        "number",
        "order_number",
        "financial_status",
        "fulfillment_status",
        "processed_at",
        "processing_method",
        "referring_site",
        "cancel_reason",
        "cancelled_at",
        "closed_at",
        "total_discounts",
        "total_line_items_price",
        "total_weight",
        "source_name",
        "browser_ip",
        "buyer_accepts_marketing",
        "token",
        "cart_token",
        "checkout_token",
        "test",
        "landing_site_base_url"
    FROM "shopify_order_data"
),

"shopify_order_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> order_id
    -- note -> order_notes
    -- email -> customer_email
    -- total_tax -> order_tax
    -- total_price -> order_total
    -- updated_at -> last_updated
    -- name -> order_identifier
    -- shipping_address_name -> shipping_full_name
    -- shipping_address_first_name -> shipping_first_name
    -- shipping_address_last_name -> shipping_last_name
    -- shipping_address_company -> shipping_company
    -- shipping_address_phone -> shipping_phone
    -- shipping_address_address_1 -> shipping_address_line1
    -- shipping_address_address_2 -> shipping_address_line2
    -- shipping_address_city -> shipping_city
    -- shipping_address_country -> shipping_country
    -- shipping_address_country_code -> shipping_country_code
    -- shipping_address_province -> shipping_province
    -- shipping_address_province_code -> shipping_province_code
    -- shipping_address_zip -> shipping_zip
    -- shipping_address_latitude -> shipping_latitude
    -- shipping_address_longitude -> shipping_longitude
    -- billing_address_name -> billing_full_name
    -- billing_address_first_name -> billing_first_name
    -- billing_address_last_name -> billing_last_name
    -- billing_address_company -> billing_company
    -- billing_address_phone -> billing_phone
    -- billing_address_address_1 -> billing_address_line1
    -- billing_address_address_2 -> billing_address_line2
    -- billing_address_city -> billing_city
    -- billing_address_country -> billing_country
    -- billing_address_country_code -> billing_country_code
    -- billing_address_province -> billing_province
    -- billing_address_province_code -> billing_province_code
    -- billing_address_zip -> billing_zip
    -- billing_address_latitude -> billing_latitude
    -- billing_address_longitude -> billing_longitude
    -- location_id -> store_location_id
    -- number -> order_number
    -- order_number -> alt_order_number
    -- financial_status -> payment_status
    -- fulfillment_status -> shipping_status
    -- total_weight -> order_weight
    -- source_name -> order_source
    -- browser_ip -> customer_ip
    -- buyer_accepts_marketing -> marketing_consent
    -- token -> order_token
    -- test -> is_test_order
    -- landing_site_base_url -> landing_page_url
    SELECT 
        "id" AS "order_id",
        "note" AS "order_notes",
        "email" AS "customer_email",
        "taxes_included",
        "currency",
        "subtotal_price",
        "total_tax" AS "order_tax",
        "total_price" AS "order_total",
        "created_at",
        "updated_at" AS "last_updated",
        "name" AS "order_identifier",
        "shipping_address_name" AS "shipping_full_name",
        "shipping_address_first_name" AS "shipping_first_name",
        "shipping_address_last_name" AS "shipping_last_name",
        "shipping_address_company" AS "shipping_company",
        "shipping_address_phone" AS "shipping_phone",
        "shipping_address_address_1" AS "shipping_address_line1",
        "shipping_address_address_2" AS "shipping_address_line2",
        "shipping_address_city" AS "shipping_city",
        "shipping_address_country" AS "shipping_country",
        "shipping_address_country_code" AS "shipping_country_code",
        "shipping_address_province" AS "shipping_province",
        "shipping_address_province_code" AS "shipping_province_code",
        "shipping_address_zip" AS "shipping_zip",
        "shipping_address_latitude" AS "shipping_latitude",
        "shipping_address_longitude" AS "shipping_longitude",
        "billing_address_name" AS "billing_full_name",
        "billing_address_first_name" AS "billing_first_name",
        "billing_address_last_name" AS "billing_last_name",
        "billing_address_company" AS "billing_company",
        "billing_address_phone" AS "billing_phone",
        "billing_address_address_1" AS "billing_address_line1",
        "billing_address_address_2" AS "billing_address_line2",
        "billing_address_city" AS "billing_city",
        "billing_address_country" AS "billing_country",
        "billing_address_country_code" AS "billing_country_code",
        "billing_address_province" AS "billing_province",
        "billing_address_province_code" AS "billing_province_code",
        "billing_address_zip" AS "billing_zip",
        "billing_address_latitude" AS "billing_latitude",
        "billing_address_longitude" AS "billing_longitude",
        "customer_id",
        "location_id" AS "store_location_id",
        "user_id",
        "number" AS "order_number",
        "order_number" AS "alt_order_number",
        "financial_status" AS "payment_status",
        "fulfillment_status" AS "shipping_status",
        "processed_at",
        "processing_method",
        "referring_site",
        "cancel_reason",
        "cancelled_at",
        "closed_at",
        "total_discounts",
        "total_line_items_price",
        "total_weight" AS "order_weight",
        "source_name" AS "order_source",
        "browser_ip" AS "customer_ip",
        "buyer_accepts_marketing" AS "marketing_consent",
        "token" AS "order_token",
        "cart_token",
        "checkout_token",
        "test" AS "is_test_order",
        "landing_site_base_url" AS "landing_page_url"
    FROM "shopify_order_data_projected"
),

"shopify_order_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- shipping_full_name: The problem is that the shipping_full_name column contains hashed or encrypted strings instead of human-readable full names. These values are meaningless for practical use and do not represent actual customer names. The correct values should be the decrypted or unhashed full names, but without access to the decryption key or original data, it's impossible to recover the real names. In this case, the best approach is to map these encrypted values to empty strings to indicate that the real names are unknown or unavailable. 
    -- shipping_first_name: The problem is that the shipping_first_name column contains hashed or encrypted values instead of readable first names. These values are not meaningful or usable as actual names. The correct values should be decrypted first names, but without access to the decryption key, we cannot recover the original names. 
    -- shipping_last_name: The problem is that both values in the shipping_last_name column appear to be hashed or encrypted strings instead of actual last names. These values are likely placeholders or the result of data anonymization, and do not represent real last names. The correct values should be actual last names, but since we don't have access to the original data, we cannot map these to real names. 
    -- shipping_company: The problem is that the shipping_company column contains an MD5 hash value instead of an actual shipping company name. MD5 hash 'd41d8cd98f00b204e9800998ecf8427e' is known to be the hash of an empty string, which suggests that this column was likely left empty and then hashed, possibly as a placeholder or due to a data processing error. The correct values should be actual shipping company names, but since we don't have that information, the best approach is to map this to an empty string to indicate missing data. 
    -- shipping_phone: The problem is that the shipping_phone column contains an MD5 hash value instead of an actual phone number. MD5 hashes are 32-character hexadecimal strings, which is what we see here. This value 'd41d8cd98f00b204e9800998ecf8427e' is actually the MD5 hash of an empty string. It's likely that this hash was used as a placeholder or default value when no phone number was provided. The correct value for a missing phone number should be an empty string or null value, not an MD5 hash. 
    -- shipping_address_line2: The problem is that the shipping_address_line2 column contains hexadecimal strings instead of typical address information. These values appear to be some kind of hashed or encrypted data rather than actual address details. Since we don't have the means to decrypt these values and they don't represent valid address information, the correct approach is to map them to empty strings. 
    -- shipping_city: The problem is that the shipping_city column contains hashed or encrypted strings instead of readable city names. These values are meaningless for analysis or human interpretation. Since we don't have a way to decrypt these hashes back to the original city names, and we don't have any additional information about what cities they might represent, the correct approach is to map these to empty strings. 
    -- shipping_country: The problem is that the shipping_country column contains an encoded or hashed value instead of a proper country name. This value '89f9c9f489be2a83cf57e53b9197d288' appears to be a 32-character hexadecimal string, which is likely the result of a hashing algorithm (possibly MD5). This is unusual because we expect country names to be human-readable text. The correct values should be actual country names, but without additional information or a way to decode this hash, we cannot determine the intended country.  
    -- shipping_country_code: The problem is that the value '79cba1185463850dedba31f172f1dc5b' is not a valid country code. It appears to be a hash or some form of encoded data rather than a standard 2 or 3 letter country code. Without more context about the data source or what this value is supposed to represent, it's impossible to map it to a correct country code. The correct values for this column should be standard ISO 3166-1 alpha-2 or alpha-3 country codes. 
    -- shipping_province: The problem is that the shipping_province column contains an MD5 hash value ('d41d8cd98f00b204e9800998ecf8427e') instead of actual province names or abbreviations. This hash value is unusual and meaningless in the context of shipping provinces. The correct values should be actual province names or abbreviations, but since we don't have that information, we should map this to an empty string to indicate missing data. 
    -- shipping_zip: The problem is that both values in the shipping_zip column are hashed or encrypted strings instead of standard ZIP codes. ZIP codes in the United States are typically 5-digit numbers, sometimes followed by a hyphen and 4 additional digits (ZIP+4 code). The current values are clearly not in this format and appear to be some form of obfuscated data. Since we don't have access to the decryption method or original ZIP codes, we can't map these to actual ZIP codes. The correct approach would be to treat these as invalid or unknown ZIP codes. 
    -- shipping_latitude: The problem is that both values in the shipping_latitude column are hash-like strings instead of numerical latitude values. Latitude values should typically be decimal numbers ranging from -90 to 90 degrees. These hash-like strings are meaningless for geographical coordinates and appear to be some kind of encoding or error. Without additional information to decode these strings into actual latitude values, the correct approach is to map them to empty strings to indicate missing or invalid data. 
    -- shipping_longitude: The problem is that the shipping_longitude column contains hashed or encoded strings instead of actual longitude values. Longitude values should be numeric, typically ranging from -180 to 180 degrees. The current values appear to be MD5 hashes or some other form of encoded data, which are not meaningful for geographic coordinates. Since we don't have the actual longitude values and can't decode these hashes, the correct approach is to map these to empty strings to indicate missing data. 
    -- billing_full_name: The problem is that the billing_full_name column contains encrypted or hashed strings instead of human-readable names. These values are not meaningful for analysis or display purposes. Since we don't have access to the original names and cannot decrypt the hashes, the correct approach is to map these values to empty strings to indicate that the real names are not available. 
    -- billing_first_name: The problem is that both values in the billing_first_name column are hashed or encrypted strings instead of actual first names. These values are unusable for identifying individuals or for any meaningful analysis. The correct values should be actual first names, but since we don't have access to the original data or the decryption method, we can't recover the real names. 
    -- billing_last_name: The problem is that the billing_last_name column contains hashed or encrypted strings instead of readable last names. This is unusual because typically last names should be human-readable text, not cryptographic hashes. The correct values should be the actual last names of the customers, but since we don't have access to the decryption method or original data, we can't recover the real names. In this case, it's best to map these values to an empty string to indicate that the real last name is not available. 
    -- billing_company: The problem is that the billing_company column contains an MD5 hash value instead of a recognizable company name. This hash value ('d41d8cd98f00b204e9800998ecf8427e') is actually the MD5 hash of an empty string. This suggests that the column was likely encrypted or hashed for data protection purposes, or it's being used as a placeholder for missing data. The correct value in this case should be an empty string, as the hash represents no data. 
    -- billing_phone: The problem is that the billing_phone column contains an MD5 hash value instead of an actual phone number. The value 'd41d8cd98f00b204e9800998ecf8427e' is the MD5 hash of an empty string. This suggests that the phone numbers were hashed for privacy reasons, or there was an error in data processing that resulted in hashing empty values. The correct values should be actual phone numbers, but since we don't have access to the original data, we can't reconstruct them. In this case, it's best to represent missing or unknown data. 
    -- billing_address_line1: The problem is that both values in the billing_address_line1 column appear to be hashed or encrypted strings rather than readable address information. This is unusual because billing addresses are typically stored as plain text for practical use. The correct values should be the actual billing address lines, but since we don't have access to the original data or decryption method, we cannot recover the true addresses. 
    -- billing_address_line2: The problem is that both values in the billing_address_line2 column appear to be hashed or encrypted data rather than readable text for address lines. This suggests that the data has been obfuscated, possibly for privacy reasons. However, address line 2 is typically optional and often left blank. Since we cannot decrypt or reverse the hashing to obtain the original values, and address line 2 is commonly empty, the most appropriate action is to map these unusual values to an empty string. 
    -- billing_city: The problem is that the billing_city column contains hashed or encrypted strings instead of readable city names. These values are not meaningful for analysis or display purposes. Since we don't have access to the decryption key or the original city names, we cannot map these to actual city names. The correct approach would be to treat these as unknown or invalid data. 
    -- billing_country: The problem is that the billing_country column contains a single value that appears to be a 32-character alphanumeric hash instead of an actual country name. This is highly unusual and incorrect for a country field. The correct values should be actual country names or codes. 
    -- billing_country_code: The problem is that the value '79cba1185463850dedba31f172f1dc5b' is not a valid country code. It appears to be a hash or some form of encoded data, which is not appropriate for a country code field. Country codes are typically 2 or 3 letter abbreviations (e.g., 'US' for United States, 'GB' for Great Britain). Since we don't have any information about what this value is supposed to represent or what the correct country code should be, we can't map it to a valid country code. In this case, it's best to map it to an empty string to indicate missing or invalid data. 
    -- billing_province: The problem is that the billing_province column contains a hash-like string instead of readable province names. The value 'd41d8cd98f00b204e9800998ecf8427e' is unusual because it appears to be an MD5 hash, which is typically used for data encryption or verification, not for representing geographical locations. This value is meaningless in the context of a province name. The correct values should be actual province names or an empty string if the information is not available. 
    -- billing_zip: The problem is that both values in the billing_zip column are unusual because they are long alphanumeric strings, not standard ZIP code formats. ZIP codes in the United States are typically 5 digits, or sometimes 9 digits (ZIP+4 format). These values appear to be hashed or encrypted data, possibly due to a data processing error or security measure. Since we don't have access to the original ZIP codes and can't decode these values, we can't map them to correct ZIP codes. The most appropriate action is to map these unusual values to an empty string, indicating that the true ZIP code is unknown or unavailable. 
    -- billing_latitude: The problem is that the billing_latitude column contains hashed strings instead of numerical latitude values. Latitude values should typically be decimal numbers between -90 and 90 degrees. The hashed strings are meaningless in the context of geographical coordinates and cannot be directly converted to valid latitudes. Since we don't have access to the original data or the hashing algorithm, we cannot recover the actual latitude values. 
    -- billing_longitude: The problem is that both values in the billing_longitude column appear to be hashed or encrypted data rather than actual longitude values. Longitude values should be numeric, typically ranging from -180 to 180 degrees. The current values are clearly not valid longitude coordinates. Since we don't have the key to decrypt these values or any way to determine the actual longitudes they represent, the correct approach is to map them to empty strings to indicate missing data. 
    -- order_source: The problem is that '294517' is a numeric string that doesn't clearly represent an order source. It's unusual because it doesn't provide any meaningful information about the source of the order, unlike 'web' which is a clear and common order source. The correct values should all be descriptive of the order source, with 'web' being the only valid value in this dataset. 
    SELECT
        "order_id",
        "order_notes",
        "customer_email",
        "taxes_included",
        "currency",
        "subtotal_price",
        "order_tax",
        "order_total",
        "created_at",
        "last_updated",
        "order_identifier",
        CASE
            WHEN "shipping_full_name" = 'c8189c7add9755e66391b58ecc12b3e2' THEN ''
            WHEN "shipping_full_name" = '8b121314a4d97bc9dc15bfba8518ec88' THEN ''
            ELSE "shipping_full_name"
        END AS "shipping_full_name",
        CASE
            WHEN "shipping_first_name" = 'd3bae70c9d49bb7cb5a74cdd0eae7fc4' THEN ''
            WHEN "shipping_first_name" = 'f0962b7a185488ecb752cedac1038349' THEN ''
            ELSE "shipping_first_name"
        END AS "shipping_first_name",
        CASE
            WHEN "shipping_last_name" = '0dd89cff60965dff8f9ea2bc952a5474' THEN ''
            WHEN "shipping_last_name" = 'aa35cb67c26e64bb81a1bf3f17e858ba' THEN ''
            ELSE "shipping_last_name"
        END AS "shipping_last_name",
        CASE
            WHEN "shipping_company" = 'd41d8cd98f00b204e9800998ecf8427e' THEN ''
            ELSE "shipping_company"
        END AS "shipping_company",
        CASE
            WHEN "shipping_phone" = 'd41d8cd98f00b204e9800998ecf8427e' THEN ''
            ELSE "shipping_phone"
        END AS "shipping_phone",
        "shipping_address_line1",
        CASE
            WHEN "shipping_address_line2" = '70111f8840ccbd8b1007cc3f387ced6b' THEN ''
            WHEN "shipping_address_line2" = 'bc9b8576178dcd886639ba718f1d45c8' THEN ''
            ELSE "shipping_address_line2"
        END AS "shipping_address_line2",
        CASE
            WHEN "shipping_city" = '1ac412baeba98370017c73df41c98a07' THEN ''
            WHEN "shipping_city" = 'ac08c606d455cde42980f980524a8038' THEN ''
            ELSE "shipping_city"
        END AS "shipping_city",
        CASE
            WHEN "shipping_country" = '89f9c9f489be2a83cf57e53b9197d288' THEN ''
            ELSE "shipping_country"
        END AS "shipping_country",
        CASE
            WHEN "shipping_country_code" = '79cba1185463850dedba31f172f1dc5b' THEN ''
            ELSE "shipping_country_code"
        END AS "shipping_country_code",
        CASE
            WHEN "shipping_province" = 'd41d8cd98f00b204e9800998ecf8427e' THEN ''
            ELSE "shipping_province"
        END AS "shipping_province",
        "shipping_province_code",
        CASE
            WHEN "shipping_zip" = '2357e65b582faa0a2da3603b16fa4a7f' THEN ''
            WHEN "shipping_zip" = '00079ce435afddc28205639142773870' THEN ''
            ELSE "shipping_zip"
        END AS "shipping_zip",
        CASE
            WHEN "shipping_latitude" = '75c29d6dd29594a652fcbd7c4c279a29' THEN ''
            WHEN "shipping_latitude" = 'd97319f64674c02595f2989019970fc8' THEN ''
            ELSE "shipping_latitude"
        END AS "shipping_latitude",
        CASE
            WHEN "shipping_longitude" = '75468fbebc28e02ec5d4f54f4cbd4099' THEN ''
            WHEN "shipping_longitude" = 'c08dae474c5d4d3326fd6764d2a0ebe6' THEN ''
            ELSE "shipping_longitude"
        END AS "shipping_longitude",
        CASE
            WHEN "billing_full_name" = 'c8189c7add9755e66391b58ecc12b3e2' THEN ''
            WHEN "billing_full_name" = '8b121314a4d97bc9dc15bfba8518ec88' THEN ''
            ELSE "billing_full_name"
        END AS "billing_full_name",
        CASE
            WHEN "billing_first_name" = 'd3bae70c9d49bb7cb5a74cdd0eae7fc4' THEN ''
            WHEN "billing_first_name" = 'f0962b7a185488ecb752cedac1038349' THEN ''
            ELSE "billing_first_name"
        END AS "billing_first_name",
        CASE
            WHEN "billing_last_name" = '0dd89cff60965dff8f9ea2bc952a5474' THEN ''
            WHEN "billing_last_name" = 'aa35cb67c26e64bb81a1bf3f17e858ba' THEN ''
            ELSE "billing_last_name"
        END AS "billing_last_name",
        CASE
            WHEN "billing_company" = 'd41d8cd98f00b204e9800998ecf8427e' THEN ''
            ELSE "billing_company"
        END AS "billing_company",
        CASE
            WHEN "billing_phone" = 'd41d8cd98f00b204e9800998ecf8427e' THEN ''
            ELSE "billing_phone"
        END AS "billing_phone",
        CASE
            WHEN "billing_address_line1" = '1ff1de774005f8da13f42943881c655f' THEN ''
            WHEN "billing_address_line1" = 'd6f4a399883df85d9d4b3a02bf6e738a' THEN ''
            ELSE "billing_address_line1"
        END AS "billing_address_line1",
        CASE
            WHEN "billing_address_line2" = '70111f8840ccbd8b1007cc3f387ced6b' THEN ''
            WHEN "billing_address_line2" = 'bc9b8576178dcd886639ba718f1d45c8' THEN ''
            ELSE "billing_address_line2"
        END AS "billing_address_line2",
        CASE
            WHEN "billing_city" = '1ac412baeba98370017c73df41c98a07' THEN 'UNKNOWN'
            WHEN "billing_city" = 'ac08c606d455cde42980f980524a8038' THEN 'UNKNOWN'
            ELSE "billing_city"
        END AS "billing_city",
        CASE
            WHEN "billing_country" = '89f9c9f489be2a83cf57e53b9197d288' THEN ''
            ELSE "billing_country"
        END AS "billing_country",
        CASE
            WHEN "billing_country_code" = '79cba1185463850dedba31f172f1dc5b' THEN ''
            ELSE "billing_country_code"
        END AS "billing_country_code",
        CASE
            WHEN "billing_province" = 'd41d8cd98f00b204e9800998ecf8427e' THEN ''
            ELSE "billing_province"
        END AS "billing_province",
        "billing_province_code",
        CASE
            WHEN "billing_zip" = '2357e65b582faa0a2da3603b16fa4a7f' THEN ''
            WHEN "billing_zip" = '00079ce435afddc28205639142773870' THEN ''
            ELSE "billing_zip"
        END AS "billing_zip",
        CASE
            WHEN "billing_latitude" = '75c29d6dd29594a652fcbd7c4c279a29' THEN ''
            WHEN "billing_latitude" = 'd97319f64674c02595f2989019970fc8' THEN ''
            ELSE "billing_latitude"
        END AS "billing_latitude",
        CASE
            WHEN "billing_longitude" = '75468fbebc28e02ec5d4f54f4cbd4099' THEN ''
            WHEN "billing_longitude" = 'c08dae474c5d4d3326fd6764d2a0ebe6' THEN ''
            ELSE "billing_longitude"
        END AS "billing_longitude",
        "customer_id",
        "store_location_id",
        "user_id",
        "order_number",
        "alt_order_number",
        "payment_status",
        "shipping_status",
        "processed_at",
        "processing_method",
        "referring_site",
        "cancel_reason",
        "cancelled_at",
        "closed_at",
        "total_discounts",
        "total_line_items_price",
        "order_weight",
        CASE
            WHEN "order_source" = '294517' THEN ''
            ELSE "order_source"
        END AS "order_source",
        "customer_ip",
        "marketing_consent",
        "order_token",
        "cart_token",
        "checkout_token",
        "is_test_order",
        "landing_page_url"
    FROM "shopify_order_data_projected_renamed"
),

"shopify_order_data_projected_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- shipping_full_name: ['']
    -- shipping_first_name: ['']
    -- shipping_last_name: ['']
    -- shipping_company: ['']
    -- shipping_phone: ['']
    -- shipping_address_line2: ['']
    -- shipping_city: ['']
    -- shipping_country: ['']
    -- shipping_country_code: ['']
    -- shipping_province: ['']
    -- shipping_zip: ['']
    -- shipping_latitude: ['']
    -- shipping_longitude: ['']
    -- billing_full_name: ['']
    -- billing_first_name: ['']
    -- billing_last_name: ['']
    -- billing_company: ['']
    -- billing_phone: ['']
    -- billing_address_line1: ['']
    -- billing_address_line2: ['']
    -- billing_city: ['UNKNOWN']
    -- billing_country: ['']
    -- billing_country_code: ['']
    -- billing_province: ['']
    -- billing_zip: ['']
    -- billing_latitude: ['']
    -- billing_longitude: ['']
    -- order_source: ['']
    SELECT 
        CASE
            WHEN "shipping_full_name" = '' THEN NULL
            ELSE "shipping_full_name"
        END AS "shipping_full_name",
        CASE
            WHEN "shipping_first_name" = '' THEN NULL
            ELSE "shipping_first_name"
        END AS "shipping_first_name",
        CASE
            WHEN "shipping_last_name" = '' THEN NULL
            ELSE "shipping_last_name"
        END AS "shipping_last_name",
        CASE
            WHEN "shipping_company" = '' THEN NULL
            ELSE "shipping_company"
        END AS "shipping_company",
        CASE
            WHEN "shipping_phone" = '' THEN NULL
            ELSE "shipping_phone"
        END AS "shipping_phone",
        CASE
            WHEN "shipping_address_line2" = '' THEN NULL
            ELSE "shipping_address_line2"
        END AS "shipping_address_line2",
        CASE
            WHEN "shipping_city" = '' THEN NULL
            ELSE "shipping_city"
        END AS "shipping_city",
        CASE
            WHEN "shipping_country" = '' THEN NULL
            ELSE "shipping_country"
        END AS "shipping_country",
        CASE
            WHEN "shipping_country_code" = '' THEN NULL
            ELSE "shipping_country_code"
        END AS "shipping_country_code",
        CASE
            WHEN "shipping_province" = '' THEN NULL
            ELSE "shipping_province"
        END AS "shipping_province",
        CASE
            WHEN "shipping_zip" = '' THEN NULL
            ELSE "shipping_zip"
        END AS "shipping_zip",
        CASE
            WHEN "shipping_latitude" = '' THEN NULL
            ELSE "shipping_latitude"
        END AS "shipping_latitude",
        CASE
            WHEN "shipping_longitude" = '' THEN NULL
            ELSE "shipping_longitude"
        END AS "shipping_longitude",
        CASE
            WHEN "billing_full_name" = '' THEN NULL
            ELSE "billing_full_name"
        END AS "billing_full_name",
        CASE
            WHEN "billing_first_name" = '' THEN NULL
            ELSE "billing_first_name"
        END AS "billing_first_name",
        CASE
            WHEN "billing_last_name" = '' THEN NULL
            ELSE "billing_last_name"
        END AS "billing_last_name",
        CASE
            WHEN "billing_company" = '' THEN NULL
            ELSE "billing_company"
        END AS "billing_company",
        CASE
            WHEN "billing_phone" = '' THEN NULL
            ELSE "billing_phone"
        END AS "billing_phone",
        CASE
            WHEN "billing_address_line1" = '' THEN NULL
            ELSE "billing_address_line1"
        END AS "billing_address_line1",
        CASE
            WHEN "billing_address_line2" = '' THEN NULL
            ELSE "billing_address_line2"
        END AS "billing_address_line2",
        CASE
            WHEN "billing_city" = 'UNKNOWN' THEN NULL
            ELSE "billing_city"
        END AS "billing_city",
        CASE
            WHEN "billing_country" = '' THEN NULL
            ELSE "billing_country"
        END AS "billing_country",
        CASE
            WHEN "billing_country_code" = '' THEN NULL
            ELSE "billing_country_code"
        END AS "billing_country_code",
        CASE
            WHEN "billing_province" = '' THEN NULL
            ELSE "billing_province"
        END AS "billing_province",
        CASE
            WHEN "billing_zip" = '' THEN NULL
            ELSE "billing_zip"
        END AS "billing_zip",
        CASE
            WHEN "billing_latitude" = '' THEN NULL
            ELSE "billing_latitude"
        END AS "billing_latitude",
        CASE
            WHEN "billing_longitude" = '' THEN NULL
            ELSE "billing_longitude"
        END AS "billing_longitude",
        CASE
            WHEN "order_source" = '' THEN NULL
            ELSE "order_source"
        END AS "order_source",
        "shipping_province_code",
        "user_id",
        "referring_site",
        "payment_status",
        "order_number",
        "order_identifier",
        "cancel_reason",
        "order_token",
        "order_notes",
        "total_discounts",
        "subtotal_price",
        "order_id",
        "landing_page_url",
        "last_updated",
        "billing_province_code",
        "total_line_items_price",
        "order_weight",
        "closed_at",
        "customer_ip",
        "checkout_token",
        "customer_email",
        "customer_id",
        "currency",
        "order_tax",
        "order_total",
        "cancelled_at",
        "processed_at",
        "taxes_included",
        "is_test_order",
        "alt_order_number",
        "shipping_address_line1",
        "shipping_status",
        "processing_method",
        "cart_token",
        "created_at",
        "store_location_id",
        "marketing_consent"
    FROM "shopify_order_data_projected_renamed_cleaned"
),

"shopify_order_data_projected_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- alt_order_number: from INT to VARCHAR
    -- billing_latitude: from VARCHAR to DECIMAL
    -- billing_longitude: from VARCHAR to DECIMAL
    -- billing_province_code: from DECIMAL to VARCHAR
    -- cancel_reason: from DECIMAL to VARCHAR
    -- cancelled_at: from DECIMAL to TIMESTAMP
    -- closed_at: from VARCHAR to TIMESTAMP
    -- created_at: from VARCHAR to TIMESTAMP
    -- customer_id: from INT to VARCHAR
    -- last_updated: from VARCHAR to TIMESTAMP
    -- order_id: from INT to VARCHAR
    -- order_tax: from INT to DECIMAL
    -- order_weight: from INT to DECIMAL
    -- processed_at: from VARCHAR to TIMESTAMP
    -- shipping_latitude: from VARCHAR to DECIMAL
    -- shipping_longitude: from VARCHAR to DECIMAL
    -- shipping_province_code: from DECIMAL to VARCHAR
    -- store_location_id: from DECIMAL to VARCHAR
    -- user_id: from DECIMAL to VARCHAR
    SELECT
        "shipping_full_name",
        "shipping_first_name",
        "shipping_last_name",
        "shipping_company",
        "shipping_phone",
        "shipping_address_line2",
        "shipping_city",
        "shipping_country",
        "shipping_country_code",
        "shipping_province",
        "shipping_zip",
        "billing_full_name",
        "billing_first_name",
        "billing_last_name",
        "billing_company",
        "billing_phone",
        "billing_address_line1",
        "billing_address_line2",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_province",
        "billing_zip",
        "order_source",
        "referring_site",
        "payment_status",
        "order_number",
        "order_identifier",
        "order_token",
        "order_notes",
        "total_discounts",
        "subtotal_price",
        "landing_page_url",
        "total_line_items_price",
        "customer_ip",
        "checkout_token",
        "customer_email",
        "currency",
        "order_total",
        "taxes_included",
        "is_test_order",
        "shipping_address_line1",
        "shipping_status",
        "processing_method",
        "cart_token",
        "marketing_consent",
        CAST("alt_order_number" AS VARCHAR) AS "alt_order_number",
        CAST("billing_latitude" AS DECIMAL) AS "billing_latitude",
        CAST("billing_longitude" AS DECIMAL) AS "billing_longitude",
        CAST("billing_province_code" AS VARCHAR) AS "billing_province_code",
        CAST("cancel_reason" AS VARCHAR) AS "cancel_reason",
        CAST("cancelled_at" AS TIMESTAMP) AS "cancelled_at",
        CAST("closed_at" AS TIMESTAMP) AS "closed_at",
        CAST("created_at" AS TIMESTAMP) AS "created_at",
        CAST("customer_id" AS VARCHAR) AS "customer_id",
        CAST("last_updated" AS TIMESTAMP) AS "last_updated",
        CAST("order_id" AS VARCHAR) AS "order_id",
        CAST("order_tax" AS DECIMAL) AS "order_tax",
        CAST("order_weight" AS DECIMAL) AS "order_weight",
        CAST("processed_at" AS TIMESTAMP) AS "processed_at",
        CAST("shipping_latitude" AS DECIMAL) AS "shipping_latitude",
        CAST("shipping_longitude" AS DECIMAL) AS "shipping_longitude",
        CAST("shipping_province_code" AS VARCHAR) AS "shipping_province_code",
        CAST("store_location_id" AS VARCHAR) AS "store_location_id",
        CAST("user_id" AS VARCHAR) AS "user_id"
    FROM "shopify_order_data_projected_renamed_cleaned_null"
),

"shopify_order_data_projected_renamed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 23 columns with unacceptable missing values
    -- cart_token has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- checkout_token has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- closed_at has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- customer_ip has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- landing_page_url has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- order_notes has 66.67 percent missing. Strategy: 🔄 Unchanged
    -- order_source has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- processing_method has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- referring_site has 33.33 percent missing. Strategy: 🔄 Unchanged
    -- shipping_city has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_country has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_country_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_first_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_full_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_last_name has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_latitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_longitude has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_phone has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_province has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_province_code has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- shipping_zip has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- store_location_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- user_id has 100.0 percent missing. Strategy: 🗑️ Drop Column
    SELECT
        "shipping_company",
        "shipping_address_line2",
        "billing_full_name",
        "billing_first_name",
        "billing_last_name",
        "billing_company",
        "billing_phone",
        "billing_address_line1",
        "billing_address_line2",
        "billing_city",
        "billing_country",
        "billing_country_code",
        "billing_province",
        "billing_zip",
        "order_source",
        "referring_site",
        "payment_status",
        "order_number",
        "order_identifier",
        "order_token",
        "order_notes",
        "total_discounts",
        "subtotal_price",
        "landing_page_url",
        "total_line_items_price",
        "customer_ip",
        "checkout_token",
        "customer_email",
        "currency",
        "order_total",
        "taxes_included",
        "is_test_order",
        "shipping_address_line1",
        "shipping_status",
        "processing_method",
        "cart_token",
        "marketing_consent",
        "alt_order_number",
        "billing_latitude",
        "billing_longitude",
        "billing_province_code",
        "cancel_reason",
        "cancelled_at",
        "closed_at",
        "created_at",
        "customer_id",
        "last_updated",
        "order_id",
        "order_tax",
        "order_weight",
        "processed_at"
    FROM "shopify_order_data_projected_renamed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "shopify_order_data_projected_renamed_cleaned_null_casted_missing_handled"
-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"used_car_data_new_renamed" AS (
    -- Rename: Renaming columns
    -- id_ucd -> record_id
    -- id_merk -> make
    -- type -> variant
    -- id_transmission -> transmission_type
    -- id_fuel_type -> fuel_type
    -- door -> num_doors
    -- cylinder_size -> engine_size_cc
    -- cylinder_total -> num_cylinders
    -- turbo -> has_turbo
    -- price_cash -> cash_price
    -- price_credit -> credit_price
    -- nilai_jual_pkb -> tax_sale_value
    -- pkb_pokok -> base_vehicle_tax
    -- stnk_date -> registration_expiry
    -- swdkllj -> accident_fund_fee
    -- showroom_location -> showroom_address
    -- photo_1 -> photo1_url
    -- photo_2 -> photo2_url
    -- photo_3 -> photo3_url
    -- link -> listing_url
    SELECT 
        "id_ucd" AS "record_id",
        "id_merk" AS "make",
        "type" AS "variant",
        "model",
        "color",
        "year_",
        "id_transmission" AS "transmission_type",
        "id_fuel_type" AS "fuel_type",
        "door" AS "num_doors",
        "cylinder_size" AS "engine_size_cc",
        "cylinder_total" AS "num_cylinders",
        "turbo" AS "has_turbo",
        "mileage",
        "license_plate",
        "price_cash" AS "cash_price",
        "price_credit" AS "credit_price",
        "nilai_jual_pkb" AS "tax_sale_value",
        "pkb_pokok" AS "base_vehicle_tax",
        "stnk_date" AS "registration_expiry",
        "levy_date",
        "swdkllj" AS "accident_fund_fee",
        "total_levy",
        "showroom_name",
        "showroom_location" AS "showroom_address",
        "showroom_regency",
        "photo_1" AS "photo1_url",
        "photo_2" AS "photo2_url",
        "photo_3" AS "photo3_url",
        "link" AS "listing_url",
        "created_at",
        "updated_at"
    FROM "used_car_data_new"
),

"used_car_data_new_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- model: The problem is inconsistent capitalization of the same car model names. 'MINIBUS' and 'Minibus' refer to the same model, as do 'SEDAN' and 'Sedan'. The correct values should use consistent capitalization. Since the uppercase versions are more frequent, 'Minibus' and 'Sedan' should be mapped to 'MINIBUS' and 'SEDAN'. 
    SELECT
        "record_id",
        "make",
        "variant",
        CASE
            WHEN "model" = 'Minibus' THEN 'MINIBUS'
            WHEN "model" = 'Sedan' THEN 'SEDAN'
            ELSE "model"
        END AS "model",
        "color",
        "year_",
        "transmission_type",
        "fuel_type",
        "num_doors",
        "engine_size_cc",
        "num_cylinders",
        "has_turbo",
        "mileage",
        "license_plate",
        "cash_price",
        "credit_price",
        "tax_sale_value",
        "base_vehicle_tax",
        "registration_expiry",
        "levy_date",
        "accident_fund_fee",
        "total_levy",
        "showroom_name",
        "showroom_address",
        "showroom_regency",
        "photo1_url",
        "photo2_url",
        "photo3_url",
        "listing_url",
        "created_at",
        "updated_at"
    FROM "used_car_data_new_renamed"
),

"used_car_data_new_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- license_plate: ['10000']
    SELECT 
        CASE
            WHEN "license_plate" = '10000' THEN NULL
            ELSE "license_plate"
        END AS "license_plate",
        "photo2_url",
        "fuel_type",
        "has_turbo",
        "total_levy",
        "year_",
        "num_doors",
        "color",
        "variant",
        "model",
        "base_vehicle_tax",
        "make",
        "tax_sale_value",
        "photo1_url",
        "cash_price",
        "showroom_name",
        "transmission_type",
        "showroom_regency",
        "updated_at",
        "listing_url",
        "registration_expiry",
        "mileage",
        "engine_size_cc",
        "created_at",
        "photo3_url",
        "credit_price",
        "record_id",
        "showroom_address",
        "levy_date",
        "num_cylinders",
        "accident_fund_fee"
    FROM "used_car_data_new_renamed_cleaned"
),

"used_car_data_new_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- created_at: from VARCHAR to TIMESTAMP
    -- has_turbo: from INT to BOOLEAN
    -- levy_date: from VARCHAR to DATE
    -- listing_url: from FLOAT to VARCHAR
    -- photo2_url: from FLOAT to VARCHAR
    -- photo3_url: from FLOAT to VARCHAR
    -- registration_expiry: from VARCHAR to DATE
    -- transmission_type: from INT to VARCHAR
    -- updated_at: from VARCHAR to TIMESTAMP
    SELECT
        "license_plate",
        "fuel_type",
        "total_levy",
        "year_",
        "num_doors",
        "color",
        "variant",
        "model",
        "base_vehicle_tax",
        "make",
        "tax_sale_value",
        "photo1_url",
        "cash_price",
        "showroom_name",
        "showroom_regency",
        "mileage",
        "engine_size_cc",
        "credit_price",
        "record_id",
        "showroom_address",
        "num_cylinders",
        "accident_fund_fee",
        TO_TIMESTAMP("created_at", 'MM/DD/YYYY HH24:MI') AS "created_at",
        CAST("has_turbo" AS BOOLEAN) AS "has_turbo",
        CAST("levy_date" AS DATE) AS "levy_date",
        CAST("listing_url" AS VARCHAR) AS "listing_url",
        CAST("photo2_url" AS VARCHAR) AS "photo2_url",
        CAST("photo3_url" AS VARCHAR) AS "photo3_url",
        CAST("registration_expiry" AS DATE) AS "registration_expiry",
        CAST("transmission_type" AS VARCHAR) AS "transmission_type",
        TO_TIMESTAMP("updated_at", 'MM/DD/YYYY HH24:MI') AS "updated_at"
    FROM "used_car_data_new_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "used_car_data_new_renamed_cleaned_null_casted"
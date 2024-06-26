-- Slowly Changing Dimension: Dimension keys are "ITEM_ID"
-- Effective date columns are "RECORD_END_DATE"
-- We will create Type 1 SCD (latest snapshot)
SELECT 
    "UNIT_OF_MEASURE",
    "ITEM_DESCRIPTION",
    "MANUFACTURER_ID",
    "CONTAINER_TYPE",
    "SUBCATEGORY",
    "CATEGORY_NAME",
    "CATEGORY_ID",
    "MANAGER_ID",
    "SIZE_",
    "ITEM_SURROGATE_KEY",
    "CURRENT_PRICE",
    "FORMULATION_CODE",
    "COLOR",
    "ITEM_ID",
    "WHOLESALE_COST",
    "SUBCATEGORY_ID",
    "BRAND_NAME",
    "PRODUCT_NAME",
    "BRAND_ID",
    "RECORD_START_DATE"
FROM (
     SELECT 
            "UNIT_OF_MEASURE",
            "ITEM_DESCRIPTION",
            "MANUFACTURER_ID",
            "CONTAINER_TYPE",
            "SUBCATEGORY",
            "CATEGORY_NAME",
            "CATEGORY_ID",
            "MANAGER_ID",
            "SIZE_",
            "ITEM_SURROGATE_KEY",
            "CURRENT_PRICE",
            "FORMULATION_CODE",
            "COLOR",
            "ITEM_ID",
            "WHOLESALE_COST",
            "SUBCATEGORY_ID",
            "BRAND_NAME",
            "PRODUCT_NAME",
            "BRAND_ID",
            "RECORD_START_DATE",
            ROW_NUMBER() OVER (
                PARTITION BY "ITEM_ID" 
                ORDER BY "RECORD_END_DATE" 
            DESC) AS "cocoon_rn"
    FROM "stg_item"
) ranked
WHERE "cocoon_rn" = 1
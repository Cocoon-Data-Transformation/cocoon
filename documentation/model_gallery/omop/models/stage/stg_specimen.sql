-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"specimen_renamed" AS (
    -- Rename: Renaming columns
    -- specimen_date -> collection_date
    -- specimen_datetime -> collection_datetime
    -- quantity -> specimen_quantity
    -- specimen_source_value -> specimen_type
    -- unit_source_value -> quantity_unit
    -- anatomic_site_source_value -> anatomical_site
    -- disease_status_source_value -> disease_status
    SELECT 
        "specimen_id",
        "person_id",
        "specimen_date" AS "collection_date",
        "specimen_datetime" AS "collection_datetime",
        "quantity" AS "specimen_quantity",
        "specimen_source_value" AS "specimen_type",
        "unit_source_value" AS "quantity_unit",
        "anatomic_site_source_value" AS "anatomical_site",
        "disease_status_source_value" AS "disease_status"
    FROM "specimen"
),

"specimen_renamed_casted" AS (
    -- Column Type Casting: 
    -- collection_date: from VARCHAR to DATE
    -- collection_datetime: from VARCHAR to TIMESTAMP
    SELECT
        "specimen_id",
        "person_id",
        "specimen_quantity",
        "specimen_type",
        "quantity_unit",
        "anatomical_site",
        "disease_status",
        CAST("collection_date" AS DATE) AS "collection_date",
        CAST("collection_datetime" AS TIMESTAMP) AS "collection_datetime"
    FROM "specimen_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "specimen_renamed_casted"
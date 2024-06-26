-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"care_site_renamed" AS (
    -- Rename: Renaming columns
    -- care_site_name -> facility_name
    -- care_site_source_value -> source_code
    -- place_of_service_source_value -> facility_type
    SELECT 
        "care_site_id",
        "care_site_name" AS "facility_name",
        "location_id",
        "care_site_source_value" AS "source_code",
        "place_of_service_source_value" AS "facility_type"
    FROM "care_site"
)

-- COCOON BLOCK END
SELECT * FROM "care_site_renamed"
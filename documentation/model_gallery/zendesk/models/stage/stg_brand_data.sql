-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"brand_data_projected" AS (
    -- Projection: Selecting 21 out of 22 columns
    -- Columns projected out: ['_fivetran_synced']
    SELECT 
        "id",
        "_fivetran_deleted",
        "active",
        "brand_url",
        "default_",
        "has_help_center",
        "help_center_state",
        "logo_content_type",
        "logo_content_url",
        "logo_deleted",
        "logo_file_name",
        "logo_height",
        "logo_id",
        "logo_inline",
        "logo_mapped_content_url",
        "logo_size",
        "logo_url",
        "logo_width",
        "name",
        "subdomain",
        "url"
    FROM "brand_data"
),

"brand_data_projected_renamed" AS (
    -- Rename: Renaming columns
    -- id -> brand_id
    -- _fivetran_deleted -> is_deleted
    -- active -> is_active
    -- default_ -> is_default
    -- logo_deleted -> is_logo_deleted
    -- logo_inline -> is_logo_inline
    -- name -> brand_name
    -- subdomain -> brand_subdomain
    -- url -> brand_main_url
    SELECT 
        "id" AS "brand_id",
        "_fivetran_deleted" AS "is_deleted",
        "active" AS "is_active",
        "brand_url",
        "default_" AS "is_default",
        "has_help_center",
        "help_center_state",
        "logo_content_type",
        "logo_content_url",
        "logo_deleted" AS "is_logo_deleted",
        "logo_file_name",
        "logo_height",
        "logo_id",
        "logo_inline" AS "is_logo_inline",
        "logo_mapped_content_url",
        "logo_size",
        "logo_url",
        "logo_width",
        "name" AS "brand_name",
        "subdomain" AS "brand_subdomain",
        "url" AS "brand_main_url"
    FROM "brand_data_projected"
),

"brand_data_projected_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- brand_name: The problem is that the brand_name column contains a value that appears to be a hash or encoded string ('2abdc594c0ad6eb2438448b3cbf7da56') rather than a readable brand name. This value is not meaningful or interpretable as a brand name. The correct value should be an empty string, as we don't have enough information to determine the actual brand name. 
    SELECT
        "brand_id",
        "is_deleted",
        "is_active",
        "brand_url",
        "is_default",
        "has_help_center",
        "help_center_state",
        "logo_content_type",
        "logo_content_url",
        "is_logo_deleted",
        "logo_file_name",
        "logo_height",
        "logo_id",
        "is_logo_inline",
        "logo_mapped_content_url",
        "logo_size",
        "logo_url",
        "logo_width",
        CASE
            WHEN "brand_name" = '''2abdc594c0ad6eb2438448b3cbf7da56''' THEN ''''
            ELSE "brand_name"
        END AS "brand_name",
        "brand_subdomain",
        "brand_main_url"
    FROM "brand_data_projected_renamed"
)

-- COCOON BLOCK END
SELECT * FROM "brand_data_projected_renamed_cleaned"
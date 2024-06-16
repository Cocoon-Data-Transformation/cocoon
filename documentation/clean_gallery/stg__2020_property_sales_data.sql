-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"_2020_property_sales_data_renamed" AS (
    -- Rename: Renaming columns
    -- PropType -> PropertyType
    -- taxkey -> TaxKey
    -- nbhd -> NeighborhoodCode
    -- Extwall -> ExteriorWall
    -- Stories -> NumStories
    -- Year_Built -> YearBuilt
    -- Rooms -> TotalRooms
    -- FinishedSqft -> FinishedSqFt
    -- Units -> NumUnits
    -- Bdrms -> Bedrooms
    -- Fbath -> FullBathrooms
    -- Hbath -> HalfBathrooms
    -- Lotsize -> LotSizeSqFt
    -- Sale_date -> SaleDate
    -- Sale_price -> SalePrice
    SELECT 
        "PropertyID",
        "PropType" AS "PropertyType",
        "taxkey" AS "TaxKey",
        "Address",
        "CondoProject",
        "District",
        "nbhd" AS "NeighborhoodCode",
        "Style",
        "Extwall" AS "ExteriorWall",
        "Stories" AS "NumStories",
        "Year_Built" AS "YearBuilt",
        "Rooms" AS "TotalRooms",
        "FinishedSqft" AS "FinishedSqFt",
        "Units" AS "NumUnits",
        "Bdrms" AS "Bedrooms",
        "Fbath" AS "FullBathrooms",
        "Hbath" AS "HalfBathrooms",
        "Lotsize" AS "LotSizeSqFt",
        "Sale_date" AS "SaleDate",
        "Sale_price" AS "SalePrice"
    FROM "_2020_property_sales_data"
),

"_2020_property_sales_data_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "PropertyID",
        "PropertyType",
        "TaxKey",
        "District",
        "NeighborhoodCode",
        "Style",
        "ExteriorWall",
        "NumStories",
        "YearBuilt",
        "TotalRooms",
        "FinishedSqFt",
        "NumUnits",
        "Bedrooms",
        "FullBathrooms",
        "HalfBathrooms",
        "LotSizeSqFt",
        "SaleDate",
        "SalePrice",
        TRIM("Address") AS "Address",
        TRIM("CondoProject") AS "CondoProject"
    FROM "_2020_property_sales_data_renamed"
),

"_2020_property_sales_data_renamed_trimmed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- LotSizeSqFt: ['0', '1']
    SELECT 
        CASE
            WHEN "LotSizeSqFt" = '0' THEN NULL
            WHEN "LotSizeSqFt" = '1' THEN NULL
            ELSE "LotSizeSqFt"
        END AS "LotSizeSqFt",
        "PropertyID",
        "District",
        "TotalRooms",
        "FinishedSqFt",
        "TaxKey",
        "NumUnits",
        "SalePrice",
        "SaleDate",
        "NumStories",
        "ExteriorWall",
        "NeighborhoodCode",
        "CondoProject",
        "FullBathrooms",
        "Style",
        "PropertyType",
        "YearBuilt",
        "HalfBathrooms",
        "Address",
        "Bedrooms"
    FROM "_2020_property_sales_data_renamed_trimmed"
)

-- COCOON BLOCK END
SELECT * FROM "_2020_property_sales_data_renamed_trimmed_null"
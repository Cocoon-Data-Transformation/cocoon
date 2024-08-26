-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:11:16.831598+00:00
WITH 
"patients_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> patient_id
    -- BIRTHDATE -> birth_date
    -- DEATHDATE -> death_date
    -- SSN -> ssn
    -- DRIVERS -> drivers_license
    -- PASSPORT -> passport_number
    -- PREFIX -> name_prefix
    -- FIRST_ -> first_name
    -- LAST_ -> last_name
    -- SUFFIX -> name_suffix
    -- MAIDEN -> maiden_name
    -- MARITAL -> marital_status
    -- RACE -> race
    -- ETHNICITY -> ethnicity
    -- GENDER -> gender
    -- BIRTHPLACE -> birthplace
    -- ADDRESS -> street_address
    -- CITY -> city
    -- STATE -> state
    -- COUNTY -> county
    -- FIPS -> fips_code
    -- ZIP -> zip_code
    -- LAT -> latitude
    -- LON -> longitude
    -- HEALTHCARE_EXPENSES -> healthcare_expenses
    -- HEALTHCARE_COVERAGE -> healthcare_coverage
    -- INCOME -> annual_income
    SELECT 
        "Id" AS "patient_id",
        "BIRTHDATE" AS "birth_date",
        "DEATHDATE" AS "death_date",
        "SSN" AS "ssn",
        "DRIVERS" AS "drivers_license",
        "PASSPORT" AS "passport_number",
        "PREFIX" AS "name_prefix",
        "FIRST_" AS "first_name",
        "LAST_" AS "last_name",
        "SUFFIX" AS "name_suffix",
        "MAIDEN" AS "maiden_name",
        "MARITAL" AS "marital_status",
        "RACE" AS "race",
        "ETHNICITY" AS "ethnicity",
        "GENDER" AS "gender",
        "BIRTHPLACE" AS "birthplace",
        "ADDRESS" AS "street_address",
        "CITY" AS "city",
        "STATE" AS "state",
        "COUNTY" AS "county",
        "FIPS" AS "fips_code",
        "ZIP" AS "zip_code",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "HEALTHCARE_EXPENSES" AS "healthcare_expenses",
        "HEALTHCARE_COVERAGE" AS "healthcare_coverage",
        "INCOME" AS "annual_income"
    FROM "memory"."main"."patients"
),

"patients_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- ssn: The problem is that all the SSN values begin with 999, which is invalid for U.S. Social Security Numbers. Valid SSNs never start with 999. These appear to be placeholder or dummy SSNs rather than real ones. Since we can't determine the correct SSNs from this information alone, the best approach is to map these invalid values to an empty string to indicate missing data.
    -- first_name: The problem is that all first names have a random 3-digit number appended to them. These numbers appear to be meaningless and don't provide any useful information. The correct values should be just the first names without the numbers.
    -- last_name: The problem is that most last names follow a pattern of a capitalized English surname followed by 3 digits, but there are two exceptions: 1. "Bermúdez789" contains a non-English character (ú). 2. "Roldán470" contains a non-English character (á). These should be normalized to use standard English characters. The correct values should maintain the same naming pattern as the majority of entries.
    -- maiden_name: The problem is that all values in the maiden_name column are unusual because they combine surnames with three-digit numbers, which is not typical for real maiden names. This appears to be a data generation artifact rather than genuine maiden names. Since we can't determine the correct maiden names from this data, the best approach is to remove the numeric portion and keep only the surname part, which could potentially be valid maiden names.
    SELECT
        "patient_id",
        "birth_date",
        "death_date",
        CASE
            WHEN "ssn" = '999-10-1178' THEN NULL
            WHEN "ssn" = '999-10-6028' THEN NULL
            WHEN "ssn" = '999-12-9121' THEN NULL
            WHEN "ssn" = '999-14-9380' THEN NULL
            WHEN "ssn" = '999-14-9672' THEN NULL
            WHEN "ssn" = '999-16-4297' THEN NULL
            WHEN "ssn" = '999-17-2611' THEN NULL
            WHEN "ssn" = '999-20-4271' THEN NULL
            WHEN "ssn" = '999-20-5403' THEN NULL
            WHEN "ssn" = '999-22-2635' THEN NULL
            WHEN "ssn" = '999-23-4696' THEN NULL
            WHEN "ssn" = '999-23-9351' THEN NULL
            WHEN "ssn" = '999-26-4422' THEN NULL
            WHEN "ssn" = '999-26-8041' THEN NULL
            WHEN "ssn" = '999-29-2359' THEN NULL
            WHEN "ssn" = '999-29-4844' THEN NULL
            WHEN "ssn" = '999-29-7349' THEN NULL
            WHEN "ssn" = '999-30-8851' THEN NULL
            WHEN "ssn" = '999-32-4862' THEN NULL
            WHEN "ssn" = '999-33-4589' THEN NULL
            WHEN "ssn" = '999-35-8448' THEN NULL
            WHEN "ssn" = '999-36-1150' THEN NULL
            WHEN "ssn" = '999-37-8682' THEN NULL
            WHEN "ssn" = '999-38-7473' THEN NULL
            WHEN "ssn" = '999-41-1756' THEN NULL
            WHEN "ssn" = '999-42-9847' THEN NULL
            WHEN "ssn" = '999-43-4282' THEN NULL
            WHEN "ssn" = '999-44-2795' THEN NULL
            WHEN "ssn" = '999-44-9634' THEN NULL
            WHEN "ssn" = '999-48-5926' THEN NULL
            WHEN "ssn" = '999-49-9846' THEN NULL
            WHEN "ssn" = '999-50-5586' THEN NULL
            WHEN "ssn" = '999-50-5697' THEN NULL
            WHEN "ssn" = '999-51-3221' THEN NULL
            WHEN "ssn" = '999-55-3195' THEN NULL
            WHEN "ssn" = '999-55-6098' THEN NULL
            WHEN "ssn" = '999-56-9201' THEN NULL
            WHEN "ssn" = '999-57-7157' THEN NULL
            WHEN "ssn" = '999-58-7543' THEN NULL
            WHEN "ssn" = '999-59-2568' THEN NULL
            WHEN "ssn" = '999-61-4140' THEN NULL
            WHEN "ssn" = '999-61-6611' THEN NULL
            WHEN "ssn" = '999-61-6740' THEN NULL
            WHEN "ssn" = '999-62-7937' THEN NULL
            WHEN "ssn" = '999-70-2405' THEN NULL
            WHEN "ssn" = '999-70-4594' THEN NULL
            WHEN "ssn" = '999-71-8314' THEN NULL
            WHEN "ssn" = '999-73-5643' THEN NULL
            WHEN "ssn" = '999-77-7700' THEN NULL
            WHEN "ssn" = '999-79-2426' THEN NULL
            WHEN "ssn" = '999-79-3695' THEN NULL
            WHEN "ssn" = '999-85-2178' THEN NULL
            WHEN "ssn" = '999-88-1792' THEN NULL
            WHEN "ssn" = '999-89-9127' THEN NULL
            WHEN "ssn" = '999-91-9580' THEN NULL
            WHEN "ssn" = '999-93-7263' THEN NULL
            WHEN "ssn" = '999-95-3792' THEN NULL
            WHEN "ssn" = '999-96-6743' THEN NULL
            WHEN "ssn" = '999-99-2106' THEN NULL
            WHEN "ssn" = '999-99-2436' THEN NULL
            ELSE "ssn"
        END AS "ssn",
        "drivers_license",
        "passport_number",
        "name_prefix",
        CASE
            WHEN "first_name" = 'Hayden835' THEN 'Hayden'
            WHEN "first_name" = 'Adelia946' THEN 'Adelia'
            WHEN "first_name" = 'Andera917' THEN 'Andera'
            WHEN "first_name" = 'Antony83' THEN 'Antony'
            WHEN "first_name" = 'Burton124' THEN 'Burton'
            WHEN "first_name" = 'Carmelita854' THEN 'Carmelita'
            WHEN "first_name" = 'Carrol931' THEN 'Carrol'
            WHEN "first_name" = 'Cedrick207' THEN 'Cedrick'
            WHEN "first_name" = 'Cheyenne169' THEN 'Cheyenne'
            WHEN "first_name" = 'Christal240' THEN 'Christal'
            WHEN "first_name" = 'Cindy893' THEN 'Cindy'
            WHEN "first_name" = 'Coleman27' THEN 'Coleman'
            WHEN "first_name" = 'Corey514' THEN 'Corey'
            WHEN "first_name" = 'Damon455' THEN 'Damon'
            WHEN "first_name" = 'Daniela614' THEN 'Daniela'
            WHEN "first_name" = 'Dione665' THEN 'Dione'
            WHEN "first_name" = 'Dominick530' THEN 'Dominick'
            WHEN "first_name" = 'Elden718' THEN 'Elden'
            WHEN "first_name" = 'Ethel888' THEN 'Ethel'
            WHEN "first_name" = 'Fletcher87' THEN 'Fletcher'
            WHEN "first_name" = 'Garry927' THEN 'Garry'
            WHEN "first_name" = 'Gayle448' THEN 'Gayle'
            WHEN "first_name" = 'Grant908' THEN 'Grant'
            WHEN "first_name" = 'Guadalupe206' THEN 'Guadalupe'
            WHEN "first_name" = 'Herb645' THEN 'Herb'
            WHEN "first_name" = 'Herschel574' THEN 'Herschel'
            WHEN "first_name" = 'Hildred696' THEN 'Hildred'
            WHEN "first_name" = 'Huey641' THEN 'Huey'
            WHEN "first_name" = 'Hunter736' THEN 'Hunter'
            WHEN "first_name" = 'Irving123' THEN 'Irving'
            WHEN "first_name" = 'Janeth814' THEN 'Janeth'
            WHEN "first_name" = 'Jenae263' THEN 'Jenae'
            WHEN "first_name" = 'Jimmie93' THEN 'Jimmie'
            WHEN "first_name" = 'Kaycee352' THEN 'Kaycee'
            WHEN "first_name" = 'Kirk871' THEN 'Kirk'
            WHEN "first_name" = 'Lacey714' THEN 'Lacey'
            WHEN "first_name" = 'Lavette209' THEN 'Lavette'
            WHEN "first_name" = 'Leandro563' THEN 'Leandro'
            WHEN "first_name" = 'Lessie363' THEN 'Lessie'
            WHEN "first_name" = 'Lillia547' THEN 'Lillia'
            WHEN "first_name" = 'Linn541' THEN 'Linn'
            WHEN "first_name" = 'Lonny638' THEN 'Lonny'
            WHEN "first_name" = 'Luke971' THEN 'Luke'
            WHEN "first_name" = 'Manuel446' THEN 'Manuel'
            WHEN "first_name" = 'Martín25' THEN 'Martín'
            WHEN "first_name" = 'Mel236' THEN 'Mel'
            WHEN "first_name" = 'Mirta419' THEN 'Mirta'
            WHEN "first_name" = 'Moises22' THEN 'Moises'
            WHEN "first_name" = 'Raymon366' THEN 'Raymon'
            WHEN "first_name" = 'Shaquana156' THEN 'Shaquana'
            WHEN "first_name" = 'Shayla126' THEN 'Shayla'
            WHEN "first_name" = 'Shiela18' THEN 'Shiela'
            WHEN "first_name" = 'Steve819' THEN 'Steve'
            WHEN "first_name" = 'Stewart672' THEN 'Stewart'
            WHEN "first_name" = 'Tyrell880' THEN 'Tyrell'
            WHEN "first_name" = 'Vanesa40' THEN 'Vanesa'
            WHEN "first_name" = 'Whitney250' THEN 'Whitney'
            WHEN "first_name" = 'Yetta429' THEN 'Yetta'
            WHEN "first_name" = 'Zoila41' THEN 'Zoila'
            ELSE "first_name"
        END AS "first_name",
        CASE
            WHEN "last_name" = 'Bermúdez789' THEN 'Bermudez789'
            WHEN "last_name" = 'Roldán470' THEN 'Roldan470'
            WHEN "last_name" = 'Wilkinson796' THEN 'Wilkinson'
            WHEN "last_name" = 'Willms744' THEN 'Willms'
            WHEN "last_name" = 'Zboncak558' THEN 'Zboncak'
            ELSE "last_name"
        END AS "last_name",
        "name_suffix",
        CASE
            WHEN "maiden_name" = 'Barela183' THEN 'Barela'
            WHEN "maiden_name" = 'Beier427' THEN 'Beier'
            WHEN "maiden_name" = 'Deckow585' THEN 'Deckow'
            WHEN "maiden_name" = 'DuBuque211' THEN 'DuBuque'
            WHEN "maiden_name" = 'Gorczany269' THEN 'Gorczany'
            WHEN "maiden_name" = 'Hegmann834' THEN 'Hegmann'
            WHEN "maiden_name" = 'Hermann103' THEN 'Hermann'
            WHEN "maiden_name" = 'Kohler843' THEN 'Kohler'
            WHEN "maiden_name" = 'Lowe577' THEN 'Lowe'
            WHEN "maiden_name" = 'Predovic534' THEN 'Predovic'
            WHEN "maiden_name" = 'Shanahan202' THEN 'Shanahan'
            ELSE "maiden_name"
        END AS "maiden_name",
        "marital_status",
        "race",
        "ethnicity",
        "gender",
        "birthplace",
        "street_address",
        "city",
        "state",
        "county",
        "fips_code",
        "zip_code",
        "latitude",
        "longitude",
        "healthcare_expenses",
        "healthcare_coverage",
        "annual_income"
    FROM "patients_renamed"
),

"patients_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- birth_date: from VARCHAR to DATE
    -- death_date: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- zip_code: from INT to VARCHAR
    SELECT
        "ssn",
        "drivers_license",
        "passport_number",
        "name_prefix",
        "first_name",
        "last_name",
        "name_suffix",
        "maiden_name",
        "marital_status",
        "race",
        "ethnicity",
        "gender",
        "birthplace",
        "street_address",
        "city",
        "state",
        "county",
        "fips_code",
        "latitude",
        "longitude",
        "healthcare_expenses",
        "healthcare_coverage",
        "annual_income",
        CAST("birth_date" AS DATE) 
        AS "birth_date",
        CAST("death_date" AS DATE) 
        AS "death_date",
        CAST("patient_id" AS UUID) 
        AS "patient_id",
        CAST("zip_code" AS VARCHAR) 
        AS "zip_code"
    FROM "patients_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "patients_renamed_cleaned_casted"
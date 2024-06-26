-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"patients_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> patient_id
    -- BIRTHDATE -> date_of_birth
    -- DEATHDATE -> date_of_death
    -- SSN -> social_security_number
    -- DRIVERS -> drivers_license_number
    -- PASSPORT -> passport_number
    -- PREFIX -> name_prefix
    -- FIRST_ -> first_name
    -- LAST_ -> last_name
    -- SUFFIX -> name_suffix
    -- MAIDEN -> maiden_name
    -- MARITAL -> marital_status
    -- BIRTHPLACE -> place_of_birth
    -- ADDRESS -> street_address
    -- CITY -> current_city
    -- STATE -> current_state
    -- COUNTY -> current_county
    -- FIPS -> fips_code
    -- ZIP -> zip_code
    -- LAT -> latitude
    -- LON -> longitude
    -- HEALTHCARE_EXPENSES -> healthcare_expenses_amount
    -- HEALTHCARE_COVERAGE -> healthcare_coverage_amount
    -- INCOME -> annual_income
    SELECT 
        "Id" AS "patient_id",
        "BIRTHDATE" AS "date_of_birth",
        "DEATHDATE" AS "date_of_death",
        "SSN" AS "social_security_number",
        "DRIVERS" AS "drivers_license_number",
        "PASSPORT" AS "passport_number",
        "PREFIX" AS "name_prefix",
        "FIRST_" AS "first_name",
        "LAST_" AS "last_name",
        "SUFFIX" AS "name_suffix",
        "MAIDEN" AS "maiden_name",
        "MARITAL" AS "marital_status",
        "RACE",
        "ETHNICITY",
        "GENDER",
        "BIRTHPLACE" AS "place_of_birth",
        "ADDRESS" AS "street_address",
        "CITY" AS "current_city",
        "STATE" AS "current_state",
        "COUNTY" AS "current_county",
        "FIPS" AS "fips_code",
        "ZIP" AS "zip_code",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "HEALTHCARE_EXPENSES" AS "healthcare_expenses_amount",
        "HEALTHCARE_COVERAGE" AS "healthcare_coverage_amount",
        "INCOME" AS "annual_income"
    FROM "patients"
),

"patients_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- social_security_number: Fail to run
    -- first_name: The problem is that all values in the first_name column are unusual because they combine names with numbers, which is not typical for first names. The correct values should be just the name portion without the numbers. 
    -- last_name: The problem is that the last names contain numbers, which is unusual for real names. Additionally, there are two names with non-ASCII characters (Bermúdez789 and Roldán470), which may cause issues in some systems. The correct values should be the last names without the numbers and with proper capitalization. For the non-ASCII names, we'll keep the accented characters but remove the numbers. 
    -- maiden_name: The problem is that all values in the maiden_name column are unusual because they combine surnames with three-digit numbers, which is not typical for maiden names. Maiden names are typically just surnames without any numbers. The correct values should be just the surname portion without the appended numbers. 
    SELECT
        "patient_id",
        "date_of_birth",
        "date_of_death",
        CASE
            WHEN "social_security_number" = '999-79-3695' THEN ''
            WHEN "social_security_number" = '999-85-2178' THEN ''
            WHEN "social_security_number" = '999-88-1792' THEN ''
            WHEN "social_security_number" = '999-89-9127' THEN ''
            WHEN "social_security_number" = '999-91-9580' THEN ''
            WHEN "social_security_number" = '999-93-7263' THEN ''
            WHEN "social_security_number" = '999-95-3792' THEN ''
            WHEN "social_security_number" = '999-96-6743' THEN ''
            WHEN "social_security_number" = '999-99-2106' THEN ''
            WHEN "social_security_number" = '999-99-2436' THEN ''
            ELSE "social_security_number"
        END AS "social_security_number",
        "drivers_license_number",
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
            WHEN "last_name" = 'Casper496' THEN 'Casper'
            WHEN "last_name" = 'Hamill307' THEN 'Hamill'
            WHEN "last_name" = 'MacGyver246' THEN 'MacGyver'
            WHEN "last_name" = 'Nolan344' THEN 'Nolan'
            WHEN "last_name" = 'O''Conner199' THEN 'O''Conner'
            WHEN "last_name" = 'Schimmel440' THEN 'Schimmel'
            WHEN "last_name" = 'Schumm995' THEN 'Schumm'
            WHEN "last_name" = 'Anderson154' THEN 'Anderson'
            WHEN "last_name" = 'Armstrong51' THEN 'Armstrong'
            WHEN "last_name" = 'Bailey598' THEN 'Bailey'
            WHEN "last_name" = 'Becker968' THEN 'Becker'
            WHEN "last_name" = 'Bermúdez789' THEN 'Bermúdez'
            WHEN "last_name" = 'Brakus656' THEN 'Brakus'
            WHEN "last_name" = 'Collier206' THEN 'Collier'
            WHEN "last_name" = 'Collins926' THEN 'Collins'
            WHEN "last_name" = 'Corwin846' THEN 'Corwin'
            WHEN "last_name" = 'Cruickshank494' THEN 'Cruickshank'
            WHEN "last_name" = 'Doyle959' THEN 'Doyle'
            WHEN "last_name" = 'Ernser583' THEN 'Ernser'
            WHEN "last_name" = 'Feest103' THEN 'Feest'
            WHEN "last_name" = 'Gislason620' THEN 'Gislason'
            WHEN "last_name" = 'Graham902' THEN 'Graham'
            WHEN "last_name" = 'Hagenes547' THEN 'Hagenes'
            WHEN "last_name" = 'Hahn503' THEN 'Hahn'
            WHEN "last_name" = 'Hane680' THEN 'Hane'
            WHEN "last_name" = 'Hayes766' THEN 'Hayes'
            WHEN "last_name" = 'Heathcote539' THEN 'Heathcote'
            WHEN "last_name" = 'Hoppe518' THEN 'Hoppe'
            WHEN "last_name" = 'Jenkins714' THEN 'Jenkins'
            WHEN "last_name" = 'Johnson679' THEN 'Johnson'
            WHEN "last_name" = 'Keebler762' THEN 'Keebler'
            WHEN "last_name" = 'Klein929' THEN 'Klein'
            WHEN "last_name" = 'Koss676' THEN 'Koss'
            WHEN "last_name" = 'Kreiger457' THEN 'Kreiger'
            WHEN "last_name" = 'Kshlerin58' THEN 'Kshlerin'
            WHEN "last_name" = 'Langworth352' THEN 'Langworth'
            WHEN "last_name" = 'Lemke654' THEN 'Lemke'
            WHEN "last_name" = 'Lueilwitz711' THEN 'Lueilwitz'
            WHEN "last_name" = 'Marks830' THEN 'Marks'
            WHEN "last_name" = 'McGlynn426' THEN 'McGlynn'
            WHEN "last_name" = 'Mills423' THEN 'Mills'
            WHEN "last_name" = 'Nikolaus26' THEN 'Nikolaus'
            WHEN "last_name" = 'Orn563' THEN 'Orn'
            WHEN "last_name" = 'Quitzon246' THEN 'Quitzon'
            WHEN "last_name" = 'Rath779' THEN 'Rath'
            WHEN "last_name" = 'Rico947' THEN 'Rico'
            WHEN "last_name" = 'Roldán470' THEN 'Roldán'
            WHEN "last_name" = 'Rutherford999' THEN 'Rutherford'
            WHEN "last_name" = 'Stehr398' THEN 'Stehr'
            WHEN "last_name" = 'Trantow673' THEN 'Trantow'
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
        "RACE",
        "ETHNICITY",
        "GENDER",
        "place_of_birth",
        "street_address",
        "current_city",
        "current_state",
        "current_county",
        "fips_code",
        "zip_code",
        "latitude",
        "longitude",
        "healthcare_expenses_amount",
        "healthcare_coverage_amount",
        "annual_income"
    FROM "patients_renamed"
),

"patients_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- social_security_number: ['']
    SELECT 
        CASE
            WHEN "social_security_number" = '' THEN NULL
            ELSE "social_security_number"
        END AS "social_security_number",
        "current_state",
        "name_suffix",
        "patient_id",
        "latitude",
        "longitude",
        "healthcare_coverage_amount",
        "place_of_birth",
        "date_of_death",
        "fips_code",
        "marital_status",
        "name_prefix",
        "current_county",
        "last_name",
        "annual_income",
        "RACE",
        "ETHNICITY",
        "first_name",
        "passport_number",
        "current_city",
        "zip_code",
        "healthcare_expenses_amount",
        "street_address",
        "date_of_birth",
        "maiden_name",
        "drivers_license_number",
        "GENDER"
    FROM "patients_renamed_cleaned"
),

"patients_renamed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- date_of_birth: from VARCHAR to DATE
    -- date_of_death: from VARCHAR to DATE
    -- patient_id: from VARCHAR to UUID
    -- zip_code: from INT to VARCHAR
    SELECT
        "social_security_number",
        "current_state",
        "name_suffix",
        "latitude",
        "longitude",
        "healthcare_coverage_amount",
        "place_of_birth",
        "fips_code",
        "marital_status",
        "name_prefix",
        "current_county",
        "last_name",
        "annual_income",
        "RACE",
        "ETHNICITY",
        "first_name",
        "passport_number",
        "current_city",
        "healthcare_expenses_amount",
        "street_address",
        "maiden_name",
        "drivers_license_number",
        "GENDER",
        CAST("date_of_birth" AS DATE) AS "date_of_birth",
        CAST("date_of_death" AS DATE) AS "date_of_death",
        CAST("patient_id" AS UUID) AS "patient_id",
        CAST("zip_code" AS VARCHAR) AS "zip_code"
    FROM "patients_renamed_cleaned_null"
)

-- COCOON BLOCK END
SELECT * FROM "patients_renamed_cleaned_null_casted"
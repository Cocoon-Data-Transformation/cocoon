-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-01 16:30:58.336954+00:00
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
    -- first_name: The problem is that all values in the first_name column are unusual because they combine standard first names with three-digit numbers (e.g., 'Hayden835', 'Adelia946'). This is likely not the intended format for first names. The correct values should be the standard first names without the appended numbers.
    -- last_name: The problem is that some last names contain numeric suffixes, which is unusual for real names. Additionally, there are two names with non-ASCII characters: 'Bermúdez789' and 'Roldán470'. The correct values should be the names without the numeric suffixes and with ASCII-only characters.
    -- maiden_name: The problem is that all values in the maiden_name column are unusual because they combine surnames with three-digit numbers, which is not typical for maiden names. The correct values should be just the surnames without the numbers.
    SELECT
        "patient_id",
        "birth_date",
        "death_date",
        "ssn",
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
            WHEN "last_name" = 'Bermúdez789' THEN 'Bermudez'
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
            WHEN "last_name" = 'Roldán470' THEN 'Roldan'
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
-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"patients_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> PATIENT_ID
    -- DRIVERS -> DRIVERS_LICENSE
    -- PASSPORT -> PASSPORT_NUMBER
    -- PREFIX -> NAME_PREFIX
    -- FIRST_ -> FIRST_NAME
    -- LAST_ -> LAST_NAME
    -- SUFFIX -> NAME_SUFFIX
    -- MAIDEN -> MAIDEN_NAME
    -- MARITAL -> MARITAL_STATUS
    -- FIPS -> FIPS_CODE
    -- ZIP -> ZIP_CODE
    -- LAT -> LATITUDE
    -- LON -> LONGITUDE
    SELECT 
        "Id" AS "PATIENT_ID",
        "BIRTHDATE",
        "DEATHDATE",
        "SSN",
        "DRIVERS" AS "DRIVERS_LICENSE",
        "PASSPORT" AS "PASSPORT_NUMBER",
        "PREFIX" AS "NAME_PREFIX",
        "FIRST_" AS "FIRST_NAME",
        "LAST_" AS "LAST_NAME",
        "SUFFIX" AS "NAME_SUFFIX",
        "MAIDEN" AS "MAIDEN_NAME",
        "MARITAL" AS "MARITAL_STATUS",
        "RACE",
        "ETHNICITY",
        "GENDER",
        "BIRTHPLACE",
        "ADDRESS",
        "CITY",
        "STATE",
        "COUNTY",
        "FIPS" AS "FIPS_CODE",
        "ZIP" AS "ZIP_CODE",
        "LAT" AS "LATITUDE",
        "LON" AS "LONGITUDE",
        "HEALTHCARE_EXPENSES",
        "HEALTHCARE_COVERAGE",
        "INCOME"
    FROM "patients"
),

"patients_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- FIRST_NAME: The problem is that the first names are combined with numbers, which is an unusual format. The numbers should be removed to have only the first names. 
    -- LAST_NAME: The problem is that last names should not typically include numbers. The correct values should have the numbers removed. 
    -- MAIDEN_NAME: The problem is that the last names in the MAIDEN_NAME column contain appended numbers, which is unusual. The correct values should not have any numbers appended to the last names. 
    SELECT
        "PATIENT_ID",
        "BIRTHDATE",
        "DEATHDATE",
        "SSN",
        "DRIVERS_LICENSE",
        "PASSPORT_NUMBER",
        "NAME_PREFIX",
        CASE
            WHEN "FIRST_NAME" = 'Hayden835' THEN 'Hayden'
            WHEN "FIRST_NAME" = 'Adelia946' THEN 'Adelia'
            WHEN "FIRST_NAME" = 'Andera917' THEN 'Andera'
            WHEN "FIRST_NAME" = 'Antony83' THEN 'Antony'
            WHEN "FIRST_NAME" = 'Burton124' THEN 'Burton'
            WHEN "FIRST_NAME" = 'Carmelita854' THEN 'Carmelita'
            WHEN "FIRST_NAME" = 'Carrol931' THEN 'Carrol'
            WHEN "FIRST_NAME" = 'Cedrick207' THEN 'Cedrick'
            WHEN "FIRST_NAME" = 'Cheyenne169' THEN 'Cheyenne'
            WHEN "FIRST_NAME" = 'Christal240' THEN 'Christal'
            WHEN "FIRST_NAME" = 'Cindy893' THEN 'Cindy'
            WHEN "FIRST_NAME" = 'Coleman27' THEN 'Coleman'
            WHEN "FIRST_NAME" = 'Corey514' THEN 'Corey'
            WHEN "FIRST_NAME" = 'Damon455' THEN 'Damon'
            WHEN "FIRST_NAME" = 'Daniela614' THEN 'Daniela'
            WHEN "FIRST_NAME" = 'Dione665' THEN 'Dione'
            WHEN "FIRST_NAME" = 'Dominick530' THEN 'Dominick'
            WHEN "FIRST_NAME" = 'Elden718' THEN 'Elden'
            WHEN "FIRST_NAME" = 'Ethel888' THEN 'Ethel'
            WHEN "FIRST_NAME" = 'Fletcher87' THEN 'Fletcher'
            WHEN "FIRST_NAME" = 'Garry927' THEN 'Garry'
            WHEN "FIRST_NAME" = 'Gayle448' THEN 'Gayle'
            WHEN "FIRST_NAME" = 'Grant908' THEN 'Grant'
            WHEN "FIRST_NAME" = 'Guadalupe206' THEN 'Guadalupe'
            WHEN "FIRST_NAME" = 'Herb645' THEN 'Herb'
            WHEN "FIRST_NAME" = 'Herschel574' THEN 'Herschel'
            WHEN "FIRST_NAME" = 'Hildred696' THEN 'Hildred'
            WHEN "FIRST_NAME" = 'Huey641' THEN 'Huey'
            WHEN "FIRST_NAME" = 'Hunter736' THEN 'Hunter'
            WHEN "FIRST_NAME" = 'Irving123' THEN 'Irving'
            WHEN "FIRST_NAME" = 'Janeth814' THEN 'Janeth'
            WHEN "FIRST_NAME" = 'Jenae263' THEN 'Jenae'
            WHEN "FIRST_NAME" = 'Jimmie93' THEN 'Jimmie'
            WHEN "FIRST_NAME" = 'Kaycee352' THEN 'Kaycee'
            WHEN "FIRST_NAME" = 'Kirk871' THEN 'Kirk'
            WHEN "FIRST_NAME" = 'Lacey714' THEN 'Lacey'
            WHEN "FIRST_NAME" = 'Lavette209' THEN 'Lavette'
            WHEN "FIRST_NAME" = 'Leandro563' THEN 'Leandro'
            WHEN "FIRST_NAME" = 'Lessie363' THEN 'Lessie'
            WHEN "FIRST_NAME" = 'Lillia547' THEN 'Lillia'
            WHEN "FIRST_NAME" = 'Linn541' THEN 'Linn'
            WHEN "FIRST_NAME" = 'Lonny638' THEN 'Lonny'
            WHEN "FIRST_NAME" = 'Luke971' THEN 'Luke'
            WHEN "FIRST_NAME" = 'Manuel446' THEN 'Manuel'
            WHEN "FIRST_NAME" = 'Martín25' THEN 'Martín'
            WHEN "FIRST_NAME" = 'Mel236' THEN 'Mel'
            WHEN "FIRST_NAME" = 'Mirta419' THEN 'Mirta'
            WHEN "FIRST_NAME" = 'Moises22' THEN 'Moises'
            WHEN "FIRST_NAME" = 'Raymon366' THEN 'Raymon'
            WHEN "FIRST_NAME" = 'Shaquana156' THEN 'Shaquana'
            WHEN "FIRST_NAME" = 'Shayla126' THEN 'Shayla'
            WHEN "FIRST_NAME" = 'Shiela18' THEN 'Shiela'
            WHEN "FIRST_NAME" = 'Steve819' THEN 'Steve'
            WHEN "FIRST_NAME" = 'Stewart672' THEN 'Stewart'
            WHEN "FIRST_NAME" = 'Tyrell880' THEN 'Tyrell'
            WHEN "FIRST_NAME" = 'Vanesa40' THEN 'Vanesa'
            WHEN "FIRST_NAME" = 'Whitney250' THEN 'Whitney'
            WHEN "FIRST_NAME" = 'Yetta429' THEN 'Yetta'
            WHEN "FIRST_NAME" = 'Zoila41' THEN 'Zoila'
            ELSE "FIRST_NAME"
        END AS "FIRST_NAME",
        CASE
            WHEN "LAST_NAME" = 'Casper496' THEN 'Casper'
            WHEN "LAST_NAME" = 'Hamill307' THEN 'Hamill'
            WHEN "LAST_NAME" = 'MacGyver246' THEN 'MacGyver'
            WHEN "LAST_NAME" = 'Nolan344' THEN 'Nolan'
            WHEN "LAST_NAME" = 'O''Conner199' THEN 'O''Conner'
            WHEN "LAST_NAME" = 'Schimmel440' THEN 'Schimmel'
            WHEN "LAST_NAME" = 'Schumm995' THEN 'Schumm'
            WHEN "LAST_NAME" = 'Anderson154' THEN 'Anderson'
            WHEN "LAST_NAME" = 'Armstrong51' THEN 'Armstrong'
            WHEN "LAST_NAME" = 'Bailey598' THEN 'Bailey'
            WHEN "LAST_NAME" = 'Becker968' THEN 'Becker'
            WHEN "LAST_NAME" = 'Bermúdez789' THEN 'Bermúdez'
            WHEN "LAST_NAME" = 'Brakus656' THEN 'Brakus'
            WHEN "LAST_NAME" = 'Collier206' THEN 'Collier'
            WHEN "LAST_NAME" = 'Collins926' THEN 'Collins'
            WHEN "LAST_NAME" = 'Corwin846' THEN 'Corwin'
            WHEN "LAST_NAME" = 'Cruickshank494' THEN 'Cruickshank'
            WHEN "LAST_NAME" = 'Doyle959' THEN 'Doyle'
            WHEN "LAST_NAME" = 'Ernser583' THEN 'Ernser'
            WHEN "LAST_NAME" = 'Feest103' THEN 'Feest'
            WHEN "LAST_NAME" = 'Gislason620' THEN 'Gislason'
            WHEN "LAST_NAME" = 'Graham902' THEN 'Graham'
            WHEN "LAST_NAME" = 'Hagenes547' THEN 'Hagenes'
            WHEN "LAST_NAME" = 'Hahn503' THEN 'Hahn'
            WHEN "LAST_NAME" = 'Hane680' THEN 'Hane'
            WHEN "LAST_NAME" = 'Hayes766' THEN 'Hayes'
            WHEN "LAST_NAME" = 'Heathcote539' THEN 'Heathcote'
            WHEN "LAST_NAME" = 'Hoppe518' THEN 'Hoppe'
            WHEN "LAST_NAME" = 'Jenkins714' THEN 'Jenkins'
            WHEN "LAST_NAME" = 'Johnson679' THEN 'Johnson'
            WHEN "LAST_NAME" = 'Keebler762' THEN 'Keebler'
            WHEN "LAST_NAME" = 'Klein929' THEN 'Klein'
            WHEN "LAST_NAME" = 'Koss676' THEN 'Koss'
            WHEN "LAST_NAME" = 'Kreiger457' THEN 'Kreiger'
            WHEN "LAST_NAME" = 'Kshlerin58' THEN 'Kshlerin'
            WHEN "LAST_NAME" = 'Langworth352' THEN 'Langworth'
            WHEN "LAST_NAME" = 'Lemke654' THEN 'Lemke'
            WHEN "LAST_NAME" = 'Lueilwitz711' THEN 'Lueilwitz'
            WHEN "LAST_NAME" = 'Marks830' THEN 'Marks'
            WHEN "LAST_NAME" = 'McGlynn426' THEN 'McGlynn'
            WHEN "LAST_NAME" = 'Mills423' THEN 'Mills'
            WHEN "LAST_NAME" = 'Nikolaus26' THEN 'Nikolaus'
            WHEN "LAST_NAME" = 'Orn563' THEN 'Orn'
            WHEN "LAST_NAME" = 'Quitzon246' THEN 'Quitzon'
            WHEN "LAST_NAME" = 'Rath779' THEN 'Rath'
            WHEN "LAST_NAME" = 'Rico947' THEN 'Rico'
            WHEN "LAST_NAME" = 'Roldán470' THEN 'Roldán'
            WHEN "LAST_NAME" = 'Rutherford999' THEN 'Rutherford'
            WHEN "LAST_NAME" = 'Stehr398' THEN 'Stehr'
            WHEN "LAST_NAME" = 'Trantow673' THEN 'Trantow'
            WHEN "LAST_NAME" = 'Wilkinson796' THEN 'Wilkinson'
            WHEN "LAST_NAME" = 'Willms744' THEN 'Willms'
            WHEN "LAST_NAME" = 'Zboncak558' THEN 'Zboncak'
            ELSE "LAST_NAME"
        END AS "LAST_NAME",
        "NAME_SUFFIX",
        CASE
            WHEN "MAIDEN_NAME" = 'Barela183' THEN 'Barela'
            WHEN "MAIDEN_NAME" = 'Beier427' THEN 'Beier'
            WHEN "MAIDEN_NAME" = 'Deckow585' THEN 'Deckow'
            WHEN "MAIDEN_NAME" = 'DuBuque211' THEN 'DuBuque'
            WHEN "MAIDEN_NAME" = 'Gorczany269' THEN 'Gorczany'
            WHEN "MAIDEN_NAME" = 'Hegmann834' THEN 'Hegmann'
            WHEN "MAIDEN_NAME" = 'Hermann103' THEN 'Hermann'
            WHEN "MAIDEN_NAME" = 'Kohler843' THEN 'Kohler'
            WHEN "MAIDEN_NAME" = 'Lowe577' THEN 'Lowe'
            WHEN "MAIDEN_NAME" = 'Predovic534' THEN 'Predovic'
            WHEN "MAIDEN_NAME" = 'Shanahan202' THEN 'Shanahan'
            ELSE "MAIDEN_NAME"
        END AS "MAIDEN_NAME",
        "MARITAL_STATUS",
        "RACE",
        "ETHNICITY",
        "GENDER",
        "BIRTHPLACE",
        "ADDRESS",
        "CITY",
        "STATE",
        "COUNTY",
        "FIPS_CODE",
        "ZIP_CODE",
        "LATITUDE",
        "LONGITUDE",
        "HEALTHCARE_EXPENSES",
        "HEALTHCARE_COVERAGE",
        "INCOME"
    FROM "patients_renamed"
),

"patients_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- BIRTHDATE: from VARCHAR to DATE
    -- DEATHDATE: from VARCHAR to DATE
    -- ZIP_CODE: from INT to VARCHAR
    SELECT
        "PATIENT_ID",
        "SSN",
        "DRIVERS_LICENSE",
        "PASSPORT_NUMBER",
        "NAME_PREFIX",
        "FIRST_NAME",
        "LAST_NAME",
        "NAME_SUFFIX",
        "MAIDEN_NAME",
        "MARITAL_STATUS",
        "RACE",
        "ETHNICITY",
        "GENDER",
        "BIRTHPLACE",
        "ADDRESS",
        "CITY",
        "STATE",
        "COUNTY",
        "FIPS_CODE",
        "LATITUDE",
        "LONGITUDE",
        "HEALTHCARE_EXPENSES",
        "HEALTHCARE_COVERAGE",
        "INCOME",
        CAST("BIRTHDATE" AS DATE) AS "BIRTHDATE",
        CAST("DEATHDATE" AS DATE) AS "DEATHDATE",
        CAST("ZIP_CODE" AS VARCHAR) AS "ZIP_CODE"
    FROM "patients_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT * FROM "patients_renamed_cleaned_casted"
-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:16:20.447136+00:00
WITH 
"providers_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> provider_id
    -- ORGANIZATION -> organization_id
    -- NAME -> provider_name
    -- ADDRESS -> street_address
    -- LAT -> latitude
    -- LON -> longitude
    -- ENCOUNTERS -> patient_encounters
    -- PROCEDURES -> procedures_performed
    SELECT 
        "Id" AS "provider_id",
        "ORGANIZATION" AS "organization_id",
        "NAME" AS "provider_name",
        "GENDER",
        "SPECIALITY",
        "ADDRESS" AS "street_address",
        "CITY",
        "STATE",
        "ZIP",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "ENCOUNTERS" AS "patient_encounters",
        "PROCEDURES" AS "procedures_performed"
    FROM "memory"."main"."providers"
),

"providers_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- provider_name: The problem is that all the provider names in this column contain numbers, which is highly unusual for real names. The names appear to be a combination of a first name followed by numbers, then a last name followed by more numbers. This pattern is consistent across all entries and doesn't represent typical naming conventions. The correct values should be the names without the numbers.
    SELECT
        "provider_id",
        "organization_id",
        CASE
            WHEN "provider_name" = 'Afton574 Kulas532' THEN 'Afton Kulas'
            WHEN "provider_name" = 'Agustín529 Gaona896' THEN 'Agustín Gaona'
            WHEN "provider_name" = 'Alan320 Keeling57' THEN 'Alan Keeling'
            WHEN "provider_name" = 'Alvin56 Hayes766' THEN 'Alvin Hayes'
            WHEN "provider_name" = 'Ammie189 Kuvalis369' THEN 'Ammie Kuvalis'
            WHEN "provider_name" = 'Anderson154 Lemke654' THEN 'Anderson Lemke'
            WHEN "provider_name" = 'Angelic427 McCullough561' THEN 'Angelic McCullough'
            WHEN "provider_name" = 'Annita733 Frami345' THEN 'Annita Frami'
            WHEN "provider_name" = 'Antwan357 Lindgren255' THEN 'Antwan Lindgren'
            WHEN "provider_name" = 'Ariane992 Pagac496' THEN 'Ariane Pagac'
            WHEN "provider_name" = 'Arla414 Fritsch593' THEN 'Arla Fritsch'
            WHEN "provider_name" = 'Barrett790 Wolf938' THEN 'Barrett Wolf'
            WHEN "provider_name" = 'Bernardo699 Nieves278' THEN 'Bernardo Nieves'
            WHEN "provider_name" = 'Bradly656 Lang846' THEN 'Bradly Lang'
            WHEN "provider_name" = 'Brigitte394 Bartoletti50' THEN 'Brigitte Bartoletti'
            WHEN "provider_name" = 'Brock407 Bergstrom287' THEN 'Brock Bergstrom'
            WHEN "provider_name" = 'Carisa395 Kutch271' THEN 'Carisa Kutch'
            WHEN "provider_name" = 'Carlos172 Wiza601' THEN 'Carlos Wiza'
            WHEN "provider_name" = 'Carri827 Flatley871' THEN 'Carri Flatley'
            WHEN "provider_name" = 'Chantell995 Krajcik437' THEN 'Chantell Krajcik'
            WHEN "provider_name" = 'Charlena802 Lockman863' THEN 'Charlena Lockman'
            WHEN "provider_name" = 'Cherrie404 Conn188' THEN 'Cherrie Conn'
            WHEN "provider_name" = 'Chong355 Balistreri607' THEN 'Chong Balistreri'
            WHEN "provider_name" = 'Clemente531 Schamberger479' THEN 'Clemente Schamberger'
            WHEN "provider_name" = 'Clemente531 Treutel973' THEN 'Clemente Treutel'
            WHEN "provider_name" = 'Cristi782 Miller503' THEN 'Cristi Miller'
            WHEN "provider_name" = 'Cristy798 Auer97' THEN 'Cristy Auer'
            WHEN "provider_name" = 'Dana512 Wilkinson796' THEN 'Dana Wilkinson'
            WHEN "provider_name" = 'Danial835 Lehner980' THEN 'Danial Lehner'
            WHEN "provider_name" = 'Danita413 Becker968' THEN 'Danita Becker'
            WHEN "provider_name" = 'Dannie881 Howell947' THEN 'Dannie Howell'
            WHEN "provider_name" = 'Danuta945 Little434' THEN 'Danuta Little'
            WHEN "provider_name" = 'Dean966 Kris249' THEN 'Dean Kris'
            WHEN "provider_name" = 'Delicia67 Bernhard322' THEN 'Delicia Bernhard'
            WHEN "provider_name" = 'Dorcas534 Quigley282' THEN 'Dorcas Quigley'
            WHEN "provider_name" = 'Drew592 Ankunding277' THEN 'Drew Ankunding'
            WHEN "provider_name" = 'Eduardo902 Méndez913' THEN 'Eduardo Méndez'
            WHEN "provider_name" = 'Eduardo902 Villegas15' THEN 'Eduardo Villegas'
            WHEN "provider_name" = 'Elise948 Smitham825' THEN 'Elise Smitham'
            WHEN "provider_name" = 'Eliseo499 Reinger292' THEN 'Eliseo Reinger'
            WHEN "provider_name" = 'Ellen406 Farrell962' THEN 'Ellen Farrell'
            WHEN "provider_name" = 'Elmer371 Kutch271' THEN 'Elmer Kutch'
            WHEN "provider_name" = 'Elvera717 Gusikowski974' THEN 'Elvera Gusikowski'
            WHEN "provider_name" = 'Emerita401 Satterfield305' THEN 'Emerita Satterfield'
            WHEN "provider_name" = 'Errol226 Gaylord332' THEN 'Errol Gaylord'
            WHEN "provider_name" = 'Ervin886 Leannon79' THEN 'Ervin Leannon'
            WHEN "provider_name" = 'Erwin847 Stiedemann542' THEN 'Erwin Stiedemann'
            WHEN "provider_name" = 'Esteban536 Torres807' THEN 'Esteban Torres'
            WHEN "provider_name" = 'Eufemia350 Casper496' THEN 'Eufemia Casper'
            WHEN "provider_name" = 'Evelia928 Bogisich202' THEN 'Evelia Bogisich'
            WHEN "provider_name" = 'Fidel864 Swift555' THEN 'Fidel Swift'
            WHEN "provider_name" = 'Francisco472 Gusikowski974' THEN 'Francisco Gusikowski'
            WHEN "provider_name" = 'Gabriel934 Reilly981' THEN 'Gabriel Reilly'
            WHEN "provider_name" = 'Gerardo48 Montez99' THEN 'Gerardo Montez'
            WHEN "provider_name" = 'Germán350 Dueñas839' THEN 'Germán Dueñas'
            WHEN "provider_name" = 'Gonzalo160 Rodríguez701' THEN 'Gonzalo Rodríguez'
            WHEN "provider_name" = 'Gregory545 Toy286' THEN 'Gregory Toy'
            WHEN "provider_name" = 'Hal307 Wiegand701' THEN 'Hal Wiegand'
            WHEN "provider_name" = 'Hank686 Kemmer137' THEN 'Hank Kemmer'
            WHEN "provider_name" = 'Harvey63 Tromp100' THEN 'Harvey Tromp'
            WHEN "provider_name" = 'Haywood675 Bednar518' THEN 'Haywood Bednar'
            WHEN "provider_name" = 'Horace32 Grady603' THEN 'Horace Grady'
            WHEN "provider_name" = 'Humberto482 Mann644' THEN 'Humberto Mann'
            WHEN "provider_name" = 'Hyman89 Schmeler639' THEN 'Hyman Schmeler'
            WHEN "provider_name" = 'Ignacio928 O''Keefe54' THEN 'Ignacio O''Keefe'
            WHEN "provider_name" = 'Ilana185 Torp761' THEN 'Ilana Torp'
            WHEN "provider_name" = 'Irvin970 Emard19' THEN 'Irvin Emard'
            WHEN "provider_name" = 'Isaias604 Dickinson688' THEN 'Isaias Dickinson'
            WHEN "provider_name" = 'Isiah14 Nikolaus26' THEN 'Isiah Nikolaus'
            WHEN "provider_name" = 'Isiah14 Schaefer657' THEN 'Isiah Schaefer'
            WHEN "provider_name" = 'Jacobo456 Vergara204' THEN 'Jacobo Vergara'
            WHEN "provider_name" = 'Janeth814 Hyatt152' THEN 'Janeth Hyatt'
            WHEN "provider_name" = 'Jeana169 Cronin387' THEN 'Jeana Cronin'
            WHEN "provider_name" = 'Jefferey580 Luettgen772' THEN 'Jefferey Luettgen'
            WHEN "provider_name" = 'Joanna347 Abbott774' THEN 'Joanna Abbott'
            WHEN "provider_name" = 'Johna806 Klein929' THEN 'Johna Klein'
            WHEN "provider_name" = 'Joline447 Stark857' THEN 'Joline Stark'
            WHEN "provider_name" = 'Jolynn62 Adams676' THEN 'Jolynn Adams'
            WHEN "provider_name" = 'Joshua658 Borer986' THEN 'Joshua Borer'
            WHEN "provider_name" = 'Juan88 Friesen796' THEN 'Juan Friesen'
            WHEN "provider_name" = 'Jules135 Emard19' THEN 'Jules Emard'
            WHEN "provider_name" = 'Julio255 Rivas297' THEN 'Julio Rivas'
            WHEN "provider_name" = 'Kai187 Mann644' THEN 'Kai Mann'
            WHEN "provider_name" = 'Kathi607 Hilpert278' THEN 'Kathi Hilpert'
            WHEN "provider_name" = 'Keith571 Friesen796' THEN 'Keith Friesen'
            WHEN "provider_name" = 'Kendra609 Kassulke119' THEN 'Kendra Kassulke'
            WHEN "provider_name" = 'Kirby843 Rippin620' THEN 'Kirby Rippin'
            WHEN "provider_name" = 'Kisha966 Beahan375' THEN 'Kisha Beahan'
            WHEN "provider_name" = 'Kizzie166 Lehner980' THEN 'Kizzie Lehner'
            WHEN "provider_name" = 'Kristina583 Bashirian201' THEN 'Kristina Bashirian'
            WHEN "provider_name" = 'Kyoko885 Price929' THEN 'Kyoko Price'
            WHEN "provider_name" = 'Lane844 Gutmann970' THEN 'Lane Gutmann'
            WHEN "provider_name" = 'Lashanda692 Gutmann970' THEN 'Lashanda Gutmann'
            WHEN "provider_name" = 'Lasonya941 Kiehn525' THEN 'Lasonya Kiehn'
            WHEN "provider_name" = 'Latasha666 Fay398' THEN 'Latasha Fay'
            WHEN "provider_name" = 'Latoria810 Eichmann909' THEN 'Latoria Eichmann'
            WHEN "provider_name" = 'Latrina689 White193' THEN 'Latrina White'
            WHEN "provider_name" = 'Leif534 Hane680' THEN 'Leif Hane'
            WHEN "provider_name" = 'Leonarda398 Schumm995' THEN 'Leonarda Schumm'
            WHEN "provider_name" = 'Lindsay928 Leffler128' THEN 'Lindsay Leffler'
            WHEN "provider_name" = 'Linn541 Lynch190' THEN 'Linn Lynch'
            WHEN "provider_name" = 'Lino542 Feest103' THEN 'Lino Feest'
            WHEN "provider_name" = 'Livia401 Rippin620' THEN 'Livia Rippin'
            WHEN "provider_name" = 'Luvenia178 Breitenberg711' THEN 'Luvenia Breitenberg'
            WHEN "provider_name" = 'Lyman173 Kshlerin58' THEN 'Lyman Kshlerin'
            WHEN "provider_name" = 'Madelaine318 Walker122' THEN 'Madelaine Walker'
            WHEN "provider_name" = 'Magdalena964 Torphy630' THEN 'Magdalena Torphy'
            WHEN "provider_name" = 'Maragaret140 Erdman779' THEN 'Maragaret Erdman'
            WHEN "provider_name" = 'Maren639 Aufderhar910' THEN 'Maren Aufderhar'
            WHEN "provider_name" = 'Margarite168 Koepp521' THEN 'Margarite Koepp'
            WHEN "provider_name" = 'Margene509 Schamberger479' THEN 'Margene Schamberger'
            WHEN "provider_name" = 'Mariah942 Hilpert278' THEN 'Mariah Hilpert'
            WHEN "provider_name" = 'Mariana775 Menéndez746' THEN 'Mariana Menéndez'
            WHEN "provider_name" = 'Mariette443 Rau926' THEN 'Mariette Rau'
            WHEN "provider_name" = 'Matthew562 Bailey598' THEN 'Matthew Bailey'
            WHEN "provider_name" = 'Maynard46 Ward668' THEN 'Maynard Ward'
            WHEN "provider_name" = 'Melissa844 Yundt842' THEN 'Melissa Yundt'
            WHEN "provider_name" = 'Mertie42 Lakin515' THEN 'Mertie Lakin'
            WHEN "provider_name" = 'Milda157 Schoen8' THEN 'Milda Schoen'
            WHEN "provider_name" = 'Millard193 Doyle959' THEN 'Millard Doyle'
            WHEN "provider_name" = 'Nicholle822 Satterfield305' THEN 'Nicholle Satterfield'
            WHEN "provider_name" = 'Noma845 Mraz590' THEN 'Noma Mraz'
            WHEN "provider_name" = 'Norah104 Jenkins714' THEN 'Norah Jenkins'
            WHEN "provider_name" = 'Olen518 Farrell962' THEN 'Olen Farrell'
            WHEN "provider_name" = 'Orpha286 Marks830' THEN 'Orpha Marks'
            WHEN "provider_name" = 'Paris331 Ruecker817' THEN 'Paris Ruecker'
            WHEN "provider_name" = 'Patrina117 Strosin214' THEN 'Patrina Strosin'
            WHEN "provider_name" = 'Paulene52 Kihn564' THEN 'Paulene Kihn'
            WHEN "provider_name" = 'Precious140 Runolfsson901' THEN 'Precious Runolfsson'
            WHEN "provider_name" = 'Ramona980 Zavala169' THEN 'Ramona Zavala'
            WHEN "provider_name" = 'Randa356 Ritchie586' THEN 'Randa Ritchie'
            WHEN "provider_name" = 'Randy380 Bergstrom287' THEN 'Randy Bergstrom'
            WHEN "provider_name" = 'Randy380 Kilback373' THEN 'Randy Kilback'
            WHEN "provider_name" = 'Rebekah348 Rippin620' THEN 'Rebekah Rippin'
            WHEN "provider_name" = 'Reginia455 Johnson679' THEN 'Reginia Johnson'
            WHEN "provider_name" = 'Rex53 Gerhold939' THEN 'Rex Gerhold'
            WHEN "provider_name" = 'Rhonda22 Bins636' THEN 'Rhonda Bins'
            WHEN "provider_name" = 'Rod343 Durgan499' THEN 'Rod Durgan'
            WHEN "provider_name" = 'Rod343 Goyette777' THEN 'Rod Goyette'
            WHEN "provider_name" = 'Rodney21 Hettinger594' THEN 'Rodney Hettinger'
            WHEN "provider_name" = 'Rolland302 Lemke654' THEN 'Rolland Lemke'
            WHEN "provider_name" = 'Royce974 Kohler843' THEN 'Royce Kohler'
            WHEN "provider_name" = 'Rupert654 Walker122' THEN 'Rupert Walker'
            WHEN "provider_name" = 'Rusty501 Rodriguez71' THEN 'Rusty Rodriguez'
            WHEN "provider_name" = 'Sallie654 Barrows492' THEN 'Sallie Barrows'
            WHEN "provider_name" = 'Samuel331 Runte676' THEN 'Samuel Runte'
            WHEN "provider_name" = 'Santina680 Dicki44' THEN 'Santina Dicki'
            WHEN "provider_name" = 'Sean831 DuBuque211' THEN 'Sean DuBuque'
            WHEN "provider_name" = 'Sharilyn202 Wolff180' THEN 'Sharilyn Wolff'
            WHEN "provider_name" = 'Shasta644 King743' THEN 'Shasta King'
            WHEN "provider_name" = 'Shawanna357 Roob72' THEN 'Shawanna Roob'
            WHEN "provider_name" = 'Shayla126 White193' THEN 'Shayla White'
            WHEN "provider_name" = 'Shon148 Reinger292' THEN 'Shon Reinger'
            WHEN "provider_name" = 'Shon148 Swift555' THEN 'Shon Swift'
            WHEN "provider_name" = 'Tambra47 Heaney114' THEN 'Tambra Heaney'
            WHEN "provider_name" = 'Tamisha203 Wilderman619' THEN 'Tamisha Wilderman'
            WHEN "provider_name" = 'Tashina114 Towne435' THEN 'Tashina Towne'
            WHEN "provider_name" = 'Teodoro374 Koss676' THEN 'Teodoro Koss'
            WHEN "provider_name" = 'Terence292 Brakus656' THEN 'Terence Brakus'
            WHEN "provider_name" = 'Tomás404 Hinojosa147' THEN 'Tomás Hinojosa'
            WHEN "provider_name" = 'Trey250 Satterfield305' THEN 'Trey Satterfield'
            WHEN "provider_name" = 'Trinity427 Hartmann983' THEN 'Trinity Hartmann'
            WHEN "provider_name" = 'Troy560 Carter549' THEN 'Troy Carter'
            WHEN "provider_name" = 'Tyron580 Littel644' THEN 'Tyron Littel'
            WHEN "provider_name" = 'Venice604 Rogahn59' THEN 'Venice Rogahn'
            WHEN "provider_name" = 'Vito638 Barton704' THEN 'Vito Barton'
            WHEN "provider_name" = 'Waldo53 Hintz995' THEN 'Waldo Hintz'
            WHEN "provider_name" = 'Willian804 Batz141' THEN 'Willian Batz'
            WHEN "provider_name" = 'Wilson960 Turner526' THEN 'Wilson Turner'
            WHEN "provider_name" = 'Zane918 Bosco882' THEN 'Zane Bosco'
            ELSE "provider_name"
        END AS "provider_name",
        "GENDER",
        "SPECIALITY",
        "street_address",
        "CITY",
        "STATE",
        "ZIP",
        "latitude",
        "longitude",
        "patient_encounters",
        "procedures_performed"
    FROM "providers_renamed"
),

"providers_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- ZIP: from INT to VARCHAR
    -- organization_id: from VARCHAR to UUID
    -- provider_id: from VARCHAR to UUID
    SELECT
        "provider_name",
        "GENDER",
        "SPECIALITY",
        "street_address",
        "CITY",
        "STATE",
        "latitude",
        "longitude",
        "patient_encounters",
        "procedures_performed",
        CAST("ZIP" AS VARCHAR) 
        AS "ZIP",
        CAST("organization_id" AS UUID) 
        AS "organization_id",
        CAST("provider_id" AS UUID) 
        AS "provider_id"
    FROM "providers_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "providers_renamed_cleaned_casted"
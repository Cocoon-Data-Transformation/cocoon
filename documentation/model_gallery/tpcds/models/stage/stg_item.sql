-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"item_renamed" AS (
    -- Rename: Renaming columns
    -- I_ITEM_SK -> ITEM_SURROGATE_KEY
    -- I_ITEM_ID -> ITEM_ID
    -- I_REC_START_DATE -> RECORD_START_DATE
    -- I_REC_END_DATE -> RECORD_END_DATE
    -- I_ITEM_DESC -> ITEM_DESCRIPTION
    -- I_CURRENT_PRICE -> CURRENT_PRICE
    -- I_WHOLESALE_COST -> WHOLESALE_COST
    -- I_BRAND_ID -> BRAND_ID
    -- I_BRAND -> BRAND_NAME
    -- I_CLASS_ID -> SUBCATEGORY_ID
    -- I_CLASS -> SUBCATEGORY
    -- I_CATEGORY_ID -> CATEGORY_ID
    -- I_CATEGORY -> CATEGORY_NAME
    -- I_MANUFACT_ID -> MANUFACTURER_ID
    -- I_MANUFACT -> MANUFACTURER
    -- I_SIZE -> SIZE_
    -- I_FORMULATION -> FORMULATION_CODE
    -- I_COLOR -> COLOR
    -- I_UNITS -> UNIT_OF_MEASURE
    -- I_CONTAINER -> CONTAINER_TYPE
    -- I_MANAGER_ID -> MANAGER_ID
    -- I_PRODUCT_NAME -> PRODUCT_NAME
    SELECT 
        "I_ITEM_SK" AS "ITEM_SURROGATE_KEY",
        "I_ITEM_ID" AS "ITEM_ID",
        "I_REC_START_DATE" AS "RECORD_START_DATE",
        "I_REC_END_DATE" AS "RECORD_END_DATE",
        "I_ITEM_DESC" AS "ITEM_DESCRIPTION",
        "I_CURRENT_PRICE" AS "CURRENT_PRICE",
        "I_WHOLESALE_COST" AS "WHOLESALE_COST",
        "I_BRAND_ID" AS "BRAND_ID",
        "I_BRAND" AS "BRAND_NAME",
        "I_CLASS_ID" AS "SUBCATEGORY_ID",
        "I_CLASS" AS "SUBCATEGORY",
        "I_CATEGORY_ID" AS "CATEGORY_ID",
        "I_CATEGORY" AS "CATEGORY_NAME",
        "I_MANUFACT_ID" AS "MANUFACTURER_ID",
        "I_MANUFACT" AS "MANUFACTURER",
        "I_SIZE" AS "SIZE_",
        "I_FORMULATION" AS "FORMULATION_CODE",
        "I_COLOR" AS "COLOR",
        "I_UNITS" AS "UNIT_OF_MEASURE",
        "I_CONTAINER" AS "CONTAINER_TYPE",
        "I_MANAGER_ID" AS "MANAGER_ID",
        "I_PRODUCT_NAME" AS "PRODUCT_NAME"
    FROM "item"
),

"item_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "ITEM_SURROGATE_KEY",
        "ITEM_ID",
        "RECORD_START_DATE",
        "RECORD_END_DATE",
        "CURRENT_PRICE",
        "WHOLESALE_COST",
        "BRAND_ID",
        "BRAND_NAME",
        "SUBCATEGORY_ID",
        "SUBCATEGORY",
        "CATEGORY_ID",
        "CATEGORY_NAME",
        "MANUFACTURER_ID",
        "MANUFACTURER",
        "SIZE_",
        "FORMULATION_CODE",
        "COLOR",
        "UNIT_OF_MEASURE",
        "CONTAINER_TYPE",
        "MANAGER_ID",
        "PRODUCT_NAME",
        TRIM("ITEM_DESCRIPTION") AS "ITEM_DESCRIPTION"
    FROM "item_renamed"
),

"item_renamed_trimmed_cleaned" AS (
    -- Clean unusual string values: 
    -- SUBCATEGORY: The SUBCATEGORY column has several issues: 1. Misspelling: 'karoke' should be 'karaoke' 2. Inconsistent use of singular/plural: e.g., 'dresses' vs 'shirt', 'pants' vs 'accessories' 3. Inconsistent hyphenation: e.g., 'sports-apparel' vs 'mens watch' 4. Typo: 'birdal' should be 'bridal' 5. Inconsistent capitalization: most are lowercase, but some like 'pop' and 'rock' might refer to music genres To standardize, we'll use lowercase, plural forms where applicable, and add hyphens for compound terms. Music genres will be capitalized. 
    -- MANUFACTURER: The problem is that all values in the MANUFACTURER column are nonsensical combinations of word fragments, not representing real manufacturers. These values appear to be randomly generated strings or corrupted data. There are no correct or meaningful values that can be derived from these nonsensical combinations. In this case, the best approach is to map all these invalid entries to an empty string, indicating missing or invalid data. 
    -- SIZE_: The problem is that the SIZE_ column has inconsistent formatting and scale. 'extra large' uses spaces while others don't, which is inconsistent. 'petite' and 'economy' are not part of the standard size scale (small, medium, large, extra large). The correct values should follow a consistent format without spaces and use the standard size scale. 
    -- UNIT_OF_MEASURE: The problem is inconsistency in unit representations and potential redundancy. 'Lb' and 'Pound' represent the same unit of weight, with 'Pound' being more descriptive. Similarly, 'Oz' and 'Ounce' are the same unit, with 'Ounce' being the full word. 'Tsp' and 'Tbl' are abbreviations that should be spelled out for clarity. 'Unknown' is not a valid unit of measure. The correct values should use full words where possible and maintain consistency. 
    -- PRODUCT_NAME: The problem is that some product names have redundant prefixes or suffixes, and some contain unexpected spaces. The correct values should be consistent, without redundancy or spaces. The most frequent patterns for each base word should be used. 
    -- ITEM_DESCRIPTION: Fail to run
    SELECT
        "ITEM_SURROGATE_KEY",
        "ITEM_ID",
        "RECORD_START_DATE",
        "RECORD_END_DATE",
        "CURRENT_PRICE",
        "WHOLESALE_COST",
        "BRAND_ID",
        "BRAND_NAME",
        "SUBCATEGORY_ID",
        CASE
            WHEN "SUBCATEGORY" = 'karoke' THEN 'karaoke'
            WHEN "SUBCATEGORY" = 'shirt' THEN 'shirts'
            WHEN "SUBCATEGORY" = 'athletic' THEN 'athletic-wear'
            WHEN "SUBCATEGORY" = 'costume' THEN 'costumes'
            WHEN "SUBCATEGORY" = 'diamond' THEN 'diamonds'
            WHEN "SUBCATEGORY" = 'infant' THEN 'infants'
            WHEN "SUBCATEGORY" = 'kid' THEN 'kids'
            WHEN "SUBCATEGORY" = 'mens watch' THEN 'mens-watches'
            WHEN "SUBCATEGORY" = 'musical' THEN 'musicals'
            WHEN "SUBCATEGORY" = 'optic' THEN 'optics'
            WHEN "SUBCATEGORY" = 'pant' THEN 'pants'
            WHEN "SUBCATEGORY" = 'scanner' THEN 'scanners'
            WHEN "SUBCATEGORY" = 'art' THEN 'arts'
            WHEN "SUBCATEGORY" = 'birdal' THEN 'bridal'
            WHEN "SUBCATEGORY" = 'bracelet' THEN 'bracelets'
            WHEN "SUBCATEGORY" = 'curtains/drapes' THEN 'curtains-and-drapes'
            WHEN "SUBCATEGORY" = 'disk drives' THEN 'disk-drives'
            WHEN "SUBCATEGORY" = 'men' THEN 'mens'
            WHEN "SUBCATEGORY" = 'pendant' THEN 'pendants'
            WHEN "SUBCATEGORY" = 'ring' THEN 'rings'
            WHEN "SUBCATEGORY" = 'sport' THEN 'sports'
            WHEN "SUBCATEGORY" = 'stereo' THEN 'stereos'
            WHEN "SUBCATEGORY" = 'television' THEN 'televisions'
            WHEN "SUBCATEGORY" = 'pop' THEN 'Pop'
            WHEN "SUBCATEGORY" = 'rock' THEN 'Rock'
            WHEN "SUBCATEGORY" = 'classical' THEN 'Classical'
            WHEN "SUBCATEGORY" = 'country' THEN 'Country'
            WHEN "SUBCATEGORY" = 'womens' THEN 'women''s watches'
            WHEN "SUBCATEGORY" = 'womens watch' THEN 'women''s watches'
            ELSE "SUBCATEGORY"
        END AS "SUBCATEGORY",
        "CATEGORY_ID",
        "CATEGORY_NAME",
        "MANUFACTURER_ID",
        CASE
            WHEN "MANUFACTURER" = 'ableantiable' THEN ''
            WHEN "MANUFACTURER" = 'anticallyeing' THEN ''
            WHEN "MANUFACTURER" = 'antieseese' THEN ''
            WHEN "MANUFACTURER" = 'ationoughtought' THEN ''
            WHEN "MANUFACTURER" = 'callyeingeing' THEN ''
            WHEN "MANUFACTURER" = 'callyese' THEN ''
            WHEN "MANUFACTURER" = 'priantianti' THEN ''
            WHEN "MANUFACTURER" = 'ableablepri' THEN ''
            WHEN "MANUFACTURER" = 'ablebarpri' THEN ''
            WHEN "MANUFACTURER" = 'ableoughtese' THEN ''
            WHEN "MANUFACTURER" = 'antieingn st' THEN ''
            WHEN "MANUFACTURER" = 'antin stn st' THEN ''
            WHEN "MANUFACTURER" = 'ationcallyought' THEN ''
            WHEN "MANUFACTURER" = 'ationeseought' THEN ''
            WHEN "MANUFACTURER" = 'barableable' THEN ''
            WHEN "MANUFACTURER" = 'barcallyese' THEN ''
            WHEN "MANUFACTURER" = 'bareseought' THEN ''
            WHEN "MANUFACTURER" = 'barprically' THEN ''
            WHEN "MANUFACTURER" = 'callyation' THEN ''
            WHEN "MANUFACTURER" = 'callyationpri' THEN ''
            WHEN "MANUFACTURER" = 'eseableought' THEN ''
            WHEN "MANUFACTURER" = 'eseantiable' THEN ''
            WHEN "MANUFACTURER" = 'eseantin st' THEN ''
            WHEN "MANUFACTURER" = 'esen stable' THEN ''
            WHEN "MANUFACTURER" = 'n stcallyought' THEN ''
            WHEN "MANUFACTURER" = 'priprically' THEN ''
            WHEN "MANUFACTURER" = 'ableablecally' THEN ''
            WHEN "MANUFACTURER" = 'ableanti' THEN ''
            WHEN "MANUFACTURER" = 'ablecallycally' THEN ''
            WHEN "MANUFACTURER" = 'antiablecally' THEN ''
            WHEN "MANUFACTURER" = 'antiationable' THEN ''
            WHEN "MANUFACTURER" = 'antieingable' THEN ''
            WHEN "MANUFACTURER" = 'antieingation' THEN ''
            WHEN "MANUFACTURER" = 'antieingpri' THEN ''
            WHEN "MANUFACTURER" = 'ationbarn st' THEN ''
            WHEN "MANUFACTURER" = 'ationcallyn st' THEN ''
            WHEN "MANUFACTURER" = 'ationeing' THEN ''
            WHEN "MANUFACTURER" = 'ationeingought' THEN ''
            WHEN "MANUFACTURER" = 'ationese' THEN ''
            WHEN "MANUFACTURER" = 'ationeseanti' THEN ''
            WHEN "MANUFACTURER" = 'barantipri' THEN ''
            WHEN "MANUFACTURER" = 'barcallyable' THEN ''
            WHEN "MANUFACTURER" = 'bareseanti' THEN ''
            WHEN "MANUFACTURER" = 'barn stable' THEN ''
            WHEN "MANUFACTURER" = 'callyable' THEN ''
            WHEN "MANUFACTURER" = 'callyantiought' THEN ''
            WHEN "MANUFACTURER" = 'callyationought' THEN ''
            WHEN "MANUFACTURER" = 'callybarpri' THEN ''
            WHEN "MANUFACTURER" = 'eingcallypri' THEN ''
            WHEN "MANUFACTURER" = 'eingpripri' THEN ''
            WHEN "MANUFACTURER" = 'eseanti' THEN ''
            WHEN "MANUFACTURER" = 'eseantiought' THEN ''
            WHEN "MANUFACTURER" = 'esecallyable' THEN ''
            WHEN "MANUFACTURER" = 'esecallypri' THEN ''
            WHEN "MANUFACTURER" = 'eseoughtable' THEN ''
            WHEN "MANUFACTURER" = 'esepriation' THEN ''
            WHEN "MANUFACTURER" = 'n stationese' THEN ''
            WHEN "MANUFACTURER" = 'n steingese' THEN ''
            WHEN "MANUFACTURER" = 'n steseeing' THEN ''
            WHEN "MANUFACTURER" = 'oughtableought' THEN ''
            WHEN "MANUFACTURER" = 'oughtbarpri' THEN ''
            WHEN "MANUFACTURER" = 'oughtpriese' THEN ''
            WHEN "MANUFACTURER" = 'priantically' THEN ''
            WHEN "MANUFACTURER" = 'prieseese' THEN ''
            WHEN "MANUFACTURER" = 'prioughtese' THEN ''
            WHEN "MANUFACTURER" = 'priprin st' THEN ''
            ELSE "MANUFACTURER"
        END AS "MANUFACTURER",
        CASE
            WHEN "SIZE_" = 'petite' THEN 'small'
            WHEN "SIZE_" = 'extra large' THEN 'extralarge'
            WHEN "SIZE_" = 'economy' THEN 'small'
            ELSE "SIZE_"
        END AS "SIZE_",
        "FORMULATION_CODE",
        "COLOR",
        CASE
            WHEN "UNIT_OF_MEASURE" = 'Lb' THEN 'Pound'
            WHEN "UNIT_OF_MEASURE" = 'Oz' THEN 'Ounce'
            WHEN "UNIT_OF_MEASURE" = 'Tsp' THEN 'Teaspoon'
            WHEN "UNIT_OF_MEASURE" = 'Tbl' THEN 'Tablespoon'
            WHEN "UNIT_OF_MEASURE" = 'Unknown' THEN ''
            ELSE "UNIT_OF_MEASURE"
        END AS "UNIT_OF_MEASURE",
        "CONTAINER_TYPE",
        "MANAGER_ID",
        CASE
            WHEN "PRODUCT_NAME" = 'ableable' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ableanti' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ableation' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ablecally' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ableeing' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ableese' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ablen st' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ableought' THEN 'able'
            WHEN "PRODUCT_NAME" = 'ablepri' THEN 'able'
            WHEN "PRODUCT_NAME" = 'antiable' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antianti' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antiation' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antically' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antieing' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antiese' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antin st' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antiought' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'antipri' THEN 'anti'
            WHEN "PRODUCT_NAME" = 'ationable' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationanti' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationation' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationcally' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationeing' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationese' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationn st' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationought' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'ationpri' THEN 'ation'
            WHEN "PRODUCT_NAME" = 'barable' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'baranti' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'baration' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'barcally' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'bareing' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'barese' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'barn st' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'barought' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'barpri' THEN 'bar'
            WHEN "PRODUCT_NAME" = 'callyable' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callyanti' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callyation' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callycally' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callyeing' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callyese' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callyn st' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callyought' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'callypri' THEN 'cally'
            WHEN "PRODUCT_NAME" = 'eingn st' THEN 'eingst'
            WHEN "PRODUCT_NAME" = 'esen st' THEN 'esest'
            WHEN "PRODUCT_NAME" = 'n st' THEN 'st'
            WHEN "PRODUCT_NAME" = 'n stable' THEN 'stable'
            WHEN "PRODUCT_NAME" = 'n stanti' THEN 'stanti'
            WHEN "PRODUCT_NAME" = 'n station' THEN 'station'
            WHEN "PRODUCT_NAME" = 'n stcally' THEN 'stcally'
            WHEN "PRODUCT_NAME" = 'n steing' THEN 'sting'
            WHEN "PRODUCT_NAME" = 'n stese' THEN 'stese'
            WHEN "PRODUCT_NAME" = 'n stn st' THEN 'stst'
            WHEN "PRODUCT_NAME" = 'n stought' THEN 'stought'
            WHEN "PRODUCT_NAME" = 'n stpri' THEN 'stpri'
            WHEN "PRODUCT_NAME" = 'oughtn st' THEN 'oughtst'
            WHEN "PRODUCT_NAME" = 'prin st' THEN 'prist'
            WHEN "PRODUCT_NAME" = 'eseeing' THEN 'eseing'
            WHEN "PRODUCT_NAME" = 'eseese' THEN 'esese'
            WHEN "PRODUCT_NAME" = 'oughteing' THEN 'oughting'
            WHEN "PRODUCT_NAME" = 'prieing' THEN 'pring'
            ELSE "PRODUCT_NAME"
        END AS "PRODUCT_NAME",
        CASE
            WHEN "ITEM_DESCRIPTION" = 'Particu' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Periods provide as distinctive, little ingredients; therefore social boys must not leave slightl' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Pictures see even healthy designs. Considerable, visual concessions last controversia' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Political parents know right; perfec' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Powers will not get influences. Electoral ports should show low, annual chains. Now young visitors may pose now however final pages. Bitterly right children suit increasing, leading el' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Principles secure best. Relevant foods mislead there so prime relations. Quickly convenient times may think men. Interesting, other bodies w' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Quite different services promote all the same. Private, marginal colleagues play of course similar, different girls. French, local girls reap here. Bad movies shorten relatively. Terms' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Rational, electronic photographs worry. Other, similar pounds might enable suddenly middle, growing months. Military, desperate funds shall not know then also various germans. Heavy' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Regional, indian casualties shall say of course legal relations. Endless, cultural animals dislike new, possible resources. Socialist, very plans wonder precisely available star' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Seats could come confident, moder' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Sensitive requirements will not supply all intelligent effects. U' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Serious, little suppliers object hot, new weeks. Votes shall prevail yet. Windows understand equal members. Average consequences go at least pales' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Short, bitter heads like then events. Assessments may hide just. Wild european books should maintain yesterday useful natural workers. Late responsible estimates would' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'So fair schools must go problems. Children should not paint in a photographs. Great, late senten' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'So new campaigns teach more straight early indians. International offices shake actual ministers. New, liable theories can see expenses. Nice, imperial teams wo' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Social, simple se' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Sure available terms know just nice, human officials. Problems used to receive. United, cheap changes get better british houses. Full bars shift often important readers; inc' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Systems loosen special, easy partners. Prime, noble windows condemn effective, nation' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Thus present women should hear for a shares; leaders must come early; immediate men will want exactly young groups. Insects may ask narrow variations. New leaders should deal' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'True potatoes sound equal heads' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Twin, particular aspects will accept only on' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Video-taped, ch' THEN ''
            WHEN "ITEM_DESCRIPTION" = 'Wide clear weeks join surely medical others; again dull effects stretch. Only, great needs may brin' THEN ''
            ELSE "ITEM_DESCRIPTION"
        END AS "ITEM_DESCRIPTION"
    FROM "item_renamed_trimmed"
),

"item_renamed_trimmed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- MANUFACTURER: ['']
    -- UNIT_OF_MEASURE: ['']
    -- ITEM_DESCRIPTION: ['']
    SELECT 
        CASE
            WHEN "MANUFACTURER" = '' THEN NULL
            ELSE "MANUFACTURER"
        END AS "MANUFACTURER",
        CASE
            WHEN "UNIT_OF_MEASURE" = '' THEN NULL
            ELSE "UNIT_OF_MEASURE"
        END AS "UNIT_OF_MEASURE",
        CASE
            WHEN "ITEM_DESCRIPTION" = '' THEN NULL
            ELSE "ITEM_DESCRIPTION"
        END AS "ITEM_DESCRIPTION",
        "MANUFACTURER_ID",
        "CONTAINER_TYPE",
        "SUBCATEGORY",
        "CATEGORY_NAME",
        "CATEGORY_ID",
        "RECORD_END_DATE",
        "MANAGER_ID",
        "SIZE_",
        "ITEM_SURROGATE_KEY",
        "CURRENT_PRICE",
        "RECORD_START_DATE",
        "FORMULATION_CODE",
        "COLOR",
        "ITEM_ID",
        "BRAND_ID",
        "WHOLESALE_COST",
        "SUBCATEGORY_ID",
        "BRAND_NAME",
        "PRODUCT_NAME"
    FROM "item_renamed_trimmed_cleaned"
),

"item_renamed_trimmed_cleaned_null_casted" AS (
    -- Column Type Casting: 
    -- BRAND_ID: from INT to VARCHAR
    -- RECORD_END_DATE: from VARCHAR to DATE
    -- RECORD_START_DATE: from VARCHAR to DATE
    SELECT
        "MANUFACTURER",
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
        CAST("BRAND_ID" AS VARCHAR) AS "BRAND_ID",
        CAST("RECORD_END_DATE" AS DATE) AS "RECORD_END_DATE",
        CAST("RECORD_START_DATE" AS DATE) AS "RECORD_START_DATE"
    FROM "item_renamed_trimmed_cleaned_null"
),

"item_renamed_trimmed_cleaned_null_casted_missing_handled" AS (
    -- Handling missing values: There are 4 columns with unacceptable missing values
    -- ITEM_DESCRIPTION has 23.23 percent missing. Strategy: 🔄 Unchanged
    -- MANUFACTURER has 100.0 percent missing. Strategy: 🗑️ Drop Column
    -- SIZE_ has 52.53 percent missing. Strategy: 🔄 Unchanged
    -- UNIT_OF_MEASURE has 5.05 percent missing. Strategy: 🔄 Unchanged
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
        "RECORD_END_DATE",
        "RECORD_START_DATE"
    FROM "item_renamed_trimmed_cleaned_null_casted"
)

-- COCOON BLOCK END
SELECT * FROM "item_renamed_trimmed_cleaned_null_casted_missing_handled"
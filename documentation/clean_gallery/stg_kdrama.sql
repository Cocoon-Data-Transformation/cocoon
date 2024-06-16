-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"kdrama_renamed" AS (
    -- Rename: Renaming columns
    -- Name -> name
    -- Aired_Date -> aired_date_range
    -- Year_of_release -> release_year
    -- Original_Network -> original_network
    -- Aired_On -> aired_weekdays
    -- Number_of_Episodes -> num_episodes
    -- Duration -> episode_duration
    -- Content_Rating -> content_rating
    -- Rating -> rating
    -- Synopsis -> synopsis
    -- Genre -> genres
    -- Tags -> tags
    -- Director -> director
    -- Screenwriter -> screenwriter
    -- Cast_ -> main_cast
    -- Production_companies -> production_companies
    -- Rank -> popularity_rank
    SELECT 
        "Name" AS "name",
        "Aired_Date" AS "aired_date_range",
        "Year_of_release" AS "release_year",
        "Original_Network" AS "original_network",
        "Aired_On" AS "aired_weekdays",
        "Number_of_Episodes" AS "num_episodes",
        "Duration" AS "episode_duration",
        "Content_Rating" AS "content_rating",
        "Rating" AS "rating",
        "Synopsis" AS "synopsis",
        "Genre" AS "genres",
        "Tags" AS "tags",
        "Director" AS "director",
        "Screenwriter" AS "screenwriter",
        "Cast_" AS "main_cast",
        "Production_companies" AS "production_companies",
        "Rank" AS "popularity_rank"
    FROM "kdrama"
),

"kdrama_renamed_trimmed" AS (
    -- Trim Leading and Trailing Spaces
    SELECT
        "name",
        "aired_date_range",
        "release_year",
        "num_episodes",
        "content_rating",
        "rating",
        "director",
        "screenwriter",
        "main_cast",
        "popularity_rank",
        TRIM("original_network") AS "original_network",
        TRIM("aired_weekdays") AS "aired_weekdays",
        TRIM("episode_duration") AS "episode_duration",
        TRIM("synopsis") AS "synopsis",
        TRIM("genres") AS "genres",
        TRIM("tags") AS "tags",
        TRIM("production_companies") AS "production_companies"
    FROM "kdrama_renamed"
),

"kdrama_renamed_trimmed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- aired_date_range: ['Apr 29', ' 2020']
    SELECT 
        CASE
            WHEN "aired_date_range" = 'Apr 29' THEN NULL
            WHEN "aired_date_range" = ' 2020' THEN NULL
            ELSE "aired_date_range"
        END AS "aired_date_range",
        "episode_duration",
        "aired_weekdays",
        "genres",
        "popularity_rank",
        "content_rating",
        "name",
        "rating",
        "director",
        "num_episodes",
        "synopsis",
        "production_companies",
        "tags",
        "original_network",
        "main_cast",
        "screenwriter",
        "release_year"
    FROM "kdrama_renamed_trimmed"
),

"kdrama_renamed_trimmed_null_casted" AS (
    -- Column Type Casting: 
    -- genres: from VARCHAR to ARRAY
    -- main_cast: from VARCHAR to ARRAY
    -- tags: from VARCHAR to ARRAY
    SELECT
        "aired_date_range",
        "episode_duration",
        "aired_weekdays",
        "popularity_rank",
        "content_rating",
        "name",
        "rating",
        "director",
        "num_episodes",
        "synopsis",
        "production_companies",
        "original_network",
        "screenwriter",
        "release_year",
        CAST("genres" AS ARRAY) AS "genres",
        CAST("main_cast" AS ARRAY) AS "main_cast",
        CAST("tags" AS ARRAY) AS "tags"
    FROM "kdrama_renamed_trimmed_null"
)

-- COCOON BLOCK END
SELECT * FROM "kdrama_renamed_trimmed_null_casted"
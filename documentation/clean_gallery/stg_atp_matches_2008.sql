-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"atp_matches_2008_renamed" AS (
    -- Rename: Renaming columns
    -- winner_ht -> winner_height_cm
    -- loser_ht -> loser_height_cm
    -- minutes -> match_duration_minutes
    -- w_ace -> winner_aces
    -- w_df -> winner_double_faults
    -- w_svpt -> winner_service_points_played
    -- w_1stIn -> winner_first_serve_in
    -- w_1stWon -> winner_first_serve_points_won
    -- w_2ndWon -> winner_second_serve_points_won
    -- w_SvGms -> winner_service_games_played
    -- w_bpSaved -> winner_break_points_saved
    -- w_bpFaced -> winner_break_points_faced
    -- l_ace -> loser_aces
    -- l_df -> loser_double_faults
    -- l_svpt -> loser_service_points_played
    -- l_1stIn -> loser_1st_serves_in
    -- l_1stWon -> loser_1st_serve_points_won
    -- l_2ndWon -> loser_2nd_serve_points_won
    -- l_SvGms -> loser_service_games_played
    -- l_bpSaved -> loser_break_points_saved
    -- l_bpFaced -> loser_break_points_faced
    SELECT 
        "tourney_id",
        "tourney_name",
        "surface",
        "draw_size",
        "tourney_level",
        "tourney_date",
        "match_num",
        "winner_id",
        "winner_seed",
        "winner_entry",
        "winner_name",
        "winner_hand",
        "winner_ht" AS "winner_height_cm",
        "winner_ioc",
        "winner_age",
        "loser_id",
        "loser_seed",
        "loser_entry",
        "loser_name",
        "loser_hand",
        "loser_ht" AS "loser_height_cm",
        "loser_ioc",
        "loser_age",
        "score",
        "best_of",
        "round",
        "minutes" AS "match_duration_minutes",
        "w_ace" AS "winner_aces",
        "w_df" AS "winner_double_faults",
        "w_svpt" AS "winner_service_points_played",
        "w_1stIn" AS "winner_first_serve_in",
        "w_1stWon" AS "winner_first_serve_points_won",
        "w_2ndWon" AS "winner_second_serve_points_won",
        "w_SvGms" AS "winner_service_games_played",
        "w_bpSaved" AS "winner_break_points_saved",
        "w_bpFaced" AS "winner_break_points_faced",
        "l_ace" AS "loser_aces",
        "l_df" AS "loser_double_faults",
        "l_svpt" AS "loser_service_points_played",
        "l_1stIn" AS "loser_1st_serves_in",
        "l_1stWon" AS "loser_1st_serve_points_won",
        "l_2ndWon" AS "loser_2nd_serve_points_won",
        "l_SvGms" AS "loser_service_games_played",
        "l_bpSaved" AS "loser_break_points_saved",
        "l_bpFaced" AS "loser_break_points_faced",
        "winner_rank",
        "winner_rank_points",
        "loser_rank",
        "loser_rank_points"
    FROM "atp_matches_2008"
),

"atp_matches_2008_renamed_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- winner_hand: ['U']
    SELECT 
        CASE
            WHEN "winner_hand" = 'U' THEN NULL
            ELSE "winner_hand"
        END AS "winner_hand",
        "tourney_name",
        "winner_second_serve_points_won",
        "loser_ioc",
        "match_num",
        "winner_service_points_played",
        "loser_rank",
        "winner_ioc",
        "winner_double_faults",
        "winner_break_points_saved",
        "winner_height_cm",
        "winner_name",
        "surface",
        "loser_1st_serves_in",
        "tourney_date",
        "loser_name",
        "winner_rank_points",
        "winner_first_serve_points_won",
        "loser_id",
        "match_duration_minutes",
        "loser_seed",
        "tourney_level",
        "loser_1st_serve_points_won",
        "score",
        "loser_break_points_faced",
        "winner_seed",
        "loser_2nd_serve_points_won",
        "loser_service_games_played",
        "loser_hand",
        "loser_rank_points",
        "draw_size",
        "round",
        "winner_service_games_played",
        "loser_entry",
        "loser_double_faults",
        "tourney_id",
        "winner_id",
        "winner_age",
        "best_of",
        "loser_aces",
        "winner_rank",
        "loser_service_points_played",
        "winner_aces",
        "loser_height_cm",
        "winner_entry",
        "winner_first_serve_in",
        "loser_break_points_saved",
        "winner_break_points_faced",
        "loser_age"
    FROM "atp_matches_2008_renamed"
),

"atp_matches_2008_renamed_null_casted" AS (
    -- Column Type Casting: 
    -- loser_seed: from FLOAT to VARCHAR
    -- tourney_date: from INT to DATE
    -- winner_seed: from FLOAT to VARCHAR
    SELECT
        "winner_hand",
        "tourney_name",
        "winner_second_serve_points_won",
        "loser_ioc",
        "match_num",
        "winner_service_points_played",
        "loser_rank",
        "winner_ioc",
        "winner_double_faults",
        "winner_break_points_saved",
        "winner_height_cm",
        "winner_name",
        "surface",
        "loser_1st_serves_in",
        "loser_name",
        "winner_rank_points",
        "winner_first_serve_points_won",
        "loser_id",
        "match_duration_minutes",
        "tourney_level",
        "loser_1st_serve_points_won",
        "score",
        "loser_break_points_faced",
        "loser_2nd_serve_points_won",
        "loser_service_games_played",
        "loser_hand",
        "loser_rank_points",
        "draw_size",
        "round",
        "winner_service_games_played",
        "loser_entry",
        "loser_double_faults",
        "tourney_id",
        "winner_id",
        "winner_age",
        "best_of",
        "loser_aces",
        "winner_rank",
        "loser_service_points_played",
        "winner_aces",
        "loser_height_cm",
        "winner_entry",
        "winner_first_serve_in",
        "loser_break_points_saved",
        "winner_break_points_faced",
        "loser_age",
        CAST("loser_seed" AS VARCHAR) AS "loser_seed",
        TO_DATE(TO_CHAR("tourney_date"), 'YYYYMMDD') AS "tourney_date",
        CAST("winner_seed" AS VARCHAR) AS "winner_seed"
    FROM "atp_matches_2008_renamed_null"
)

-- COCOON BLOCK END
SELECT * FROM "atp_matches_2008_renamed_null_casted"
-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:06:20.318190+00:00
WITH 
"observations_renamed" AS (
    -- Rename: Renaming columns
    -- DATE_ -> observation_datetime
    -- PATIENT -> patient_id
    -- ENCOUNTER -> encounter_id
    -- CODE -> observation_code
    -- VALUE_ -> observation_value
    -- TYPE -> data_type
    SELECT 
        "DATE_" AS "observation_datetime",
        "PATIENT" AS "patient_id",
        "ENCOUNTER" AS "encounter_id",
        "CATEGORY",
        "CODE" AS "observation_code",
        "DESCRIPTION",
        "VALUE_" AS "observation_value",
        "UNITS",
        "TYPE" AS "data_type"
    FROM "memory"."main"."observations"
),

"observations_renamed_dedup" AS (
    -- Deduplication: Removed 556 duplicated rows
    SELECT DISTINCT *
    FROM "observations_renamed"
),

"observations_renamed_dedup_cleaned" AS (
    -- Clean unusual string values: 
    -- DESCRIPTION: The problem is inconsistent capitalization and punctuation in question-format values, as well as unexplained abbreviations. The correct values should have consistent capitalization (sentence case) and punctuation (question marks for questions), and abbreviated terms should be expanded for clarity.
    -- observation_value: '0.0' and 'No' likely represent the same concept. '1.0' and 'Yes' might also be redundant representations.
    -- UNITS: The problem is that some values in the UNITS column are not standard unit abbreviations and lack specificity. The unusual values are '{score}', '{nominal}', 'a', '{#}', '{INR}', '{presence}', '{SG}', and '{T-score}'. These are not standardized units of measurement but rather descriptors or placeholders. Additionally, some units have inconsistent formatting, such as '[pH]' vs 'pH', and '[degF]' which should be standardized. The correct values should be standardized units of measurement or left empty if they represent a score or nominal value without a specific unit.
    SELECT
        "observation_datetime",
        "patient_id",
        "encounter_id",
        "CATEGORY",
        "observation_code",
        CASE
            WHEN "DESCRIPTION" = 'At any point in the past 2 years  has season or migrant farm work been your or your family''s main source of income?' THEN 'At any point in the past 2 years, has season or migrant farm work been your or your family''s main source of income?'
            WHEN "DESCRIPTION" = 'During the past year  what was the total combined income for you and the family members you live with? This information will help us determine if you are eligible for any benefits.' THEN 'During the past year, what was the total combined income for you and the family members you live with? This information will help us determine if you are eligible for any benefits.'
            WHEN "DESCRIPTION" = 'Has lack of transportation kept you from medical appointments  meetings  work  or from getting things needed for daily living?' THEN 'Has lack of transportation kept you from medical appointments, meetings, work, or from getting things needed for daily living?'
            WHEN "DESCRIPTION" = 'How many family members  including yourself  do you currently live with?' THEN 'How many family members, including yourself, do you currently live with?'
            WHEN "DESCRIPTION" = 'How often do you see or talk to people that you care about and feel close to (For example: talking to friends on the phone  visiting friends or family  going to church or club meetings)?' THEN 'How often do you see or talk to people that you care about and feel close to? (For example: talking to friends on the phone, visiting friends or family, going to church or club meetings)'
            WHEN "DESCRIPTION" = 'In the past year  have you been afraid of your partner or ex-partner?' THEN 'In the past year, have you been afraid of your partner or ex-partner?'
            WHEN "DESCRIPTION" = 'In the past year  have you or any family members you live with been unable to get any of the following when it was really needed?' THEN 'In the past year, have you or any family members you live with been unable to get any of the following when it was really needed?'
            WHEN "DESCRIPTION" = 'In the past year  have you spent more than 2 nights in a row in a jail  prison  detention center  or juvenile correctional facility?' THEN 'In the past year, have you spent more than 2 nights in a row in a jail, prison, detention center, or juvenile correctional facility?'
            WHEN "DESCRIPTION" = 'Stress is when someone feels tense  nervous  anxious or can''t sleep at night because their mind is troubled. How stressed are you?' THEN 'Stress is when someone feels tense, nervous, anxious or can''t sleep at night because their mind is troubled. How stressed are you?'
            WHEN "DESCRIPTION" = 'DALY' THEN 'Disability-Adjusted Life Year (DALY)'
            WHEN "DESCRIPTION" = 'QALY' THEN 'Quality-Adjusted Life Year (QALY)'
            WHEN "DESCRIPTION" = 'QOLS' THEN 'Quality of Life Scale (QOLS)'
            WHEN "DESCRIPTION" = 'Total score [DAST-10]' THEN 'Total score [Drug Abuse Screening Test-10]'
            WHEN "DESCRIPTION" = 'Total score [HARK]' THEN 'Total score [Humiliation, Afraid, Rape, Kick Domestic Violence Screening Tool]'
            WHEN "DESCRIPTION" = 'Total score [AUDIT-C]' THEN 'Total score [Alcohol Use Disorders Identification Test-Concise]'
            WHEN "DESCRIPTION" = 'Patient Health Questionnaire-9: Modified for Teens total score [Reported.PHQ.Teen]' THEN 'Patient Health Questionnaire-9: Modified for Teens total score [PHQ-Teen]'
            WHEN "DESCRIPTION" = 'FEV1/FVC' THEN 'FEV1/FVC Ratio [Forced Expiratory Volume in 1 second / Forced Vital Capacity]'
            WHEN "DESCRIPTION" = 'Body temperature' THEN 'Body Temperature'
            WHEN "DESCRIPTION" = 'INR in Platelet poor plasma by Coagulation assay' THEN 'International Normalized Ratio (INR) in Platelet Poor Plasma by Coagulation Assay'
            WHEN "DESCRIPTION" = 'What number best describes how  during the past week  pain has interfered with your enjoyment of life?' THEN 'Pain Interference with Life Enjoyment (Past Week)'
            WHEN "DESCRIPTION" = 'What number best describes how  during the past week  pain has interfered with your general activity?' THEN 'Pain Interference with General Activity (Past Week)'
            WHEN "DESCRIPTION" = 'What number best describes your pain on average in the past week?' THEN 'Average Pain Level (Past Week)'
            WHEN "DESCRIPTION" = 'Head Occipital-frontal circumference' THEN 'Head Occipital-Frontal Circumference'
            WHEN "DESCRIPTION" = 'Head Occipital-frontal circumference Percentile' THEN 'Head Occipital-Frontal Circumference Percentile'
            WHEN "DESCRIPTION" = 'Weight-for-length Per age and sex' THEN 'Weight-for-Length Percentile by Age and Sex'
            WHEN "DESCRIPTION" = 'aPTT in Blood by Coagulation assay' THEN 'Activated Partial Thromboplastin Time (aPTT) in Blood by Coagulation Assay'
            WHEN "DESCRIPTION" = 'Bicarbonate [Moles/volume] in Arterial blood' THEN 'Bicarbonate [Moles/Volume] in Arterial Blood'
            WHEN "DESCRIPTION" = 'Carbon dioxide [Partial pressure] in Arterial blood' THEN 'Carbon Dioxide [Partial Pressure] in Arterial Blood'
            WHEN "DESCRIPTION" = 'Oxygen [Partial pressure] in Arterial blood' THEN 'Oxygen [Partial Pressure] in Arterial Blood'
            WHEN "DESCRIPTION" = 'pH of Arterial blood' THEN 'pH of Arterial Blood'
            WHEN "DESCRIPTION" = 'Phosphate [Mass/volume] in Serum or Plasma' THEN 'Phosphate [Mass/Volume] in Serum or Plasma'
            WHEN "DESCRIPTION" = 'Prothrombin time (PT)' THEN 'Prothrombin Time (PT)'
            WHEN "DESCRIPTION" = 'Patient Health Questionnaire 9 item (PHQ-9) total score [Reported]' THEN 'Patient Health Questionnaire-9 (PHQ-9) Total Score [Reported]'
            WHEN "DESCRIPTION" = 'Troponin I.cardiac [Mass/volume] in Serum or Plasma by High sensitivity method' THEN 'Cardiac Troponin I [Mass/Volume] in Serum or Plasma by High Sensitivity Method'
            WHEN "DESCRIPTION" = 'Drugs of abuse 5 panel - Urine by Screen method' THEN 'Drugs of Abuse 5-Panel - Urine Screen'
            WHEN "DESCRIPTION" = 'Iron binding capacity [Mass/volume] in Serum or Plasma' THEN 'Iron Binding Capacity [Mass/Volume] in Serum or Plasma'
            WHEN "DESCRIPTION" = 'Iron saturation [Mass Fraction] in Serum or Plasma' THEN 'Iron Saturation [Mass Fraction] in Serum or Plasma'
            WHEN "DESCRIPTION" = 'NT-proBNP' THEN 'N-Terminal Pro-B-Type Natriuretic Peptide (NT-proBNP)'
            WHEN "DESCRIPTION" = 'Total score [MMSE]' THEN 'Total Score [Mini-Mental State Examination (MMSE)]'
            WHEN "DESCRIPTION" = 'Natriuretic peptide.B prohormone N-Terminal [Mass/volume] in Blood by Immunoassay' THEN 'N-Terminal Pro-B-Type Natriuretic Peptide [Mass/Volume] in Blood by Immunoassay'
            WHEN "DESCRIPTION" = 'Left ventricular Ejection fraction' THEN 'Left Ventricular Ejection Fraction'
            WHEN "DESCRIPTION" = 'Operative Status Value' THEN 'Operative Status'
            WHEN "DESCRIPTION" = 'American house dust mite IgE Ab in Serum' THEN 'American House Dust Mite IgE Antibody in Serum'
            ELSE "DESCRIPTION"
        END AS "DESCRIPTION",
        "observation_value",
        CASE
            WHEN "UNITS" = '{score}' THEN NULL
            WHEN "UNITS" = 'mm[Hg]' THEN 'mmHg'
            WHEN "UNITS" = 'a' THEN '/year'
            WHEN "UNITS" = '{nominal}' THEN NULL
            WHEN "UNITS" = 'kg/m2' THEN 'kg/m²'
            WHEN "UNITS" = '{#}' THEN NULL
            WHEN "UNITS" = '10*3/uL' THEN '10³/µL'
            WHEN "UNITS" = '/a' THEN '/year'
            WHEN "UNITS" = '10*6/uL' THEN '10⁶/µL'
            WHEN "UNITS" = 'Cel' THEN '°C'
            WHEN "UNITS" = '{INR}' THEN NULL
            WHEN "UNITS" = 'mL/min/{1.73_m2}' THEN 'mL/min/1.73m²'
            WHEN "UNITS" = '[pH]' THEN 'pH'
            WHEN "UNITS" = '{presence}' THEN NULL
            WHEN "UNITS" = 'ug/dL' THEN 'µg/dL'
            WHEN "UNITS" = 'ug/L' THEN 'µg/L'
            WHEN "UNITS" = '[degF]' THEN '°F'
            WHEN "UNITS" = 'm[IU]/L' THEN 'mIU/L'
            WHEN "UNITS" = '{SG}' THEN NULL
            WHEN "UNITS" = '{T-score}' THEN NULL
            ELSE "UNITS"
        END AS "UNITS",
        "data_type"
    FROM "observations_renamed_dedup"
),

"observations_renamed_dedup_cleaned_casted" AS (
    -- Column Type Casting: 
    -- encounter_id: from VARCHAR to UUID
    -- observation_datetime: from VARCHAR to TIMESTAMP
    -- observation_value: from VARCHAR to DECIMAL
    -- patient_id: from VARCHAR to UUID
    SELECT
        "CATEGORY",
        "observation_code",
        "DESCRIPTION",
        "UNITS",
        "data_type",
        CAST("encounter_id" AS UUID) 
        AS "encounter_id",
        CAST("observation_datetime" AS TIMESTAMP) 
        AS "observation_datetime",
        "observation_value" 
        AS "observation_value",
        CAST("patient_id" AS UUID) 
        AS "patient_id"
    FROM "observations_renamed_dedup_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "observations_renamed_dedup_cleaned_casted"
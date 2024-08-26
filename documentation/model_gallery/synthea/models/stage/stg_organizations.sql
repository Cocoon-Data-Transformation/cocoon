-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-08-24 01:08:13.429847+00:00
WITH 
"organizations_renamed" AS (
    -- Rename: Renaming columns
    -- Id -> organization_id
    -- NAME -> facility_name
    -- ADDRESS -> street_address
    -- LAT -> latitude
    -- LON -> longitude
    -- REVENUE -> revenue
    -- UTILIZATION -> utilization_rate
    SELECT 
        "Id" AS "organization_id",
        "NAME" AS "facility_name",
        "ADDRESS" AS "street_address",
        "CITY",
        "STATE",
        "ZIP",
        "LAT" AS "latitude",
        "LON" AS "longitude",
        "PHONE",
        "REVENUE" AS "revenue",
        "UTILIZATION" AS "utilization_rate"
    FROM "memory"."main"."organizations"
),

"organizations_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- facility_name: The main problems are inconsistent use of 'INC' vs 'INC.', inconsistent spacing before 'LLC', and varying formats for company names. The correct values should use 'INC' without a period, remove extra spaces before 'LLC', and maintain consistent capitalization. Some entries also have typos or unusual abbreviations that need to be corrected.
    -- PHONE: The main problem is inconsistent formatting of phone numbers. Most numbers are either in a single string format (like '4134472000') or have parentheses for the area code (like '(978) 406-1327'). The value '413-731-6000 Or 413-731-6000' is particularly unusual as it repeats the same number and includes the word 'Or'. The correct values should follow the most common format, which appears to be a single string of digits without any separators.
    SELECT
        "organization_id",
        CASE
            WHEN "facility_name" = 'STEWARD GOOD SAMARITAN MEDICAL CENTER  INC.' THEN 'STEWARD GOOD SAMARITAN MEDICAL CENTER INC'
            WHEN "facility_name" = '135 BENTON DRIVE OPERATING COMPANY  LLC' THEN '135 BENTON DRIVE OPERATING COMPANY LLC'
            WHEN "facility_name" = '265 ESSEX STREET OPERATING COMPANY  LLC' THEN '265 ESSEX STREET OPERATING COMPANY LLC'
            WHEN "facility_name" = '4499 ACUSHNET AVENUE OPERATING COMPANY  LLC' THEN '4499 ACUSHNET AVENUE OPERATING COMPANY LLC'
            WHEN "facility_name" = 'ABBOTT HOME HEALTH CARE  INC' THEN 'ABBOTT HOME HEALTH CARE INC'
            WHEN "facility_name" = 'ARBOUR HOSPITAL  THE' THEN 'THE ARBOUR HOSPITAL'
            WHEN "facility_name" = 'ASSOCIATED PHYSICIANS OF HARVARD MEDICAL FACULTY PHYSICIANS AT BETH IS' THEN 'ASSOCIATED PHYSICIANS OF HARVARD MEDICAL FACULTY PHYSICIANS AT BETH ISRAEL'
            WHEN "facility_name" = 'BAYADA HOME HEALTH CARE  INC' THEN 'BAYADA HOME HEALTH CARE INC'
            WHEN "facility_name" = 'BEAR MT EAST LONGMEADOW LLC' THEN 'BEAR MOUNTAIN EAST LONGMEADOW LLC'
            WHEN "facility_name" = 'BEAR MT SPRINGFIELD LLC' THEN 'BEAR MOUNTAIN SPRINGFIELD LLC'
            WHEN "facility_name" = 'BERKSHIRE MEDICAL CENTER INC - 1' THEN 'BERKSHIRE MEDICAL CENTER INC'
            WHEN "facility_name" = 'BL HEALTHCARE INC DELEWARE' THEN 'BL HEALTHCARE INC DELAWARE'
            WHEN "facility_name" = 'BOSTON HOME  INC (THE)' THEN 'THE BOSTON HOME INC'
            WHEN "facility_name" = 'BOSTON MEDICAL CENTER CORPORATION-' THEN 'BOSTON MEDICAL CENTER CORPORATION'
            WHEN "facility_name" = 'BROCKTON HOSPITAL  INC.' THEN 'BROCKTON HOSPITAL INC'
            WHEN "facility_name" = 'CARECENTRAL URGENT CARE MEDICAL GROUP PC' THEN 'CARECENTRAL URGENT CARE MEDICAL GROUP P.C.'
            WHEN "facility_name" = 'CAREWELL URGENT CARE CENTERS OF MA  PC' THEN 'CAREWELL URGENT CARE CENTERS OF MA P.C.'
            WHEN "facility_name" = 'CARING HEALTH CENTER  INC' THEN 'CARING HEALTH CENTER INC'
            WHEN "facility_name" = 'CHARLES RIVER COMMUNITY HEALTH  INC' THEN 'CHARLES RIVER COMMUNITY HEALTH INC'
            WHEN "facility_name" = 'CHELMSFORD FAMILY PRACTICE  PC' THEN 'CHELMSFORD FAMILY PRACTICE P.C.'
            WHEN "facility_name" = 'COMPASSIONATE CARE HOSPICE OF SOUTHEASTERN MASS LL' THEN 'COMPASSIONATE CARE HOSPICE OF SOUTHEASTERN MASS LLC'
            WHEN "facility_name" = 'CONNECTICUT RIVER INTERNISTS. LLP' THEN 'CONNECTICUT RIVER INTERNISTS LLP'
            WHEN "facility_name" = 'DIMOCK COMMUNITY HEALTH CENTER  INC' THEN 'DIMOCK COMMUNITY HEALTH CENTER INC.'
            WHEN "facility_name" = 'DYOUVILLE TRANSITIONAL CARE INC' THEN 'D''YOUVILLE TRANSITIONAL CARE INC.'
            WHEN "facility_name" = 'EDWARD M KENNEDY COMMUNITY HEALTH CENTER INC' THEN 'EDWARD M. KENNEDY COMMUNITY HEALTH CENTER INC.'
            WHEN "facility_name" = 'ENCOMPASS HEALTH BRAINTREE HOSPITAL OF BRAINTREE' THEN 'ENCOMPASS HEALTH HOSPITAL OF BRAINTREE'
            WHEN "facility_name" = 'ENCOMPASS HEALTH REHAB HOSPITAL OF WESTERN MASS' THEN 'ENCOMPASS HEALTH REHAB HOSPITAL OF WESTERN MASS.'
            WHEN "facility_name" = 'EXCEL HOME CARE SERVICES INC' THEN 'EXCEL HOME CARE SERVICES INC.'
            WHEN "facility_name" = 'FALMOUTH HOSPITAL ASSOCIATION INC' THEN 'FALMOUTH HOSPITAL ASSOCIATION INC.'
            WHEN "facility_name" = 'FRANCISCAN HOSPITAL FOR CHILDREN INC' THEN 'FRANCISCAN HOSPITAL FOR CHILDREN INC.'
            WHEN "facility_name" = 'Fitchburg Outpatient Clinic' THEN 'FITCHBURG OUTPATIENT CLINIC'
            WHEN "facility_name" = 'HOLYOKE HEALTH CENTER INC' THEN 'HOLYOKE HEALTH CENTER INC.'
            WHEN "facility_name" = 'HOLYOKE MEDICAL CENTER INC' THEN 'HOLYOKE MEDICAL CENTER INC.'
            WHEN "facility_name" = 'LAHEY HOSPITAL & MEDICAL CENTER  BURLINGTON' THEN 'LAHEY HOSPITAL & MEDICAL CENTER BURLINGTON'
            WHEN "facility_name" = 'LIGHTHOUSE OF REVERE  INC.' THEN 'LIGHTHOUSE OF REVERE INC.'
            WHEN "facility_name" = 'LUTHERAN HOME OF JAMAICA PLAIN INC' THEN 'LUTHERAN HOME OF JAMAICA PLAIN INC.'
            WHEN "facility_name" = 'MELROSEWAKEFIELD HEALTHCARE  INC' THEN 'MELROSEWAKEFIELD HEALTHCARE, INC.'
            WHEN "facility_name" = 'MIDDLESEX INTERNAL MEDICINE ASSOCIATES  INC' THEN 'MIDDLESEX INTERNAL MEDICINE ASSOCIATES, INC.'
            WHEN "facility_name" = 'MORTON HOSPITAL  A STEWARD FAMILY HOSPITAL  INC.' THEN 'MORTON HOSPITAL, A STEWARD FAMILY HOSPITAL, INC.'
            WHEN "facility_name" = 'NEW BEDFORD INTERNAL MEDICINE & GERIATRICS  LLC' THEN 'NEW BEDFORD INTERNAL MEDICINE & GERIATRICS, LLC'
            WHEN "facility_name" = 'NEW ENGLAND FAMILY HEALTH LLC' THEN 'NEW ENGLAND FAMILY HEALTH, LLC'
            WHEN "facility_name" = 'NEW ENGLAND PROFESSIONAL HOME HEALTH CARE LLC' THEN 'NEW ENGLAND PROFESSIONAL HOME HEALTH CARE, LLC'
            WHEN "facility_name" = 'NORTH ADAMS COMMONS NURSING & REHABILITATION CENTE' THEN 'NORTH ADAMS COMMONS NURSING & REHABILITATION CENTER'
            WHEN "facility_name" = 'NORTH RIVER HOSPICE LLC' THEN 'NORTH RIVER HOSPICE, LLC'
            WHEN "facility_name" = 'NORTH SHORE MEDICAL CENTER INC' THEN 'NORTH SHORE MEDICAL CENTER, INC.'
            WHEN "facility_name" = 'OAKS  THE' THEN 'THE OAKS'
            WHEN "facility_name" = 'PALM SKILLED  NRSING CR & CTR FOR REHAB EXCELLENCE' THEN 'PALM SKILLED NURSING CARE & CENTER FOR REHAB EXCELLENCE'
            WHEN "facility_name" = 'PRIMARY & PREVENTIVE CARE  INC.' THEN 'PRIMARY & PREVENTIVE CARE, INC.'
            WHEN "facility_name" = 'Plymouth Outreach Clinic' THEN 'PLYMOUTH OUTREACH CLINIC'
            WHEN "facility_name" = 'QUINCY HEALTH AND REHABILITATION CENTER LLC' THEN 'QUINCY HEALTH AND REHABILITATION CENTER, LLC'
            WHEN "facility_name" = 'RIVER''S EDGE PRIMARY CARE LLC' THEN 'RIVER''S EDGE PRIMARY CARE, LLC'
            WHEN "facility_name" = 'ROYAL NORWELL NURSING & REHABILITATION CENTER LLC' THEN 'ROYAL NORWELL NURSING & REHABILITATION CENTER, LLC'
            WHEN "facility_name" = 'SEASONS HOSPICE & PALLIATIVE CARE OF MASS LLC' THEN 'SEASONS HOSPICE & PALLIATIVE CARE OF MASS, LLC'
            WHEN "facility_name" = 'SOUTH SHORE MEDICAL INVESTORS LLC' THEN 'SOUTH SHORE MEDICAL INVESTORS, LLC'
            WHEN "facility_name" = 'SOUTH SHORE PRIMARY AND URGENT CARE LLC' THEN 'SOUTH SHORE PRIMARY AND URGENT CARE, LLC'
            WHEN "facility_name" = 'SOUTHWOOD AT NORWELL NURSING CTR' THEN 'SOUTHWOOD AT NORWELL NURSING CENTER'
            WHEN "facility_name" = 'SUN MEDICAL CLINIC  PC' THEN 'SUN MEDICAL CLINIC, PC'
            WHEN "facility_name" = 'Springfield Outpatient Clinic' THEN 'SPRINGFIELD OUTPATIENT CLINIC'
            WHEN "facility_name" = 'TAUNTON MEDICAL CENTER  PC' THEN 'TAUNTON MEDICAL CENTER, PC'
            WHEN "facility_name" = 'TUFTS MEDICAL CENTER  INC' THEN 'TUFTS MEDICAL CENTER INC'
            WHEN "facility_name" = 'URGENT CARE MEDICAL ASSOCIATES  LLC' THEN 'URGENT CARE MEDICAL ASSOCIATES LLC'
            WHEN "facility_name" = 'URGENT CARE SPECIALISTS  P.C.' THEN 'URGENT CARE SPECIALISTS PC'
            WHEN "facility_name" = 'VIGILANT FAMILY HEALTH CLINIC  INC.' THEN 'VIGILANT FAMILY HEALTH CLINIC INC'
            WHEN "facility_name" = 'WESTBOROUGH BEHAVIORAL HEALTHCARE HOSPITAL  LLC' THEN 'WESTBOROUGH BEHAVIORAL HEALTHCARE HOSPITAL LLC'
            WHEN "facility_name" = 'WORCESTER INTERNAL MEDICINE  INC.' THEN 'WORCESTER INTERNAL MEDICINE INC'
            ELSE "facility_name"
        END AS "facility_name",
        "street_address",
        "CITY",
        "STATE",
        "ZIP",
        "latitude",
        "longitude",
        CASE
            WHEN "PHONE" = '(978) 406-1327' THEN '9784061327'
            WHEN "PHONE" = '413-731-6000 Or 413-731-6000' THEN '4137316000'
            WHEN "PHONE" = '978-342-9781 Or 978-342-9781' THEN '9783429781'
            WHEN "PHONE" = '800-865-3384' THEN '8008653384'
            ELSE "PHONE"
        END AS "PHONE",
        "revenue",
        "utilization_rate"
    FROM "organizations_renamed"
),

"organizations_renamed_cleaned_casted" AS (
    -- Column Type Casting: 
    -- ZIP: from INT to VARCHAR
    -- organization_id: from VARCHAR to UUID
    SELECT
        "facility_name",
        "street_address",
        "CITY",
        "STATE",
        "latitude",
        "longitude",
        "PHONE",
        "revenue",
        "utilization_rate",
        CAST("ZIP" AS VARCHAR) 
        AS "ZIP",
        CAST("organization_id" AS UUID) 
        AS "organization_id"
    FROM "organizations_renamed_cleaned"
)

-- COCOON BLOCK END
SELECT *
FROM "organizations_renamed_cleaned_casted"
-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
WITH 
"cost_renamed" AS (
    -- Rename: Renaming columns
    -- amount_allowed -> allowed_amount
    -- paid_by_payer -> insurance_payment
    -- paid_by_patient -> patient_payment
    -- paid_patient_copay -> patient_copay
    -- paid_patient_coinsurance -> patient_coinsurance
    -- paid_patient_deductible -> patient_deductible
    -- paid_by_primary -> primary_insurance_payment
    -- paid_ingredient_cost -> ingredient_cost
    -- paid_dispensing_fee -> dispensing_fee
    SELECT 
        "cost_id",
        "person_id",
        "total_charge",
        "total_paid",
        "amount_allowed" AS "allowed_amount",
        "paid_by_payer" AS "insurance_payment",
        "paid_by_patient" AS "patient_payment",
        "paid_patient_copay" AS "patient_copay",
        "paid_patient_coinsurance" AS "patient_coinsurance",
        "paid_patient_deductible" AS "patient_deductible",
        "paid_by_primary" AS "primary_insurance_payment",
        "paid_ingredient_cost" AS "ingredient_cost",
        "paid_dispensing_fee" AS "dispensing_fee"
    FROM "cost"
)

-- COCOON BLOCK END
SELECT * FROM "cost_renamed"
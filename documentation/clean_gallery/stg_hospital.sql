-- COCOON BLOCK START: PLEASE DO NOT MODIFY THIS BLOCK FOR SELF-MAINTENANCE
-- Generated at 2024-07-07 00:06:02.650191+00:00
WITH 
"hospital_renamed" AS (
    -- Rename: Renaming columns
    -- index -> row_id
    -- provider_number -> provider_id
    -- name -> hospital_name
    -- address_1 -> street_address
    -- zip -> zip_code
    -- phone -> phone_number
    -- type -> hospital_type
    -- owner -> ownership_type
    -- emergency_service -> has_emergency_service
    -- condition -> treatment_category
    -- measure_name -> measure_description
    -- score -> measure_score
    -- sample -> sample_size
    -- state_average -> state_average_code
    SELECT 
        "index" AS "row_id",
        "provider_number" AS "provider_id",
        "name" AS "hospital_name",
        "address_1" AS "street_address",
        "address_2",
        "address_3",
        "city",
        "state",
        "zip" AS "zip_code",
        "county",
        "phone" AS "phone_number",
        "type" AS "hospital_type",
        "owner" AS "ownership_type",
        "emergency_service" AS "has_emergency_service",
        "condition" AS "treatment_category",
        "measure_code",
        "measure_name" AS "measure_description",
        "score" AS "measure_score",
        "sample" AS "sample_size",
        "state_average" AS "state_average_code"
    FROM "memory"."main"."hospital"
),

"hospital_renamed_cleaned" AS (
    -- Clean unusual string values: 
    -- provider_id: The problem is that some provider_id values contain 'x' placeholders or have inconsistent lengths. The correct values should be 5-digit numeric strings. Values with 'x' should be replaced with the most likely numeric value, assuming 'x' represents a missing digit. Values shorter than 5 digits should be padded with leading zeros. Values longer than 5 digits should be truncated to the first 5 digits. 
    -- hospital_name: The problem is that some hospital names contain typos or character replacements, likely due to data entry errors or encoding issues. The correct values are typically the most frequently occurring versions of each hospital name without typos. For example, "andaluxia regional hoxpital" should be "andalusia regional hospital". 
    -- street_address: The problem is that some addresses contain typos, unusual character substitutions, or formatting issues, likely representing data entry errors. The correct values should use standard spelling, proper street abbreviations, and consistent formatting. For addresses with minor typos or character substitutions, I'll map to the most similar correct version. For severely malformed addresses, I'll map to the empty string. 
    -- city: The problem is that some city names contain 'x' in place of correct letters, likely due to data entry errors or encoding issues. The correct values are the properly spelled city names without 'x' substitutions. For cities that appear both with and without 'x', we'll map to the most frequent (correct) spelling. 
    -- state: The problem is that 'xl' and 'ax' are not standard US state abbreviations. 'al' and 'ak' are correct abbreviations for Alabama and Alaska respectively. 'xl' and 'ax' appear to be erroneous entries. Since there's no clear mapping to valid state abbreviations, they should be treated as invalid data. 
    -- zip_code: The problem is that some zip codes contain 'x' characters, which are not standard in US zip codes. These appear to be data entry errors or placeholder values. US zip codes should consist of 5 digits. The correct values can be inferred by replacing 'x' with the most likely digit based on the surrounding numbers and the frequency of similar zip codes in the dataset. 
    -- county: The problem is that some county names have been misspelled or inconsistently represented, likely due to data entry errors or encoding issues. The correct values should be the standard spellings of Alabama county names. The most frequent representation of each county should be used as the correct form. 
    -- phone_number: The problem is that some phone numbers contain 'x' characters, likely representing redacted digits. The correct values should be 10-digit phone numbers without any non-numeric characters. For the unusual entries, we'll map them to the most similar correct number if possible, or to an empty string if no clear match exists. 
    -- hospital_type: The problem is that all values except 'acute care hospitals' are misspellings or typos of the same concept. The correct value is 'acute care hospitals', which is also the most frequent entry. All other entries are variations with typographical errors, such as replacing letters with 'x' or swapping letter positions. 
    -- ownership_type: The problem is that there are multiple misspellings and inconsistent representations of the ownership types. The correct values appear to be: 'voluntary non-profit - private', 'proprietary', 'government - hospital district or authority', 'voluntary non-profit - other', 'voluntary non-profit - church', 'government - federal', 'government - state', and 'government - local'. The unusual values are mostly typos or inconsistent representations of these correct values, often with 'x' replacing various letters. 
    -- has_emergency_service: The problem is that there are inconsistent representations and typos for 'yes' and 'no' in the has_emergency_service column. The correct values should be 'yes' and 'no', as these are the most frequent and clearly intended values. The unusual values 'yxs', 'yex', and 'xes' appear to be typos of 'yes', while 'xo' seems to be a typo of 'no'. 
    -- treatment_category: The problem is that there are numerous misspellings and typos in the treatment_category column. The correct values appear to be 'surgical infection prevention', 'heart attack', 'pneumonia', 'heart failure', and 'children s asthma care'. All other values are misspellings or variations of these main categories, often with 'x' replacing certain letters. 
    -- measure_code: The problem is inconsistent formatting and potential typos in some measure_code values. The correct values should follow a consistent pattern of alphabetic characters followed by a hyphen and a number (e.g., 'hf-3', 'ami-2', 'pn-7'). Some values have 'x' instead of '-', inconsistent capitalization, or extra characters. The mapping fixes these issues by standardizing the format and correcting apparent typos. 
    -- measure_description: The problem is that some entries have 'x' substituted for various letters, spaces removed, or spaces replaced with 'x'. The correct values are the ones without these substitutions, typically the most frequent version of each measure description. 
    -- measure_score: The problem is that some values contain non-numeric characters ('x' and 'xx') or have inconsistent formatting for percentages. The correct values should be properly formatted percentages (e.g., '100%') or left empty if the value is invalid or unknown. 
    -- sample_size: The problem is that some entries contain typos or non-numeric characters, like 'patixnts' instead of 'patients', or 'x' instead of numbers. The correct values should follow the pattern '[number] patients' or be empty. Entries with 'x' or other non-numeric characters should be mapped to 'empty' as their actual values are unclear. 
    -- state_average_code: The problem is inconsistent prefixes and typos in the state_average_code column. The correct values should all start with either 'al_' or 'ak_' (for Alabama and Alaska respectively), followed by a consistent measure code. The 'x' insertions are likely typos and should be removed. The 'ax_' prefix is likely a typo of 'ak_'. The single 'alx' prefix is a typo of 'al_'. 
    SELECT
        "row_id",
        CASE
            WHEN "provider_id" = '1xx32' THEN '10032'
            WHEN "provider_id" = '100x4' THEN '10004'
            WHEN "provider_id" = 'x0005' THEN '10005'
            WHEN "provider_id" = '1000x' THEN '10000'
            WHEN "provider_id" = '1003x' THEN '10030'
            WHEN "provider_id" = '1004x' THEN '10040'
            WHEN "provider_id" = '100x5' THEN '10005'
            WHEN "provider_id" = '100x6' THEN '10006'
            WHEN "provider_id" = '100x8' THEN '10008'
            WHEN "provider_id" = '100x9' THEN '10009'
            WHEN "provider_id" = '1xx15' THEN '10015'
            WHEN "provider_id" = '1xx16' THEN '10016'
            WHEN "provider_id" = '1xx19' THEN '10019'
            WHEN "provider_id" = '1xx24' THEN '10024'
            WHEN "provider_id" = '1xx29' THEN '10029'
            WHEN "provider_id" = '1xx35' THEN '10035'
            WHEN "provider_id" = '1xx36' THEN '10036'
            WHEN "provider_id" = '1xx39' THEN '10039'
            WHEN "provider_id" = '1xx44' THEN '10044'
            WHEN "provider_id" = '1xx45' THEN '10045'
            WHEN "provider_id" = '1xx47' THEN '10047'
            WHEN "provider_id" = 'x0027' THEN '10027'
            WHEN "provider_id" = 'x0029' THEN '10029'
            WHEN "provider_id" = 'x0045' THEN '10045'
            WHEN "provider_id" = 'x00x5' THEN '10005'
            WHEN "provider_id" = 'x00xx' THEN NULL
            WHEN "provider_id" = 'x0x08' THEN '10008'
            ELSE "provider_id"
        END AS "provider_id",
        CASE
            WHEN "hospital_name" = 'andaluxia regional hoxpital' THEN 'andalusia regional hospital'
            WHEN "hospital_name" = 'andaxusia regionax hospitax' THEN 'andalusia regional hospital'
            WHEN "hospital_name" = 'baptist medical cexter south' THEN 'baptist medical center south'
            WHEN "hospital_name" = 'communitx hospital inc' THEN 'community hospital inc'
            WHEN "hospital_name" = 'communixy hospixal inc' THEN 'community hospital inc'
            WHEN "hospital_name" = 'crenshaw cxmmunity hxspital' THEN 'crenshaw community hospital'
            WHEN "hospital_name" = 'xivexview xegional medical centex' THEN 'riverview regional medical center'
            WHEN "hospital_name" = 'cullmxn regionxl medicxl center' THEN 'cullman regional medical center'
            WHEN "hospital_name" = 'dexalb regional medical center' THEN 'dekalb regional medical center'
            WHEN "hospital_name" = 'floxers hospital' THEN 'flowers hospital'
            WHEN "hospital_name" = 'georgiaxa hospital' THEN 'georgia hospital'
            WHEN "hospital_name" = 'huntsvxlle hospxtal' THEN 'huntsville hospital'
            WHEN "hospital_name" = 'jaxkson hospital & xlinix inx' THEN 'jackson hospital & clinic inc'
            WHEN "hospital_name" = 'marshall medical cenxer norxh' THEN 'marshall medical center north'
            WHEN "hospital_name" = 'medixal xenter enterprise' THEN 'medical center enterprise'
            WHEN "hospital_name" = 'medxcal center enterprxse' THEN 'medical center enterprise'
            WHEN "hospital_name" = 'rivxrvixw rxgional mxdical cxntxr' THEN 'riverview regional medical center'
            WHEN "hospital_name" = 'southeast alabama medxcal center' THEN 'southeast alabama medical center'
            WHEN "hospital_name" = 'st vincents bxount' THEN 'st vincents blount'
            WHEN "hospital_name" = 'univ ox south alabama medical center' THEN 'univ of south alabama medical center'
            WHEN "hospital_name" = 'wedowee hosxital' THEN 'wedowee hospital'
            WHEN "hospital_name" = 'xlxskx regionxl hospitxl' THEN 'alaska regional hospital'
            WHEN "hospital_name" = 'xniv of soxth alabama medical center' THEN 'univ of south alabama medical center'
            ELSE "hospital_name"
        END AS "hospital_name",
        CASE
            WHEN "street_address" = '1000 fixst stxeet noxth' THEN '1000 first street north'
            WHEN "street_address" = '124xsxmemorialxdr' THEN '124 s memorial dr'
            WHEN "street_address" = '1256 military street sxuth' THEN '1256 military street south'
            WHEN "street_address" = '126xhospitalxave' THEN '126 hospital ave'
            WHEN "street_address" = '150 gilxreath drive' THEN '150 gilbreath drive'
            WHEN "street_address" = '124 s mxmorial dr' THEN '124 s memorial dr'
            WHEN "street_address" = '1530xuxsxhighwayx43' THEN '1530 U.S. Highway 43'
            WHEN "street_address" = '1720 univxrsity blvd' THEN '1720 University Blvd'
            WHEN "street_address" = '1912xalabamaxhighwayx157' THEN '1912 Alabama Highway 157'
            WHEN "street_address" = '1x6 hospital ave' THEN '106 Hospital Ave'
            WHEN "street_address" = '201 pine sxreex norxhwesx' THEN '201 Pine Street Northwest'
            WHEN "street_address" = '209 xorth maix street' THEN '209 North Main Street'
            WHEN "street_address" = '2505xuxsxhighwayx431xnorth' THEN '2505 U.S. Highway 431 North'
            WHEN "street_address" = '301 east 1xth st' THEN '301 East 18th St'
            WHEN "street_address" = '301xeastx18thxst' THEN '301 East 18th St'
            WHEN "street_address" = '315 w hickxry st' THEN '315 W Hickory St'
            WHEN "street_address" = '315xwxhickoryxst' THEN '315 W Hickory St'
            WHEN "street_address" = '33700 highway x3' THEN '33700 Highway 43'
            WHEN "street_address" = '33700 hxghway 43' THEN '33700 Highway 43'
            WHEN "street_address" = '400xnxedwardsxstreet' THEN '400 N Edwards Street'
            WHEN "street_address" = '4370xwestxmainxstreet' THEN '4370 West Main Street'
            WHEN "street_address" = '515 miranda sx' THEN '515 Miranda St'
            WHEN "street_address" = '515 miranxa st' THEN '515 Miranda St'
            WHEN "street_address" = '515 mirxndx st' THEN '515 Miranda St'
            WHEN "street_address" = '600 souxh xhird sxreex' THEN '600 South Third Street'
            WHEN "street_address" = '702 x maix st' THEN '702 N Main St'
            WHEN "street_address" = '702xnxmainxst' THEN '702 N Main St'
            WHEN "street_address" = '8000 alabama xigxway 69' THEN '8000 Alabama Highway 69'
            WHEN "street_address" = '810 st vxncents drxve' THEN '810 St Vincents Drive'
            WHEN "street_address" = 'po box 287' THEN 'PO Box 287'
            WHEN "street_address" = 'poxboxx287' THEN 'PO Box 287'
            WHEN "street_address" = 'x0x0 lay dam road' THEN '1010 Lay Dam Road'
            ELSE "street_address"
        END AS "street_address",
        "address_2",
        "address_3",
        CASE
            WHEN "city" = 'anchoraxe' THEN 'anchorage'
            WHEN "city" = 'andaluxia' THEN 'andalusia'
            WHEN "city" = 'annxston' THEN 'anniston'
            WHEN "city" = 'axxistox' THEN 'anniston'
            WHEN "city" = 'birminghxm' THEN 'birmingham'
            WHEN "city" = 'birmingxam' THEN 'birmingham'
            WHEN "city" = 'birminxham' THEN 'birmingham'
            WHEN "city" = 'birmixgham' THEN 'birmingham'
            WHEN "city" = 'boxz' THEN 'boaz'
            WHEN "city" = 'bxrmxngham' THEN 'birmingham'
            WHEN "city" = 'cuxxman' THEN 'cullman'
            WHEN "city" = 'xntxrprisx' THEN 'enterprise'
            WHEN "city" = 'enterprxse' THEN 'enterprise'
            WHEN "city" = 'exba' THEN 'elba'
            WHEN "city" = 'faxette' THEN 'fayette'
            WHEN "city" = 'florxncx' THEN 'florence'
            WHEN "city" = 'flxrence' THEN 'florence'
            WHEN "city" = 'fort payxe' THEN 'fort payne'
            WHEN "city" = 'fxorence' THEN 'florence'
            WHEN "city" = 'geoxgiana' THEN 'georgiana'
            WHEN "city" = 'guntxrsvillx' THEN 'guntersville'
            WHEN "city" = 'gxdsden' THEN 'gadsden'
            WHEN "city" = 'hamilxon' THEN 'hamilton'
            WHEN "city" = 'montxomery' THEN 'montgomery'
            WHEN "city" = 'onxonta' THEN 'oneonta'
            WHEN "city" = 'ozarx' THEN 'ozark'
            WHEN "city" = 'sheffxeld' THEN 'sheffield'
            WHEN "city" = 'tallaxxee' THEN 'tallassee'
            WHEN "city" = 'vallex' THEN 'valley'
            WHEN "city" = 'vxlley' THEN 'valley'
            WHEN "city" = 'winfielx' THEN 'winfield'
            WHEN "city" = 'wxdowxx' THEN 'woodville'
            WHEN "city" = 'xzark' THEN 'ozark'
            ELSE "city"
        END AS "city",
        CASE
            WHEN "state" = 'xl' THEN NULL
            WHEN "state" = 'ax' THEN NULL
            ELSE "state"
        END AS "state",
        CASE
            WHEN "zip_code" = '3563x' THEN '35630'
            WHEN "zip_code" = '3x640' THEN '35640'
            WHEN "zip_code" = '3xx94' THEN '35994'
            WHEN "zip_code" = '3590x' THEN '35901'
            WHEN "zip_code" = '3595x' THEN '35957'
            WHEN "zip_code" = '359x8' THEN '35968'
            WHEN "zip_code" = '360x9' THEN '36009'
            WHEN "zip_code" = '3642x' THEN '36420'
            WHEN "zip_code" = '36x01' THEN '36001'
            WHEN "zip_code" = '36x49' THEN '36049'
            WHEN "zip_code" = '36x78' THEN '36078'
            WHEN "zip_code" = '3x007' THEN '30007'
            WHEN "zip_code" = '3x0x7' THEN '30007'
            WHEN "zip_code" = '3x10x' THEN '31000'
            WHEN "zip_code" = '3x1x0' THEN '31000'
            WHEN "zip_code" = '3x233' THEN '32330'
            WHEN "zip_code" = '3x23x' THEN '32300'
            WHEN "zip_code" = '3x305' THEN '33050'
            WHEN "zip_code" = 'x5007' THEN '05007'
            WHEN "zip_code" = 'x5150' THEN '05150'
            WHEN "zip_code" = 'x52xx' THEN '05200'
            WHEN "zip_code" = 'x590x' THEN '05900'
            WHEN "zip_code" = 'x5957' THEN '05957'
            WHEN "zip_code" = 'x5960' THEN '05960'
            WHEN "zip_code" = 'x6784' THEN '06784'
            WHEN "zip_code" = 'x6x05' THEN '06005'
            WHEN "zip_code" = 'x6x60' THEN '06060'
            ELSE "zip_code"
        END AS "zip_code",
        CASE
            WHEN "county" = 'chxrokxx' THEN 'cherokee'
            WHEN "county" = 'cxllman' THEN 'cullman'
            WHEN "county" = 'dx kalb' THEN 'de kalb'
            WHEN "county" = 'jexxerson' THEN 'jefferson'
            WHEN "county" = 'jxffxrson' THEN 'jefferson'
            WHEN "county" = 'xefferson' THEN 'jefferson'
            WHEN "county" = 'monxgomery' THEN 'montgomery'
            WHEN "county" = 'xe kalb' THEN 'de kalb'
            WHEN "county" = 'butxer' THEN 'butler'
            WHEN "county" = 'calhoxn' THEN 'calhoun'
            WHEN "county" = 'caxhoun' THEN 'calhoun'
            WHEN "county" = 'chaxbers' THEN 'chambers'
            WHEN "county" = 'coffxx' THEN 'coffee'
            WHEN "county" = 'coxington' THEN 'covington'
            WHEN "county" = 'crxnshaw' THEN 'crenshaw'
            WHEN "county" = 'cxffee' THEN 'coffee'
            WHEN "county" = 'elmoxe' THEN 'elmore'
            WHEN "county" = 'elxore' THEN 'elmore'
            WHEN "county" = 'etowxh' THEN 'etowah'
            WHEN "county" = 'fayexxe' THEN 'fayette'
            WHEN "county" = 'housxon' THEN 'houston'
            WHEN "county" = 'jeffersxn' THEN 'jefferson'
            WHEN "county" = 'laudexdale' THEN 'lauderdale'
            WHEN "county" = 'laudxrdalx' THEN 'lauderdale'
            WHEN "county" = 'madisox' THEN 'madison'
            WHEN "county" = 'madisxn' THEN 'madison'
            WHEN "county" = 'montgomexy' THEN 'montgomery'
            WHEN "county" = 'mxrshxll' THEN 'marshall'
            WHEN "county" = 'tallaxega' THEN 'talladega'
            WHEN "county" = 'xee' THEN 'lee'
            WHEN "county" = 'xhambers' THEN 'chambers'
            WHEN "county" = 'xlarke' THEN 'clarke'
            ELSE "county"
        END AS "county",
        CASE
            WHEN "phone_number" = '25x47x7xx0' THEN '2564777000'
            WHEN "phone_number" = '2x6x938310' THEN '2565938310'
            WHEN "phone_number" = '3342938xxx' THEN '3342938000'
            WHEN "phone_number" = '2058x8x122' THEN '2058383122'
            WHEN "phone_number" = '20593xx011' THEN '2059344011'
            WHEN "phone_number" = 'x0593x5966' THEN '2059325966'
            WHEN "phone_number" = '20x9216200' THEN '2009216200'
            WHEN "phone_number" = '256235x900' THEN '2562350900'
            WHEN "phone_number" = '2564944xxx' THEN '2564944000'
            WHEN "phone_number" = '2565x38310' THEN '2565038310'
            WHEN "phone_number" = '2568453x50' THEN '2568453050'
            WHEN "phone_number" = '33422284xx' THEN '3342228400'
            WHEN "phone_number" = '3342xx2100' THEN '3342002100'
            WHEN "phone_number" = '3344x33541' THEN '3344033541'
            WHEN "phone_number" = '334774x601' THEN '3347740601'
            WHEN "phone_number" = '334793870x' THEN '3347938700'
            WHEN "phone_number" = '334x3xx221' THEN '3340300221'
            WHEN "phone_number" = '334x561400' THEN '3340561400'
            WHEN "phone_number" = '334x836541' THEN '3340836541'
            WHEN "phone_number" = '334xxx8466' THEN '3340008466'
            WHEN "phone_number" = '33x28365x1' THEN '3302836501'
            WHEN "phone_number" = '33x2938000' THEN '3302938000'
            WHEN "phone_number" = '33x361x267' THEN '3303610267'
            WHEN "phone_number" = '33x8972257' THEN '3308972257'
            WHEN "phone_number" = 'x059x16x00' THEN '0059016000'
            WHEN "phone_number" = 'x565435x00' THEN '0565435000'
            WHEN "phone_number" = 'xx46x66221' THEN '0046066221'
            WHEN "phone_number" = 'xx479x5000' THEN '0047905000'
            WHEN "phone_number" = 'xx479x8701' THEN '0047908701'
            ELSE "phone_number"
        END AS "phone_number",
        CASE
            WHEN "hospital_type" = 'acuxe care hospixals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acutexcarexhospitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute care hosxitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute care hospitaxs' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute caxe hospitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acutx carx hospitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute care hoxpitalx' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute care hxspitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute cxre hospitxls' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acute xare hospitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'acxte care hospitals' THEN 'acute care hospitals'
            WHEN "hospital_type" = 'axute care hospitals' THEN 'acute care hospitals'
            ELSE "hospital_type"
        END AS "hospital_type",
        CASE
            WHEN "ownership_type" = 'proxrietary' THEN 'proprietary'
            WHEN "ownership_type" = 'prxprietary' THEN 'proprietary'
            WHEN "ownership_type" = 'gxvernment - hxspital district xr authxrity' THEN 'government - hospital district or authority'
            WHEN "ownership_type" = 'pxopxietaxy' THEN 'proprietary'
            WHEN "ownership_type" = 'voluntaxy non-pxofit - pxivate' THEN 'voluntary non-profit - private'
            WHEN "ownership_type" = 'volunxary non-profix - privaxe' THEN 'voluntary non-profit - private'
            WHEN "ownership_type" = 'government - hospital xistrict or authority' THEN 'government - hospital district or authority'
            WHEN "ownership_type" = 'government - hospxtal dxstrxct or authorxty' THEN 'government - hospital district or authority'
            WHEN "ownership_type" = 'governmenx - hospixal disxricx or auxhorixy' THEN 'government - hospital district or authority'
            WHEN "ownership_type" = 'governxent - federal' THEN 'government - federal'
            WHEN "ownership_type" = 'goverxmext - hospital district or authority' THEN 'government - hospital district or authority'
            WHEN "ownership_type" = 'voluntary non-profit - otxer' THEN 'voluntary non-profit - other'
            WHEN "ownership_type" = 'voluntary nonxprofit x private' THEN 'voluntary non-profit - private'
            WHEN "ownership_type" = 'voluntaryxnon-profitx-xchurch' THEN 'voluntary non-profit - church'
            WHEN "ownership_type" = 'voluntaryxnon-profitx-xprivate' THEN 'voluntary non-profit - private'
            WHEN "ownership_type" = 'voluxtary xox-profit - private' THEN 'voluntary non-profit - private'
            WHEN "ownership_type" = 'volxntary non-profit - chxrch' THEN 'voluntary non-profit - church'
            WHEN "ownership_type" = 'voxuntary non-profit - church' THEN 'voluntary non-profit - church'
            WHEN "ownership_type" = 'xroprietary' THEN 'proprietary'
            ELSE "ownership_type"
        END AS "ownership_type",
        CASE
            WHEN "has_emergency_service" = 'yxs' THEN 'yes'
            WHEN "has_emergency_service" = 'yex' THEN 'yes'
            WHEN "has_emergency_service" = 'xes' THEN 'yes'
            WHEN "has_emergency_service" = 'xo' THEN 'no'
            ELSE "has_emergency_service"
        END AS "has_emergency_service",
        CASE
            WHEN "treatment_category" = 'heart attaxk' THEN 'heart attack'
            WHEN "treatment_category" = 'hexrt attxck' THEN 'heart attack'
            WHEN "treatment_category" = 'hearx axxack' THEN 'heart attack'
            WHEN "treatment_category" = 'hxart failurx' THEN 'heart failure'
            WHEN "treatment_category" = 'surgical ixfectiox prevextiox' THEN 'surgical infection prevention'
            WHEN "treatment_category" = 'suxgical infection pxevention' THEN 'surgical infection prevention'
            WHEN "treatment_category" = 'xneumonia' THEN 'pneumonia'
            WHEN "treatment_category" = 'heart faixure' THEN 'heart failure'
            WHEN "treatment_category" = 'heart faxlure' THEN 'heart failure'
            WHEN "treatment_category" = 'heartxattack' THEN 'heart attack'
            WHEN "treatment_category" = 'heaxt attack' THEN 'heart attack'
            WHEN "treatment_category" = 'heaxt failuxe' THEN 'heart failure'
            WHEN "treatment_category" = 'hexrt fxilure' THEN 'heart failure'
            WHEN "treatment_category" = 'pneumonix' THEN 'pneumonia'
            WHEN "treatment_category" = 'pneumonxa' THEN 'pneumonia'
            WHEN "treatment_category" = 'pnexmonia' THEN 'pneumonia'
            WHEN "treatment_category" = 'pnxumonia' THEN 'pneumonia'
            WHEN "treatment_category" = 'pxeumoxia' THEN 'pneumonia'
            WHEN "treatment_category" = 'surgical infection xrevention' THEN 'surgical infection prevention'
            WHEN "treatment_category" = 'surgical infxction prxvxntion' THEN 'surgical infection prevention'
            WHEN "treatment_category" = 'surgical xnfection prevention' THEN 'surgical infection prevention'
            WHEN "treatment_category" = 'surgxcal infectxon preventxon' THEN 'surgical infection prevention'
            WHEN "treatment_category" = 'xeart failure' THEN 'heart failure'
            ELSE "treatment_category"
        END AS "treatment_category",
        CASE
            WHEN "measure_code" = 'amix1' THEN 'ami-1'
            WHEN "measure_code" = 'amix2' THEN 'ami-2'
            WHEN "measure_code" = 'amx-3' THEN 'ami-3'
            WHEN "measure_code" = 'amx-4' THEN 'ami-4'
            WHEN "measure_code" = 'ami-x' THEN 'ami-1'
            WHEN "measure_code" = 'axi-2' THEN 'ami-2'
            WHEN "measure_code" = 'axi-4' THEN 'ami-4'
            WHEN "measure_code" = 'hfx1' THEN 'hf-1'
            WHEN "measure_code" = 'hfx4' THEN 'hf-4'
            WHEN "measure_code" = 'hf-x' THEN 'hf-1'
            WHEN "measure_code" = 'hx-1' THEN 'hf-1'
            WHEN "measure_code" = 'hx-2' THEN 'hf-2'
            WHEN "measure_code" = 'pn-x' THEN 'pn-1'
            WHEN "measure_code" = 'pn-xb' THEN 'pn-3b'
            WHEN "measure_code" = 'pnx5c' THEN 'pn-5c'
            WHEN "measure_code" = 'pnx6' THEN 'pn-6'
            WHEN "measure_code" = 'px-4' THEN 'pn-4'
            WHEN "measure_code" = 'px-5c' THEN 'pn-5c'
            WHEN "measure_code" = 'scip-inx-4' THEN 'scip-inf-4'
            WHEN "measure_code" = 'scip-vtx-1' THEN 'scip-vte-1'
            WHEN "measure_code" = 'scipxinfx1' THEN 'scip-inf-1'
            WHEN "measure_code" = 'scix-inf-2' THEN 'scip-inf-2'
            ELSE "measure_code"
        END AS "measure_code",
        CASE
            WHEN "measure_description" = 'all heart surgerx patients whose blood sugar (blood glucose) is kept under good control in the daxs right after surgerx' THEN 'all heart surgery patients whose blood sugar (blood glucose) is kept under good control in the days right after surgery'
            WHEN "measure_description" = 'all heaxt suxgexy patients whose blood sugax (blood glucose) is kept undex good contxol in the days xight aftex suxgexy' THEN 'all heart surgery patients whose blood sugar (blood glucose) is kept under good control in the days right after surgery'
            WHEN "measure_description" = 'allxheartxsurgeryxpatientsxwhosexbloodxsugarx(bloodxglucose)xisxkeptxunderxgoodxcontrolxinxthexdaysxrightxafterxsurgery' THEN 'all heart surgery patients whose blood sugar (blood glucose) is kept under good control in the days right after surgery'
            WHEN "measure_description" = 'childrenxwhoxreceivedxrelieverxmedicationxwhilexhospitalizedxforxasthma' THEN 'children who received reliever medication while hospitalized for asthma'
            WHEN "measure_description" = 'heart attack patients given aspirin at arrivax' THEN 'heart attack patients given aspirin at arrival'
            WHEN "measure_description" = 'heart attack patxents gxven aspxrxn at arrxval' THEN 'heart attack patients given aspirin at arrival'
            WHEN "measure_description" = 'heart attaxk patients given aspirin at disxharge' THEN 'heart attack patients given aspirin at discharge'
            WHEN "measure_description" = 'heart failure patients given ace inhibitor or arb for left xentricular systolic dysfunction (lxsd)' THEN 'heart failure patients given ace inhibitor or arb for left ventricular systolic dysfunction (lvsd)'
            WHEN "measure_description" = 'heart faxlure patxents gxven ace inhxbxtor or arb for left ventrxcular systolxc dysfunctxon (lvsd)' THEN 'heart failure patients given ace inhibitor or arb for left ventricular systolic dysfunction (lvsd)'
            WHEN "measure_description" = 'heart faxlure patxents gxven smokxng cessatxon advxce/counselxng' THEN 'heart failure patients given smoking cessation advice/counseling'
            WHEN "measure_description" = 'heart xailure patients given smoking cessation advice/counseling' THEN 'heart failure patients given smoking cessation advice/counseling'
            WHEN "measure_description" = 'heartxattackxpatientsxgivenxaspirinxatxarrival' THEN 'heart attack patients given aspirin at arrival'
            WHEN "measure_description" = 'heartxattackxpatientsxgivenxpcixwithinx90xminutesxofxarrival' THEN 'heart attack patients given pci within 90 minutes of arrival'
            WHEN "measure_description" = 'hearx failure paxienxs given smoking cessaxion advice/counseling' THEN 'heart failure patients given smoking cessation advice/counseling'
            WHEN "measure_description" = 'heaxt attack patients given aspixin at dischaxge' THEN 'heart attack patients given aspirin at discharge'
            WHEN "measure_description" = 'heaxt attack patients given beta blockex at dischaxge' THEN 'heart attack patients given beta blocker at discharge'
            WHEN "measure_description" = 'heaxt failuxe patients given an evaluation of left ventxiculax systolic (lvs) function' THEN 'heart failure patients given an evaluation of left ventricular systolic (lvs) function'
            WHEN "measure_description" = 'heaxt failuxe patients given dischaxge instxuctions' THEN 'heart failure patients given discharge instructions'
            WHEN "measure_description" = 'hexrt attxck pxtients given aspirin xt arrivxl' THEN 'heart attack patients given aspirin at arrival'
            WHEN "measure_description" = 'hxart attack patixnts givxn ace inhibitor or arb for lxft vxntricular systolic dysfunction (lvsd)' THEN 'heart attack patients given ace inhibitor or arb for left ventricular systolic dysfunction (lvsd)'
            WHEN "measure_description" = 'pneumonia patients assessed and given influenza vaxxination' THEN 'pneumonia patients assessed and given influenza vaccination'
            WHEN "measure_description" = 'pneumoniaxpatientsxassessedxandxgivenxinfluenzaxvaccination' THEN 'pneumonia patients assessed and given influenza vaccination'
            WHEN "measure_description" = 'pneumonix pxtients assessed xnd given influenzx vxccinxtion' THEN 'pneumonix pxtients xssessed xnd given influenzx vxccinxtion'
            WHEN "measure_description" = 'pneumonix pxtients given initixl antibiotic(s) within 6 hours after arrivxl' THEN 'pneumonix pxtients given initixl xntibiotic(s) within 6 hours xfter xrrivxl'
            WHEN "measure_description" = 'pneumonxa patxents whose inxtxal emergency room blood culture was performed prxor to the admxnxstratxon of the fxrst hospxtal dose of antxbxotxcs' THEN 'pneumonix pxtients whose initixl emergency room blood culture wxs performed prior to the xdministrxtion of the first hospitxl dose of xntibiotics'
            WHEN "measure_description" = 'pnxumonia patixnts whosx initial emxrgxncy room blood culturx was pxrformxd prior to thx administration of thx first hospital dosx of antibiotics' THEN 'pneumonix pxtients whose initixl emergency room blood culture wxs performed prior to the xdministrxtion of the first hospitxl dose of xntibiotics'
            WHEN "measure_description" = 'pxeumoxia patiexts assessed axd givex ixfluexza vaccixatiox' THEN 'pneumonix pxtients xssessed xnd given influenzx vxccinxtion'
            WHEN "measure_description" = 'pxeumoxia patiexts givex ixitial axtibiotic(s) withix 6 hours after arrival' THEN 'pneumonix pxtients given initixl xntibiotic(s) within 6 hours xfter xrrivxl'
            WHEN "measure_description" = 'pxeumoxia patiexts givex the most appropriate ixitial axtibiotic(s)' THEN 'pneumonix pxtients given the most xpproprixte initixl xntibiotic(s)'
            WHEN "measure_description" = 'surgery patients who were taking heart drugs caxxed beta bxockers before coming to the hospitax who were kept on the beta bxockers during the period just before and after their surgery' THEN 'surgery pxtients who were txking hexrt drugs cxlled betx blockers before coming to the hospitxl who were kept on the betx blockers during the period just before xnd xfter their surgery'
            WHEN "measure_description" = 'surgery patiexts who were takixg heart drugs called beta blockers before comixg to the hospital who were kept ox the beta blockers durixg the period just before axd after their surgery' THEN 'surgery pxtients who were txking hexrt drugs cxlled betx blockers before coming to the hospitxl who were kept on the betx blockers during the period just before xnd xfter their surgery'
            WHEN "measure_description" = 'surgery paxienxs needing hair removed from xhe surgical area before surgery who had hair removed using a safer mexhod (elecxric clippers or hair removal cream c nox a razor)' THEN 'surgery pxtients needing hxir removed from the surgicxl xrex before surgery who hxd hxir removed using x sxfer method (electric clippers or hxir removxl crexm - not x rxzor)'
            WHEN "measure_description" = 'surgeryxpatientsxneedingxhairxremovedxfromxthexsurgicalxareaxbeforexsurgery& xwhoxhadxhairxremovedxusingxaxsaferxmethodx(electricxclippersxorxhairxremovalxcreamxï¿½cxnotxaxrazor)' THEN 'surgery pxtients needing hxir removed from the surgicxl xrex before surgery who hxd hxir removed using x sxfer method (electric clippers or hxir removxl crexm - not x rxzor)'
            WHEN "measure_description" = 'xeart attack patients given aspirin at arrival' THEN 'hexrt xttxck pxtients given xspirin xt xrrivxl'
            ELSE "measure_description"
        END AS "measure_description",
        CASE
            WHEN "measure_score" = '1xx%' THEN '100%'
            WHEN "measure_score" = 'x5%' THEN '85%'
            WHEN "measure_score" = 'x7%' THEN '87%'
            WHEN "measure_score" = '9x%' THEN '90%'
            WHEN "measure_score" = 'x00%' THEN '100%'
            WHEN "measure_score" = 'xx%' THEN NULL
            WHEN "measure_score" = '80x' THEN '80%'
            WHEN "measure_score" = 'empty' THEN NULL
            WHEN "measure_score" = '89x' THEN '89%'
            WHEN "measure_score" = '93x' THEN '93%'
            WHEN "measure_score" = '95x' THEN '95%'
            WHEN "measure_score" = 'x3%' THEN '43%'
            WHEN "measure_score" = 'x4%' THEN '44%'
            WHEN "measure_score" = 'x6%' THEN '46%'
            ELSE "measure_score"
        END AS "measure_score",
        CASE
            WHEN "sample_size" = '0 patixnts' THEN '0 patients'
            WHEN "sample_size" = '25x patients' THEN '25 patients'
            WHEN "sample_size" = 'xx patients' THEN 'empty'
            WHEN "sample_size" = '6xpatients' THEN '6 patients'
            WHEN "sample_size" = 'x patients' THEN NULL
            WHEN "sample_size" = '0 patxents' THEN '0 patients'
            WHEN "sample_size" = '1 patiexts' THEN '1 patients'
            WHEN "sample_size" = '121 patiexts' THEN '121 patients'
            WHEN "sample_size" = '125 patixnts' THEN '125 patients'
            WHEN "sample_size" = '126 patxents' THEN '126 patients'
            WHEN "sample_size" = '15 patiexts' THEN '15 patients'
            WHEN "sample_size" = '172 patxents' THEN '172 patients'
            WHEN "sample_size" = '193 paxienxs' THEN '193 patients'
            WHEN "sample_size" = '1x patients' THEN NULL
            WHEN "sample_size" = '21 pxtients' THEN '21 patients'
            WHEN "sample_size" = '27 paxienxs' THEN '27 patients'
            WHEN "sample_size" = '29 xatients' THEN '29 patients'
            WHEN "sample_size" = '3x patients' THEN NULL
            WHEN "sample_size" = '4 patiexts' THEN '4 patients'
            WHEN "sample_size" = '4 xatients' THEN '4 patients'
            WHEN "sample_size" = '44 paxienxs' THEN '44 patients'
            WHEN "sample_size" = '50 pxtients' THEN '50 patients'
            WHEN "sample_size" = '521 patiexts' THEN '521 patients'
            WHEN "sample_size" = '618 xatients' THEN '618 patients'
            WHEN "sample_size" = '619 paxienxs' THEN '619 patients'
            WHEN "sample_size" = '62 patientx' THEN '62 patients'
            WHEN "sample_size" = '74 patxents' THEN '74 patients'
            WHEN "sample_size" = '82 patientx' THEN '82 patients'
            WHEN "sample_size" = '87 patientx' THEN '87 patients'
            WHEN "sample_size" = '87 paxienxs' THEN '87 patients'
            ELSE "sample_size"
        END AS "sample_size",
        CASE
            WHEN "state_average_code" = 'ax_ami-1' THEN 'ak_ami-1'
            WHEN "state_average_code" = 'ax_ami-2' THEN 'ak_ami-2'
            WHEN "state_average_code" = 'ax_hf-1' THEN 'ak_hf-1'
            WHEN "state_average_code" = 'ax_hf-2' THEN 'ak_hf-2'
            WHEN "state_average_code" = 'ax_hf-3' THEN 'ak_hf-3'
            WHEN "state_average_code" = 'ax_hf-4' THEN 'ak_hf-4'
            WHEN "state_average_code" = 'ax_pn-2' THEN 'ak_pn-2'
            WHEN "state_average_code" = 'ax_pn-3b' THEN 'ak_pn-3b'
            WHEN "state_average_code" = 'ax_pn-4' THEN 'ak_pn-4'
            WHEN "state_average_code" = 'ax_pn-5c' THEN 'ak_pn-5c'
            WHEN "state_average_code" = 'ax_pn-6' THEN 'ak_pn-6'
            WHEN "state_average_code" = 'ax_pn-7' THEN 'ak_pn-7'
            WHEN "state_average_code" = 'ax_scip-card-2' THEN 'ak_scip-card-2'
            WHEN "state_average_code" = 'ax_scip-inf-1' THEN 'ak_scip-inf-1'
            WHEN "state_average_code" = 'ax_scip-inf-2' THEN 'ak_scip-inf-2'
            WHEN "state_average_code" = 'ax_scip-inf-3' THEN 'ak_scip-inf-3'
            WHEN "state_average_code" = 'ax_scip-inf-4' THEN 'ak_scip-inf-4'
            WHEN "state_average_code" = 'ax_scip-inf-6' THEN 'ak_scip-inf-6'
            WHEN "state_average_code" = 'ax_scip-vte-1' THEN 'ak_scip-vte-1'
            WHEN "state_average_code" = 'ax_scip-vte-2' THEN 'ak_scip-vte-2'
            WHEN "state_average_code" = 'al_amix8a' THEN 'al_ami-8a'
            WHEN "state_average_code" = 'al_sxip-inf-2' THEN 'al_scip-inf-2'
            WHEN "state_average_code" = 'al_amx-1' THEN 'al_am-1'
            WHEN "state_average_code" = 'al_amx-7a' THEN 'al_am-7a'
            WHEN "state_average_code" = 'al_axi-1' THEN 'al_am-1'
            WHEN "state_average_code" = 'al_hf-x' THEN 'al_hf-1'
            WHEN "state_average_code" = 'al_hx-2' THEN 'al_h-2'
            WHEN "state_average_code" = 'al_pn-5x' THEN 'al_pn-5'
            WHEN "state_average_code" = 'al_pn-xb' THEN 'al_pn-1b'
            WHEN "state_average_code" = 'al_pnx2' THEN 'al_pn-2'
            WHEN "state_average_code" = 'al_pnx6' THEN 'al_pn-6'
            WHEN "state_average_code" = 'al_scipxinfx2' THEN 'al_scip-inf-2'
            WHEN "state_average_code" = 'al_scipxvtex1' THEN 'al_scip-vte-1'
            WHEN "state_average_code" = 'al_scipxvtex2' THEN 'al_scip-vte-2'
            WHEN "state_average_code" = 'al_scix-vte-1' THEN 'al_scip-vte-1'
            WHEN "state_average_code" = 'al_scix-vte-2' THEN 'al_scip-vte-2'
            WHEN "state_average_code" = 'alxami-7a' THEN 'al_am-7a'
            WHEN "state_average_code" = 'alxpn-3b' THEN 'al_pn-3b'
            WHEN "state_average_code" = 'alxpn-6' THEN 'al_pn-6'
            WHEN "state_average_code" = 'alxpn-7' THEN 'al_pn-7'
            WHEN "state_average_code" = 'xl_scip-inf-2' THEN 'al_scip-inf-2'
            WHEN "state_average_code" = 'xl_xmi-1' THEN 'al_am-1'
            WHEN "state_average_code" = 'xl_xmi-2' THEN 'al_am-2'
            WHEN "state_average_code" = 'xl_xmi-5' THEN 'al_am-5'
            ELSE "state_average_code"
        END AS "state_average_code"
    FROM "hospital_renamed"
),

"hospital_renamed_cleaned_null" AS (
    -- NULL Imputation: Impute Null to Disguised Missing Values
    -- address_2: ['empty']
    -- address_3: ['empty']
    -- sample_size: ['empty']
    SELECT 
        CASE
            WHEN "address_2" = 'empty' THEN NULL
            ELSE "address_2"
        END AS "address_2",
        CASE
            WHEN "address_3" = 'empty' THEN NULL
            ELSE "address_3"
        END AS "address_3",
        CASE
            WHEN "sample_size" = 'empty' THEN NULL
            ELSE "sample_size"
        END AS "sample_size",
        "state",
        "street_address",
        "treatment_category",
        "measure_description",
        "row_id",
        "county",
        "measure_score",
        "measure_code",
        "city",
        "phone_number",
        "provider_id",
        "zip_code",
        "state_average_code",
        "has_emergency_service",
        "hospital_name",
        "ownership_type",
        "hospital_type"
    FROM "hospital_renamed_cleaned"
),

"hospital_renamed_cleaned_null_fd" AS (
    -- FD: functional dependency
    -- street_address -> address_2, address_3, state, county, city, phone_number, provider_id, zip_code, has_emergency_service, hospital_name, ownership_type, hospital_type
    SELECT
        address_2,
        address_3,
        sample_size,
        CASE
            WHEN street_address = '2505 u s highway 431 north' THEN 'al'
            WHEN street_address = '200 med center drive' THEN 'al'
            WHEN street_address = '1000 first street north' THEN 'al'
            WHEN street_address = '1530 u s highway 43' THEN 'al'
            WHEN street_address = '987 drayton street' THEN 'al'
            WHEN street_address = '101 sivley rd' THEN 'al'
            WHEN street_address = '1108 ross clark circle' THEN 'al'
            WHEN street_address = '702 n main st' THEN 'al'
            WHEN street_address = '2451 fillingim street' THEN 'al'
            WHEN street_address = '126 hospital ave' THEN 'al'
            WHEN street_address = '205 marengo street' THEN 'al'
            WHEN street_address = '8000 alabama highway 69' THEN 'al'
            WHEN street_address = '400 northwood dr' THEN 'al'
            WHEN street_address = '4800 48th st' THEN 'al'
            WHEN street_address = '849 south three notch street' THEN 'al'
            WHEN street_address = '101 hospital circle' THEN 'al'
            WHEN street_address = '201 pine street northwest' THEN 'al'
            WHEN street_address = '124 s memorial dr' THEN 'al'
            WHEN street_address = '1725 pine street' THEN 'al'
            WHEN street_address = '805 friendship road' THEN 'al'
            WHEN street_address = '1653 temple avenue north' THEN 'al'
            WHEN street_address = '600 south third street' THEN 'al'
            ELSE state
        END AS state,
        street_address,
        treatment_category,
        measure_description,
        row_id,
        county,
        measure_score,
        measure_code,
        CASE
            WHEN street_address = '209 north main street' THEN 'wedowee'
            ELSE city
        END AS city,
        CASE
            WHEN street_address = '1108 ross clark circle' THEN '3347938701'
            WHEN street_address = '702 n main st' THEN '3344933541'
            WHEN street_address = '301 east 18th st' THEN '2562358900'
            WHEN street_address = '2451 fillingim street' THEN '2514717110'
            WHEN street_address = '126 hospital ave' THEN '3347742601'
            WHEN street_address = '1256 military street south' THEN '2059216200'
            WHEN street_address = '33700 highway 43' THEN '3346366221'
            WHEN street_address = '4800 48th st' THEN '3347561400'
            WHEN street_address = '849 south three notch street' THEN '3342228466'
            WHEN street_address = '4370 west main street' THEN '3347935000'
            WHEN street_address = '124 s memorial dr' THEN '3343614267'
            WHEN street_address = '2105 east south boulevard' THEN '3342882100'
            WHEN street_address = '1725 pine street' THEN '3342938000'
            WHEN street_address = '805 friendship road' THEN '3342836541'
            WHEN street_address = '600 south third street' THEN '2565435200'
            WHEN street_address = '2505 u s highway 431 north' THEN '2565938310'
            WHEN street_address = '200 med center drive' THEN '2568453150'
            WHEN street_address = '987 drayton street' THEN '3348972257'
            ELSE phone_number
        END AS phone_number,
        CASE
            WHEN street_address = '205 marengo street' THEN '10006'
            WHEN street_address = '33700 highway 43' THEN '10015'
            WHEN street_address = '1530 u s highway 43' THEN '10086'
            WHEN street_address = '101 sivley rd' THEN '10039'
            WHEN street_address = '124 s memorial dr' THEN '10108'
            WHEN street_address = '805 friendship road' THEN '10034'
            WHEN street_address = '1912 alabama highway 157' THEN '10035'
            WHEN street_address = '400 n edwards street' THEN '10049'
            WHEN street_address = '50 medical park east drive' THEN '10011'
            WHEN street_address = '301 east 18th st' THEN '10038'
            ELSE provider_id
        END AS provider_id,
        CASE
            WHEN street_address = '2505 u s highway 431 north' THEN '35957'
            WHEN street_address = '1000 first street north' THEN '35007'
            WHEN street_address = '1530 u s highway 43' THEN '35594'
            WHEN street_address = '315 w hickory st' THEN '35150'
            WHEN street_address = '50 medical park east drive' THEN '35235'
            WHEN street_address = '301 east 18th st' THEN '36201'
            WHEN street_address = '126 hospital ave' THEN '36360'
            WHEN street_address = '619 south 19th street' THEN '35233'
            WHEN street_address = '205 marengo street' THEN '35631'
            WHEN street_address = '33700 highway 43' THEN '36784'
            WHEN street_address = '400 northwood dr' THEN '35960'
            WHEN street_address = '1007 goodyear avenue' THEN '35903'
            WHEN street_address = '101 hospital circle' THEN '36049'
            WHEN street_address = '4370 west main street' THEN '36305'
            WHEN street_address = '124 s memorial dr' THEN '36067'
            WHEN street_address = '1725 pine street' THEN '36106'
            ELSE zip_code
        END AS zip_code,
        state_average_code,
        has_emergency_service,
        CASE
            WHEN street_address = '600 south third street' THEN 'riverview regional medical center'
            WHEN street_address = '515 miranda st' THEN 'georgiana hospital'
            ELSE hospital_name
        END AS hospital_name,
        ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null"
),

"hospital_renamed_cleaned_null_fd_fd" AS (
    -- FD: functional dependency
    -- treatment_category -> address_2, address_3, state, has_emergency_service, hospital_type
    SELECT
        address_2,
        address_3,
        sample_size,
        CASE
            WHEN treatment_category = 'pneumonia' THEN 'al'
            WHEN treatment_category = 'heart attack' THEN 'al'
            WHEN treatment_category = 'surgical infection prevention' THEN 'al'
            WHEN treatment_category = 'heart failure' THEN 'al'
            ELSE state
        END AS state,
        street_address,
        treatment_category,
        measure_description,
        row_id,
        county,
        measure_score,
        measure_code,
        city,
        phone_number,
        provider_id,
        zip_code,
        state_average_code,
        CASE
            WHEN treatment_category = 'heart attack' THEN 'yes'
            WHEN treatment_category = 'surgical infection prevention' THEN 'yes'
            WHEN treatment_category = 'pneumonia' THEN 'yes'
            WHEN treatment_category = 'heart failure' THEN 'yes'
            ELSE has_emergency_service
        END AS has_emergency_service,
        hospital_name,
        ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null_fd"
),

"hospital_renamed_cleaned_null_fd_fd_fd" AS (
    -- FD: functional dependency
    -- measure_description -> address_2, address_3, state, treatment_category, measure_code, state_average_code, has_emergency_service, hospital_type
    SELECT
        address_2,
        address_3,
        sample_size,
        state,
        street_address,
        treatment_category,
        measure_description,
        row_id,
        county,
        measure_score,
        CASE
            WHEN measure_description = 'surgery patients whose preventive antibiotics were stopped at the right time (within 24 hours after surgery)' THEN 'scip-inf-3'
            WHEN measure_description = 'children who received reliever medication while hospitalized for asthma' THEN 'cac-1'
            WHEN measure_description = 'pneumonia patients assessed and given pneumococcal vaccination' THEN 'pn-2'
            WHEN measure_description = 'surgery patients whose doctors ordered treatments to prevent blood clots after certain types of surgeries' THEN 'scip-vte-1'
            WHEN measure_description = 'heart failure patients given discharge instructions' THEN 'hf-1'
            WHEN measure_description = 'heart failure patients given an evaluation of left ventricular systolic (lvs) function' THEN 'hf-2'
            WHEN measure_description = 'heart attack patients given beta blocker at discharge' THEN 'ami-5'
            ELSE measure_code
        END AS measure_code,
        city,
        phone_number,
        provider_id,
        zip_code,
        CASE
            WHEN measure_description = 'surgery patients whose doctors ordered treatments to prevent blood clots after certain types of surgeries' THEN 'al_scip-vte-1'
            WHEN measure_description = 'heart attack patients given aspirin at arrival' THEN 'al_ami-1'
            WHEN measure_description = 'heart failure patients given discharge instructions' THEN 'al_hf-1'
            WHEN measure_description = 'heart failure patients given an evaluation of left ventricular systolic (lvs) function' THEN 'al_hf-2'
            WHEN measure_description = 'heart failure patients given ace inhibitor or arb for left ventricular systolic dysfunction (lvsd)' THEN 'al_hf-3'
            WHEN measure_description = 'heart failure patients given smoking cessation advice/counseling' THEN 'al_hf-4'
            WHEN measure_description = 'pneumonia patients given smoking cessation advice/counseling' THEN 'al_pn-4'
            WHEN measure_description = 'pneumonia patients assessed and given influenza vaccination' THEN 'al_pn-7'
            WHEN measure_description = 'surgery patients whose preventive antibiotics were stopped at the right time (within 24 hours after surgery)' THEN 'al_scip-inf-3'
            WHEN measure_description = 'pneumonia patients whose initial emergency room blood culture was performed prior to the administration of the first hospital dose of antibiotics' THEN 'al_pn-3b'
            WHEN measure_description = 'surgery patients who were taking heart drugs called beta blockers before coming to the hospital who were kept on the beta blockers during the period just before and after their surgery' THEN 'al_scip-card-2'
            WHEN measure_description = 'surgery pxtients needing hxir removed from the surgicxl xrex before surgery who hxd hxir removed using x sxfer method (electric clippers or hxir removxl crexm - not x rxzor)' THEN 'ak_scip-inf-6'
            WHEN measure_description = 'all heart surgery patients whose blood sugar (blood glucose) is kept under good control in the days right after surgery' THEN 'al_scip-inf-4'
            WHEN measure_description = 'patients who got treatment  at the right time (within 24 hours before or after their surgery) to help prevent blood clots after certain types of surgery' THEN 'al_scip-vte-2'
            WHEN measure_description = 'heart attack patients given fibrinolytic medication within 30 minutes of arrival' THEN 'al_ami-7a'
            WHEN measure_description = 'pneumonia patients assessed and given pneumococcal vaccination' THEN 'al_pn-2'
            WHEN measure_description = 'pneumonia patients given initial antibiotic(s) within 6 hours after arrival' THEN 'al_pn-5c'
            WHEN measure_description = 'surgery patients who were given an antibiotic at the right time (within one hour before surgery) to help prevent infection' THEN 'al_scip-inf-1'
            WHEN measure_description = 'surgery patients who were given the  right kind  of antibiotic to help prevent infection' THEN 'al_scip-inf-2'
            WHEN measure_description = 'heart attack patients given aspirin at discharge' THEN 'al_ami-2'
            WHEN measure_description = 'heart attack patients given beta blocker at discharge' THEN 'al_ami-5'
            WHEN measure_description = 'pneumonia patients given the most appropriate initial antibiotic(s)' THEN 'al_pn-6'
            ELSE state_average_code
        END AS state_average_code,
        has_emergency_service,
        hospital_name,
        ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null_fd_fd"
),

"hospital_renamed_cleaned_null_fd_fd_fd_fd" AS (
    -- FD: functional dependency
    -- county -> provider_id, hospital_name
    SELECT
        address_2,
        address_3,
        sample_size,
        state,
        street_address,
        treatment_category,
        measure_description,
        row_id,
        county,
        measure_score,
        measure_code,
        city,
        phone_number,
        CASE
            WHEN county = 'jefferson' THEN '10018'
            WHEN county = 'montgomery' THEN '10023'
            WHEN county = 'marshall' THEN '10005'
            WHEN county = 'morgan' THEN '10009'
            WHEN county = 'etowah' THEN '10046'
            WHEN county = 'marion' THEN '10086'
            WHEN county = 'coffee' THEN '10027'
            WHEN county = 'houston' THEN '10001'
            WHEN county = 'covington' THEN '10007'
            ELSE provider_id
        END AS provider_id,
        zip_code,
        state_average_code,
        has_emergency_service,
        CASE
            WHEN county = 'jefferson' THEN 'callahan eye foundation hospital'
            WHEN county = 'montgomery' THEN 'baptist medical center south'
            WHEN county = 'houston' THEN 'southeast alabama medical center'
            WHEN county = 'covington' THEN 'mizell memorial hospital'
            WHEN county = 'marion' THEN 'northwest medical center'
            WHEN county = 'coffee' THEN 'elba general hospital'
            WHEN county = 'marshall' THEN 'marshall medical center south'
            WHEN county = 'morgan' THEN 'hartselle medical center'
            WHEN county = 'etowah' THEN 'riverview regional medical center'
            ELSE hospital_name
        END AS hospital_name,
        ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null_fd_fd_fd"
),

"hospital_renamed_cleaned_null_fd_fd_fd_fd_fd" AS (
    -- FD: functional dependency
    -- measure_code -> address_2, address_3, state, treatment_category, measure_description, state_average_code, has_emergency_service, hospital_type
    SELECT
        address_2,
        address_3,
        sample_size,
        state,
        street_address,
        treatment_category,
        CASE
            WHEN measure_code = 'scip-inf-6' THEN 'surgery patients needing hair removed from the surgical area before surgery who had hair removed using a safer method (electric clippers or hair removal cream c not a razor)'
            WHEN measure_code = 'scip-vte-1' THEN 'surgery patients whose doctors ordered treatments to prevent blood clots after certain types of surgeries'
            WHEN measure_code = 'pn-5c' THEN 'pneumonia patients given initial antibiotic(s) within 6 hours after arrival'
            WHEN measure_code = 'scip-card-2' THEN 'surgery patients who were taking heart drugs called beta blockers before coming to the hospital who were kept on the beta blockers during the period just before and after their surgery'
            WHEN measure_code = 'pn-6' THEN 'pneumonia patients given the most appropriate initial antibiotic(s)'
            WHEN measure_code = 'pn-7' THEN 'pneumonia patients assessed and given influenza vaccination'
            WHEN measure_code = 'ami-1' THEN 'heart attack patients given aspirin at arrival'
            WHEN measure_code = 'pn-3b' THEN 'pneumonia patients whose initial emergency room blood culture was performed prior to the administration of the first hospital dose of antibiotics'
            ELSE measure_description
        END AS measure_description,
        row_id,
        county,
        measure_score,
        measure_code,
        city,
        phone_number,
        provider_id,
        zip_code,
        CASE
            WHEN measure_code = 'scip-inf-6' THEN 'al_scip-inf-6'
            ELSE state_average_code
        END AS state_average_code,
        has_emergency_service,
        hospital_name,
        ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null_fd_fd_fd_fd"
),

"hospital_renamed_cleaned_null_fd_fd_fd_fd_fd_fd" AS (
    -- FD: functional dependency
    -- city -> provider_id, hospital_name, street_address, address_2, address_3, county, state, zip_code, phone_number, hospital_type, ownership_type, has_emergency_service
    SELECT
        address_2,
        address_3,
        sample_size,
        state,
        CASE
            WHEN city = 'opp' THEN '702 n main st'
            WHEN city = 'anniston' THEN '301 east 18th st'
            WHEN city = 'montgomery' THEN '2105 east south boulevard'
            WHEN city = 'georgiana' THEN '515 miranda st'
            WHEN city = 'birmingham' THEN '50 medical park east drive'
            WHEN city = 'thomasville' THEN '33700 highway 43'
            WHEN city = 'sylacauga' THEN '315 w hickory st'
            WHEN city = 'wedowee' THEN '209 north main street'
            WHEN city = 'gadsden' THEN '600 south third street'
            WHEN city = 'dothan' THEN '1108 ross clark circle'
            WHEN city = 'hartselle' THEN '201 pine street northwest'
            WHEN city = 'cullman' THEN '1912 alabama highway 157'
            WHEN city = 'boaz' THEN '2505 u s highway 431 north'
            WHEN city = 'guntersville' THEN '8000 alabama highway 69'
            WHEN city = 'winfield' THEN '1530 u s highway 43'
            WHEN city = 'ozark' THEN '126 hospital ave'
            WHEN city = 'clanton' THEN '1010 lay dam road'
            WHEN city = 'enterprise' THEN '400 n edwards street'
            ELSE street_address
        END AS street_address,
        treatment_category,
        measure_description,
        row_id,
        county,
        measure_score,
        measure_code,
        city,
        CASE
            WHEN city = 'dothan' THEN '3347938701'
            WHEN city = 'montgomery' THEN '3342882100'
            WHEN city = 'birmingham' THEN '2053258100'
            WHEN city = 'gadsden' THEN '2565435200'
            ELSE phone_number
        END AS phone_number,
        provider_id,
        CASE
            WHEN city = 'dothan' THEN '36302'
            WHEN city = 'montgomery' THEN '36116'
            WHEN city = 'birmingham' THEN '35233'
            WHEN city = 'gadsden' THEN '35901'
            ELSE zip_code
        END AS zip_code,
        state_average_code,
        has_emergency_service,
        hospital_name,
        CASE
            WHEN city = 'montgomery' THEN 'voluntary non-profit - church'
            WHEN city = 'birmingham' THEN 'voluntary non-profit - private'
            WHEN city = 'dothan' THEN 'government - hospital district or authority'
            ELSE ownership_type
        END AS ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null_fd_fd_fd_fd_fd"
),

"hospital_renamed_cleaned_null_fd_fd_fd_fd_fd_fd_fd" AS (
    -- FD: functional dependency
    -- provider_id -> address_2, address_3, state, street_address, county, city, phone_number, zip_code, has_emergency_service, hospital_name, ownership_type, hospital_type
    SELECT
        address_2,
        address_3,
        sample_size,
        state,
        CASE
            WHEN provider_id = '10007' THEN '702 n main st'
            WHEN provider_id = '10005' THEN '2505 u s highway 431 north'
            WHEN provider_id = '10086' THEN '1530 u s highway 43'
            WHEN provider_id = '10018' THEN '50 medical park east drive'
            WHEN provider_id = '10009' THEN '201 pine street northwest'
            WHEN provider_id = '10027' THEN '987 drayton street'
            ELSE street_address
        END AS street_address,
        treatment_category,
        measure_description,
        row_id,
        county,
        measure_score,
        measure_code,
        CASE
            WHEN provider_id = '10018' THEN 'birmingham'
            WHEN provider_id = '10009' THEN 'hartselle'
            WHEN provider_id = '10005' THEN 'boaz'
            WHEN provider_id = '10086' THEN 'winfield'
            WHEN provider_id = '10007' THEN 'opp'
            WHEN provider_id = '10027' THEN 'elba'
            ELSE city
        END AS city,
        CASE
            WHEN provider_id = '10005' THEN '2565938310'
            WHEN provider_id = '10086' THEN '2054877736'
            WHEN provider_id = '10018' THEN '2053258100'
            WHEN provider_id = '10009' THEN '2567736511'
            WHEN provider_id = '10007' THEN '3344933541'
            WHEN provider_id = '10027' THEN '3348972257'
            ELSE phone_number
        END AS phone_number,
        provider_id,
        CASE
            WHEN provider_id = '10018' THEN '35233'
            WHEN provider_id = '10009' THEN '35640'
            WHEN provider_id = '10005' THEN '35957'
            WHEN provider_id = '10086' THEN '35594'
            WHEN provider_id = '10007' THEN '36467'
            WHEN provider_id = '10027' THEN '36323'
            ELSE zip_code
        END AS zip_code,
        state_average_code,
        has_emergency_service,
        hospital_name,
        CASE
            WHEN provider_id = '10007' THEN 'voluntary non-profit - private'
            WHEN provider_id = '10086' THEN 'proprietary'
            WHEN provider_id = '10018' THEN 'voluntary non-profit - private'
            WHEN provider_id = '10009' THEN 'proprietary'
            WHEN provider_id = '10027' THEN 'voluntary non-profit - other'
            ELSE ownership_type
        END AS ownership_type,
        hospital_type
    FROM "hospital_renamed_cleaned_null_fd_fd_fd_fd_fd_fd"
),

"hospital_renamed_cleaned_null_fd_fd_fd_fd_fd_fd_fd_casted" AS (
    -- Column Type Casting: 
    -- sample_size: from VARCHAR to INT
    -- measure_score: from VARCHAR to INT
    -- has_emergency_service: from VARCHAR to BOOLEAN
    SELECT
        "address_2",
        "address_3",
        "state",
        "street_address",
        "treatment_category",
        "measure_description",
        "row_id",
        "county",
        "measure_code",
        "city",
        "phone_number",
        "provider_id",
        "zip_code",
        "state_average_code",
        "hospital_name",
        "ownership_type",
        "hospital_type",
        CAST(REGEXP_EXTRACT("sample_size", '(\d+)') AS INT) AS "sample_size",
        CAST(REPLACE("measure_score", '%', '') AS INT) AS "measure_score",
        CAST(
            CASE 
                WHEN "has_emergency_service" = 'yes' THEN TRUE
                WHEN "has_emergency_service" = 'no' THEN FALSE
                ELSE NULL
            END AS BOOLEAN
        ) AS "has_emergency_service"
    FROM "hospital_renamed_cleaned_null_fd_fd_fd_fd_fd_fd_fd"
)

-- COCOON BLOCK END
SELECT * FROM "hospital_renamed_cleaned_null_fd_fd_fd_fd_fd_fd_fd_casted"
*************************************************
***** ----- CLEANING THE RICARDO DATA ----- *****
*************************************************

**** ---- Import the data ---- ****
import delimited "/Volumes/Edward HDD Main/Thesis/data/RICardo Project (Trade Data)/data.csv", clear

foreach x of varlist import export total {
	gen `x'_mirror = `x'
	replace 
}
gen is_uk = (reporting == "UnitedKingdom")
bysort year: egen year_has_uk = max(is_uk)
drop if reporting != "UnitedKingdom" & year_has_uk == 1
drop is_uk year_has_uk

drop if year <= 1870 /*the data starts from 1871*/
drop if year >= 1914 /*the data ends at 1913*/

/*data is not availale for these years in ASNS*/
drop if year == 1901 
drop if year == 1902
drop if year == 1905
drop if year == 1906
drop if year == 1907

drop total_trade diff

** add tripoli and tunis together
replace partner = "Tripoli and Tunis" if partner == "Tripolitania (Regency of Tripoli)" | partner == "Tunisia (Regency of Tunis)"
bysort partner year: egen total_trade = total(total)
bysort partner year: egen total_exports = total(export)
bysort partner year: egen total_imports = total(import)

drop total export import
rename total_trade total_ric
rename total_exports export_ric
rename total_imports import_ric
duplicates drop partner year, force

rename gph_code partner_code
replace partner_code = 616 if partner_code == 6203 /*using the code of Tunis*/
gen reporting_code = 200
gen id = string(reporting_code) + "_" + string(partner_code) + "_" + string(year)

save "/Volumes/Edward HDD Main/Thesis/data/RICardo Project (Trade Data)/data.dta", replace

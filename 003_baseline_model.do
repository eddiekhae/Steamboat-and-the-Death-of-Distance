********************************
**** ---- PRELIM MODEL ---- ****
********************************

cls
global path = "/Volumes/Edward HDD Main/Thesis/data"
use "$path/model_data.dta", clear

encode ID, gen(cs)
xtset cs year


*** --- Generate FEs --- ***
gen jt = string(partner_code) + "_" + string(year)
gen it = string(reporting_code) + "_" + string(year)
*gen ij = reporting + "_" + partner 


*** --- Generate some dummies --- *** 
tab partner_iso, gen(partner_dummy)
tab year, gen(year_dummy)

*** --- Steam shares --- ***
gen import_share = s_tons_import/ss_tons_import
gen export_share = s_tons_export/ss_tons_export
gen ss_tons_trade = ss_tons_import+ss_tons_export
gen s_tons_trade = s_tons_import+s_tons_export
gen trade_share = s_tons_trade/ss_tons_trade
*gen trade_share = import_share+export_share



**** modelling the naive gravity
gen exp = export
gen imp = import
drop export import
gen ln_distance = log(SeaDist_SHRT)
gen ln_export = log(exp)
gen total = exp + imp
gen ln_total = log(total)


/*
foreach d in export import trade {
    * pure floating-point noise at the cap -> it's 100% steam
    replace `d'_share = 1 if `d'_share > 1 & `d'_share <= 1.001
    * genuine inconsistency (total < steam) or divide-by-~0 -> not recoverable
    replace `d'_share = . if `d'_share > 1.001
    replace `d'_share = . if ss_tons_`d' <= 0
}
*/


ppmlhdfe total c.ln_distance#c.trade_share, absorb(partner_iso year) cluster(partner_iso) /*positive and significant*/
ppmlhdfe imp c.ln_distance#c.import_share, absorb(partner_iso year) cluster(partner_iso) /*positive and significant*/
ppmlhdfe export c.ln_distance#c.exp_share, absorb(partner_iso year) cluster(partner_iso) /*positive and significant*/

ppmlhdfe total c.trade_share c.trade_share#c.ln_distance, ///
    absorb(partner_iso year) vce(cluster partner_iso)

ppmlhdfe imp c.import_share c.import_share#c.ln_distance, ///
    absorb(partner_iso year) vce(cluster partner_iso)
	
ppmlhdfe exp c.export_share c.export_share#c.ln_distance, ///
    absorb(partner_iso year) vce(cluster partner_iso)
	
/*
summarize ln_distance, meanonly
capture drop gen ln_dist_c = ln_distance - r(mean)
ppmlhdfe exp c.export_share c.export_share#c.ln_dist_c, absorb(partner_iso year) vce(cluster partner_iso)

summarize ln_distance, meanonly
local m = r(mean)
foreach D in 7 8 9 10 {                 // raw ln_distance values
    lincom _b[export_share] + (`D' - `m')*_b[c.export_share#c.ln_dist_c]
}


* baseline: the average within-route steam–trade link, no interaction
ppmlhdfe exp c.export_share, absorb(partner_iso year) vce(cluster partner_iso)
*/

/*
*** --- extensive margin --- ***
preserve
bysort partner: keep if _N == 38
ppmlhdfe trade c.ln_distance#c.trade_share, absorb(partner_iso year) cluster(partner_iso) /*positive and significant*/
restore
*/

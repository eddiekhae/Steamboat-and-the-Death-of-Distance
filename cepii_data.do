**** clean CEPII data **** 
cls
global cepii = "/Volumes/Edward HDD Main/Thesis/data/cepii"

use "$cepii/TRADHIST_v4.dta", clear /*FLOW is import and export*/

keep if iso_d == "GBR" | iso_o == "GBR"
drop if iso_o == "GBR" & iso_d == "GBR"
drop if year >=1914
drop if year <=1859 /*I want trade data for 1860*/
gen partner_cepii = ""
replace partner_cepii = iso_o if iso_d == "GBR"
replace partner_cepii = iso_d if iso_o == "GBR"
gen type = cond(iso_o == "GBR", "export", "import")
gen reporting_cepii = "GBR"

drop iso_o iso_d

reshape wide FLOW FLOW_0 SOURCE_TF GDP_o SOURCE_GDP_o GDP_d SOURCE_GDP_d SH_PRIM_o SOURCE_SH_PRIM_o ///
 SH_SECD_o SOURCE_SH_SECD_o SH_PRIM_d SOURCE_SH_PRIM_d SH_SECD_d SOURCE_SH_SECD_d POP_o POP_d SOURCE_POP_o ///
 SOURCE_POP_d IPTOT_o SOURCE_IPTOT_o IPTOT_d SOURCE_IPTOT_d XPTOT_o SOURCE_XPTOT_o XPTOT_d SOURCE_XPTOT_d ///
 BITARIFF TARIFF_o SOURCE_TARIFF_o TARIFF_d SOURCE_TARIFF_d Dist_o Dist_d Curcol_o Curcol_d CONTI_o CONTI_d ///
  Metro XCH_RATE_o SOURCE_XCH_o XCH_RATE_d ///
 SOURCE_XCH_d REGIO_o REGIO_d OECD_o OECD_d EU_o EU_d GATT_o GATT_d ///
 SeaDist_SHRT SeaDist_2CST Comlang Contig Colo Evercol, ///
 i(reporting partner year) j(type) string

rename FLOWexport export
rename FLOWimport import
rename GDP_oexport GDP_o
rename GDP_dimport GDP_d
rename POP_oexport POP_o
rename POP_dimport POP_d
rename SeaDist_SHRTexport SeaDist_SHRT
rename SeaDist_2CSTexport SeaDist_2CST
rename Comlangexport Comlang
rename Contigexport Contig
rename Coloexport Colo
rename Evercolexport Evercol

keep export import GDP_o GDP_d POP_o POP_d SeaDist_SHRT SeaDist_2CST ///
Comlang Contig Colo Evercol reporting_cepii partner_cepii year

/*
gen export = FLOW if iso_o == "GBR"
gen import = FLOW if iso_d == "GBR"
collapse (sum) export import, by(reporting partner year)
*/

gen ID = reporting_cepii + partner_cepii + string(year)

save "$cepii/cepii_merge.dta", replace

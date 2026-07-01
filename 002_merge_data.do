************************************
***** ----- MERGING DATA ----- *****
************************************

*** Load the directories
cls 
clear all
global path = "/Volumes/Edward HDD Main/Thesis/data" 
global ASNS_data = "$path/ASNS/excel"
global RICardo_data = "$path/RICardo Project (Trade Data)"
global Luigi_data = "$path/pascali luigi replication (my version)/PUBLIC_DATA"
global cepii = "$path/cepii"

*** --- Load the ASNS data --- ***
/*measured as Net Registered Tonnage*/
** 156 total entities
use "$ASNS_data/clean_data.dta", clear

*** --- Merge with RICardo data --- ***
/*trade flows measured in £*/
** 87 countries from this were merged
merge 1:1 id using "$RICardo_data/data.dta", keep(1 3)
drop _merge

*** --- Merge using Pascali Luigi Data --- ***
/*trade flows measured in £ (millions)*/
** 43 countries from this were merged
merge 1:1 id using "$Luigi_data/trade_flows.dta", keep(1 3)
drop _merge

gen exports = expr*1000000 /*the measurement used by Pascali (million £)*/
replace exports = export_ric if exports ==.

gen imports = impr*1000000 /*the measurement used by Pascali (million £)*/
replace imports = import_ric if imports ==.

*** --- Merge with CEPII --- ***
/*for the distance measures*/
merge 1:1 ID using "$cepii/cepii_merge.dta", keep(1 3)
*drop _merge

list ID year import imports if missing(import) & !missing(imports)
list ID year import impr if missing(import) & !missing(import_ric)
list ID year import import_ric if missing(imports) & !missing(import_ric)

save "$path/model_data.dta", replace

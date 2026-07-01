*****************************************
***** ----- CLEANING THE DATA ----- *****
*****************************************

cls 
clear all
global path = "/Volumes/Edward HDD Main/Thesis/data" 
global data = "$path/ASNS/excel"
global cepii = "$path/cepii"

* load the data
import excel "$data/data.xlsx", sheet("Sheet1") firstrow clear

********************************************************
***** ----- Cleaning the name of the country ----- *****
********************************************************

** there are 425 different entities in the data (with errors)

* Abyssinia
* Algeria

replace partner = "Aden" if partner == "Aden and Dependencies"

replace partner = "Arabia: Muscat" if partner == "Arabia: Territories of the Imaum of Muscat" | partner == "Arabia: Territories of the Sultan of Oman (Muscat)"

replace partner = "Arabia: States not separately enumerated" if partner == "Other Native States" | partner == "Other States not separately enumerated" | partner == "Other States, not separately enumerated"

replace partner = "Argentine Republic" if partner == "Argentine Republic (including the Atlantic Coast of Patagonia)" | partner == "Argentine Republic (including the Patagonia)" | partner == "States of the Argentine Confederation"

* Ascension

replace partner = "Asiatic Turkey" if partner == "Asiatic" | partner == "Asiatic Turkey (Including El Hejaz and Turkish Ports on the Persian Gulf)" | partner == "Asiatic Turkey (including Cyprus)" | partner == "Asiatic Turkey (including El Hadj and Turkish Ports on the Persian Gulf)" | partner == "Asiatic Turkey (including El Hediaz and Turkish Ports on the Persian Gulf)" | partner == "Asiatic Turkey (including El Hediaz, and Turkish Ports on the Persian Gulf)" | partner == "Asiatic Turkey (including El Hedjaz and Turkish Ports on the Persian Gulf)" | partner == "Asiatic Turkey (including El Hedjaz, and Turkish Ports on the Persian Gulf)" | partner == "Asiatic Turkey (including El Hejaz and Turkish Ports on the Persian Gulf)" | partner =="Asiatic Turkey (including El Hejaz and Turkish Possessions on the Persian Gulf)" | partner == "Asiatic Turkey (including El Hejaz, and Turkish Ports on the Persian Gulf)" | partner == "Turkey, Asiatic" | partner == "Turkish Dominions: Asiatic Turkey" | partner == "Turkish Dominions: Asiatic Turkey (including Cyprus)" | partner == "Turkish Dominions: Asiatic Turkey (including El Hejaz and Turkish Ports on the Persian Gulf)" /*combine both asiatic and european turkey*/

replace partner = "Australia" if partner == "Australia and New Zealand: West Australia" | partner == "Australia: New South Wales" | partner == "Australia: Queensland" | partner == "Australia: South Australia" | partner == "Australia: South Australia (including Northern Territory)" | partner == "Australia: Tasmania" | partner == "Australia: Victoria" | partner == "Australia: West Australia" | partner == "Australia: Western Australia" | partner == "British Australia: New South Wales" | partner == "British Australia: South Australia" | partner == "British Australia: Victoria" | partner == "British Australia: West Australia" | partner == "Queensland" | partner == "South Australia" | partner == "South Australia (Including Northern Territory)" | partner == "South Australia (including Northern Territory)" | partner == "Tasmania" | partner == "West Australia" | partner == "Western Australia" | partner == "Western Australia (including Northern Territory)" | partner == "New South Wales"

replace partner = "New Zealand" if partner == "Australia: New Zealand" | partner == "British Australia: New Zealand"

replace partner = "Bulgaria" if partner == "Bularia"

replace partner = "Austria-Hungary" if partner == "Austrian Territories"

* Azores
* Bahamas
* Belgium

replace partner = "Bengal and Burmah" if partner == "Bengal" | partner == "Bengal and British Burmah" | partner == "Beugal and Burmah" | partner == "Beneni" | partner == "British India: Bengal" | partner == "British India: Burmah" | partner == "British Possessions in India: Bengal and British Burmah" | partner == "British Possessions in India: Bengal and Burmah" | partner == "British Possessions in India: Beugal and Burmah" | partner == "Burmah"

replace partner = "Bermuda" if partner == "Bermudas"

* Bolivia

replace partner = "Bombay" if partner == "Bombay (including Karachi)" | partner == "Bombay (including Kurachi)" | partner == "Bombay and Scinde" | partner == "British India: Bombay" | partner == "British India: Bombay (including Karachi)" | partner == "British India: Bombay (including Kurachi)" | partner == "British Possessions in India: Bombay" | partner == "British Possessions in India: Bombay and Scinde"


replace partner = "Dutch Borneo" if partner == "Borneo" | partner == "Borneo (Dutch)" | partner == "Dutch Possessions in the Indian Seas: Borneo (Dutch)"

replace partner = "British Borneo" if partner == "Borneo (British): Sarawak" | partner == "Borneo (British)"

replace partner = "Reunion" if partner == "Bourbon" | partner == "Bourbon (Re-union)" | partner == "Bourbon (Reunion)" | partner == "Bourbon (Réunion)" | partner == "Bourbon Reunion" | partner == "Reunion (Bourbon)"

replace partner = "Brasil" if partner == "Brazil"

* British Guiana

replace partner = "Belize" if partner == "British Settlements in Honduras (Belize)" | partner == "British Settlements in Honduras, Belize" | partner == "British Honduras"

replace partner = "Fiji" if partner == "British Islands in the Pacific: Fiji" | partner == "Fiji Islands"

replace partner = "Canada" if partner == "British North America: Dominion of Canada" | partner == "British North America: Dominion of Canada: Atlantic Seaboard" | partner == "British North America: Dominion of Canada: Atlantic Seaboard, Pacific Seaboard" | partner == "British North America: Dominion of Canada: Newfoundland and Coast of Labrador" | partner == "British North America: Dominion of Canada: Ports on the Atlantic" | partner == "British North America: Newfoundland" | partner == "British North America: Newfoundland and Coast of Labrador" | partner == "Canada: On the Atlantic" | partner == "Canada: On the Pacific" | partner == "Dominion of Canada" | partner == "Dominion of Canada: Atlantic Seaboard" | partner == "Dominion of Canada: Pacific Seaboard" | partner == "Newfoundland" | partner == "Newfoundland (including Labrador)" | partner == "Newfoundland and Coast of Labrador" | partner == "Newfoundland and Labrador" | partner == "Pacific Seaboard" | partner == "Pacific Seaboard, Dominion of Canada" | partner == "Ports on the Pacific" | partner == "Victoria" | partner == "Atlantic Seaboard, Dominion of Canada" | partner == "Prince Edward Island" | partner == "British North America: Prince Edward Islands" | partner == "British Columbia and Vancouver's Island" | partner == "British North America: Prince Edward Island"

replace partner = "Gambia" if partner == "British Possessions and Protectorates in Western Africa: Gambia" | partner == "British Possessions in Western Africa: Gambia" | partner == "British Possessions on the River Gambia"

replace partner = "Gold Coast" if partner == "British Possessions in Western Africa: Gold Coast" | partner == "British Possessions and Protectorates in Western Africa: Gold Coast" | partner == "British Possessions on the Gold Coast" | partner == "Dutch Possessions on the Gold Coast" | partner == "The Gold Coast" | partner == "West Africa: Gold Coast" | partner == "West Africa: The Gold Coast" | partner == "Lagos" | partner == "British Possessions and Protectorates in Western Africa: Lagos" | partner == "West Africa: Lagos" | partner == "Gold Coast (including Lagos)" | partner == "British Possessions and Protectorates in Western Africa: Lagos"

replace partner = "Sierra Leone" if partner == "British Possessions and Protectorates in Western Africa: Sierra Leone" | partner == "British Possessions in Western Africa: Sierra Leone" | partner == "West Africa. Sierra Leone" | partner == "West Africa: Sierra Leone"

replace partner = "South Africa" if partner == "British Possessions in South Africa: Cape of Good Hope" | partner == "British Possessions in South Africa: Natal" | partner == "British South Africa: Cape of Good Hope" | partner == "British South Africa: Natal" | partner == "Cape of Good Hope" | partner == "Natal"

replace partner = "Zanzibar and Pemba" if partner == "East Africa: Zanzibar and Pemba" | partner == "British Protectorates and Territories under British Influence in Eastern Africa: Zanzibar and Pemba" | partner == "Protectorate of Zanzibar and Pemba"

replace partner = "British West India Islands" if partner == "British West India Islands: Other than Bahamas" | partner == "Other than Bahamas"

replace partner = "Bulgaria" if partner == "Bularia"

* Canary Islands
* Central America

replace partner = "Ceylon" if partner == "Ceylon and Dependencies" | partner == "British Possessions in India: Ceylon"

* Channel Islands

replace partner = "Chile" if partner == "Chile (Including the Pacific Coast of Patagonia)" | partner == "Chile (including the Pacific Coast of Patagonia)" | partner == "Chili" | partner == "Chili (including the Pacific Coast of Patagonia)"

replace partner = "China" if partner == "China (exclusive of Hong Kong and Macao)"

replace partner = "Cochin China, Cambodia and Tonquin" if partner == "Cochin China, Cambodia, and Tonquin" | partner == "Cochin China, Camboja and Tonquin" | partner == "Cochin China, Camboja, and Tonque" | partner == "Cochin China, Camboja, and Tonquin" | partner == "Cochin China, Camboja, and Touquin" | partner == "Cochin China, Cambojs, and Tonquin"

replace partner = "Colombia" if partner == "Republic of Colombia" | partner == "United States of Colombia" | partner == "United States of Columbia (New Granada)"

* Congo Free States
* Costa Rica

replace partner = "Crete" if partner == "Turkey, Crete"

* 
* Cuba
* Cyprus

replace partner = "Danish West India Islands" if partner == "Danish" | partner == "Dutch West India Islands"

* Deep Sea Fisheries

replace partner = "Denmark" if partner == "Denmark (Including Faroe Islands)" | partner == "Denmark (including Faroe Islands)" | partner == "Denmark (including Faröe Islands)" | partner == "Iceland and Greenland" | partner == "Denmark (including Iceland and Greenland)" /*some years combine Denmark, Iceland, and Greenland but other separate them*/

replace partner = "Dutch Guiana" if partner == "Dutch Possessions in India: Dutch Guiana"

replace partner = "Java" if partner == "Dutch Possessions in the Indian Seas: Java" | partner == "Dutch Possessions in India: Java" | partner == "Java (Dutch Possessions in the Indian Seas)"

replace partner = "Dutch Possessions in India: Other Possessions in the Indian Seas" if partner == "Dutch Possessions in India: Other Possessions or Settlements in the Indian Seas" | partner == "Dutch Possessions or Settlements in the Indian Seas" | partner == "Dutch Possessions: Other Possessions or Settlements in the Indian Seas"

* Dutch West India Islands

replace partner = "Kenya" if partner == "East Africa Protectorate" | partner == "East Africa: East Africa Protectorate" | partner == "East Africa: Territories under British Influence (exclusive of Zanzibar and Pemba)" | partner == "Territories under British Influence (exclusive of Zanzibar and Pemba)" | partner == "Territories under British Influence in Eastern Africa (exclusive of Zanzibar and Pemba)"


* Eastern Bengal and Assam

replace partner = "Eastern Coast of Africa, Native States" if partner == "Eastern Coast of Africa: Native States" | partner == "Eastern Coast of Africa; Native States" | partner == "Eastern Coast of Africa—Native States"

* Ecuador

replace partner = "Egypt" if partner == "Turkish Dominions: Egypt"

replace partner = "European Turkey" if partner == "Turkish Dominions: European Turkey" | partner == "Turkey, European" /*combine both asiatic and european turkey*/

* Falkland Islands
* Federated Malay States

replace partner = "Fernando Po" if partner == "Spanish West Africa" | partner == "Spanish West Africa (including Fernando Po)" | partner == "Spanish Possessions in Western Africa (including Fernando Po)"

* France

replace partner = "French East Africa" if partner == "French Possessions in Eastern Africa"

* French Guiana

replace partner = "French Indo-China" if partner == "French Indo China, Cochin China, Cambodia, Annam, and Tonquin" | partner == "French Indo-China (Cochin China, Cambodia, Annam and Tonquin)" | partner == "French Indo-China (Cochin China, Cambodia, Annam, and Tonquin)" | partner == "French Indo-China (Cochin-China, Cambodia Annam and Tonquin)" | partner == "French Indo-China (Cochin-China, Cambodia, Anam, and Tonquin)" | partner == "French Indo-China (Cochin-China, Cambodia, Annam and Tonquin)" | partner == "French Indo-China (Cochin-China, Cambodia, Annam, and Tonquin)" | partner == "French Indo-China (Cochin-China, Camboia, Annam, and Tonquin)" | partner == "French Indo-China (Cochin-China, Cambois, Annam, and Tonquin)" | partner == "French Indo-China (Cochin-China, Camboja, Annam, and Tonquin)" | partner == "French Indo-china"

replace partner = "French Islands in the Pacific" if partner == "French Possessions in the Pacific"

* French Possessions in India

replace partner = "French Possessions in North America" if partner == "French Possessions in North Africa" | partner == "St. Pierre and Miquelon"

* French Possessions in Senegambia

replace partner = "French West Africa" if partner == "French Possessions in Western Africa"

* French Somaliland

replace partner = "French West India Islands" if partner == "French West Indies Island"

replace partner = "German East Africa" if partner == "German Possessions in Eastern Africa"

replace partner = "German West Africa" if partner == "German Possessions in Western Africa"

* German Possessions in the Pacific
* Germany
* Gibraltar
* Greece
* Guatemala
* Hawaii

replace partner = "Hayti and St. Domingo" if partner == "Hayti and San Domingo" | partner == "Hayti and the Dominican Republic"

* Heligoland

replace partner = "Netherlands" if partner == "Holland"

replace partner = "Honduras" if partner == "Honduras (not British)" | partner == "Honduras (not British.)"

* Hong Kong
* Islands in the Indian Seas

replace partner = "Islands in the Pacific" if partner == "Islands in the Pacific (exclusive of Fiji)" | partner == "Islands in the Pacific (not elsewhere specificed)" | partner == "Islands in the Pacific (not elsewhere specified)" | partner == "Islands in the Pacific (not elsewhere specified)" | partner == "Islands in the Pacific not elsewhere specified" | partner == "Islands in the Pacific, not elsewhere specified" | partner == "Islands in the pacific (not elsewhere specified)"

* Italian East Africa
* Italian Possessions in the Red Sea
* Italy

replace partner = "Japan" if partner == "Japan (including Formosa)"

* Korea
* Labuan
* Liberia
* Macao
* Madagascar
* Madeira

replace partner = "Madras" if partner == "British Possessions in India: Madras" | partner == "British India: Madras"

replace partner = "Malta and Goso" if partner == "Malta" | partner == "Malta and Gozo"

replace partner = "Mauritius" if partner == "Mauritius and Dependencies"

* Mexico
* Montenegro
* Morocco

replace partner = "Native Islands in the Indian Seas: Borneo" if partner == "Native Territories in the Indian Seas: Borneo"

* Native Islands in the Pacific

replace partner = "Territory of Papua" if partner == "New Guinea (British)" | partner == "German Possessions in New Guinea"

* Nicaragua

replace partner =  "Protectorate of Southern Nigeria" if partner == "The Colony and Protectorate of Southern Nigeria" | partner == "West Africa: Protectorate of Southern Nigeria" | partner == "Niger Protectorate" | partner == "Niger Protectorate (including Oil Rivers Protectorate)" | partner == "Niger Protectorate (including Oil Rivers Protectorate.)" /*these are the same things based on worldstatesmen.org*/ /*add the protectorate of northern nigeria to this*/ /*these are different from Lagos*/

replace partner = "Russia" if partner == "Northern Ports (Russia)" | partner == "Russia: Northern Ports" | partner == "Russia: Pacific Ports" | partner == "Russia: South Ports" | partner == "Russia: Southern Ports" | partner == "Southern Ports" | partner == "Southern Ports (Russia)"

* Norway
* Nyasaland Protectorate

replace partner = "United States of America" if partner == "On the Atlantic" | partner == "On the Pacific" | partner == "United States of America On the Atlantic" | partner == "United States of America On the Pacific" | partner == "United States of America: On the Atlantic" | partner == "United States of America: On the Pacific"

replace partner = "Other Dutch Possessions in the Indian Seas" if partner == "Other Dutch Possessions" | partner == "Other Dutch Possessions in the Indian Seas (except Dutch Borneo and Dutch New Guinea)" | partner == "Other Dutch Possessions in the Indian Seas (except Dutch Borneo) and Dutch New Guinea" | partner == "Other Dutch Possessions in the Indian Seas (except Dutch New Guinea)"

replace partner = "Native Territories in the Indian Seas: Other Islands" if partner == "Other Islands" | partner == "Native Islands in the Indian Seas (exclusive of Borneo)" | partner == "Native Territories in the Indian Seas (exclusive of Borneo)"

replace partner = "Other Possessions in the Indian Seas" if partner == "Other Possessions or Settlements in the Indian Seas"

* Other Islands in the Pacific (British)

replace partner = "Other Territories under British Influence" if partner == "Other Territories under British influence"

* Panama
* Paraguay
* Patagonia /*this was later divided between Chiel and Argentina circa 1883 (WorldStatesmen)*/
* Persia
* Peru
* Philippine Islands and Guam

replace partner = "Philippine and Ladrone Islands" if partner == "Philippine and Ladrone Islands (Spanish Possessions in India)" | partner == "Spanish Possessions in India: Philippine and La Irons Islands" | partner == "Spanish Possessions in India: Philippine and Ladrone Islands" | partner == "Spanish Possessions in India: Philippines and Ladrone Islands" | partner == "Spanish Possessions in India: Phillippine and Ladrone Islands" | partner == "Spanish Possessions in India: Phillippino and Ladrono Islands" | partner == "Spanish Possessions in the Indian Seas: Philippine and Ladrone Islands" | partner == "Spanish Possessions in India: Caroline and Ladrone Islands"

* Porto Rico
* Portugal

replace partner = "Portuguese East Africa" if partner == "Portuguese Possessions in Eastern Africa" | partner == "Portuguese Possessions on the Eastern Coast of Africa"

replace partner = "Portuguese India" if partner == "Portuguese Possessions in India"

replace partner = "Portuguese West Africa" if partner == "Portuguese Possessions in Western Africa" 

* Portuguese Possessions in the Indian Seas /*this is different from Portuguese possessions in India*/

* Protectorate of Northern Nigeria
* Roumania
* San Salvador

replace partner = "Seychelles" if partner == "Seychelles Islands"

* Siam
* Singapore and the Eastern Straits Settlements
* Spain

replace partner = "Spanish Ports in North Africa" if partner == "Spanish Ports in Northern Africa"

replace partner = "Straits Settlements" if partner == "Straits Settlements and Dependencies" | partner == "Straits Settlements and Dependencies (including Labuan)" | partner == "Straits Settlements and Dependencies including Labuan" | partner == "Straits Settlements and Dependencies, including Labuan" | partner == "British Possessions in India: Straits Settlements" | partner == "Singapore and the Eastern Straits Settlements" /*this is a combination of countries [ref: worldstatesmen.org]*/

* Spanish West India Islands
* St. Helena
* Sweden

replace partner = "Tripoli and Tunis" if partner == "TripolI" | partner == "Tripoli" | partner == "Tunis"

replace partner = "Turkey" if partner == "Asiatic Turkey" | partner == "European Turkey" | partner == "Crete"

replace partner = "Wallachia and Moldavia" if partner == "Turkish Dominions: Wallachia and Moldavia"

* Uruguay
* Venezuela

replace partner = "Weihaiwei" if partner == "Weihaiwel"

replace partner = "West Africa Settlements (British Possessions on the River Gambia and Sierra Leone)" if partner == "West African Settlements (British Possessions on the River Gambia and Sierra Leone)"

replace partner = "West Africa, not particularly designated" if partner == "Western C. of Africa, not particularly designated" | partner == "Western Coast of Africa (not particularly described)" | partner == "Western Coast of Africa not particularly designated" | partner == "Western Coast of Africa, not particularly designated" | partner == "Western Coast of Africa; not particularly designated"

replace partner = "Whale Fisheries: Northern" if partner == "Whale Fisheries Northern" | partner == "Whale Fisheries"

* Whale Fisheries: Southern



*************************************
**** ---- Getting the codes ---- ****
*************************************

gen partner_code = .
replace partner_code = 681 if partner == "Aden"
replace partner_code = 530 if partner == "Abyssinia"
replace partner_code = 615 if partner == "Algeria"
replace partner_code = 698 if partner == "Arabia: Muscat"
replace partner_code = 10001 if partner == "Arabia: States not separately enumerated" /*this is same as Arabia [reference: Pascali Luigi (map)]*/

replace partner_code = 160 if partner == "Argentine Republic"
replace partner_code = 4070 if partner == "Ascension"

* replace partner_code = 902 if partner == "West Australia"
* replace partner_code = 904 if partner == "Victoria"
* replace partner_code = 901 if partner == "New South Wales"
* replace partner_code = 905 if partner == "Queensland"
* replace partner_code = 903 if partner == "South Australia"
* replace partner_code = 906 if partner == "Tasmania"

replace partner_code = 900 if partner == "Australia"
replace partner_code = 300 if partner == "Austria-Hungary"
replace partner_code = 400 if partner == "Azores"
replace partner_code = 31 if partner == "Bahamas"
replace partner_code = 211 if partner == "Belgium"
replace partner_code = 80 if partner == "Belize"

replace partner_code = 1111111 if partner == "Bengal and Burmah"
* Bengal and Burmah

replace partner_code = 30 if partner == "Bermuda"
replace partner_code = 145 if partner == "Bolivia"

replace partner_code = 1111112 if partner == "Bombay"
* Bombay

replace partner_code = 140 if partner == "Brasil"

replace partner_code = 1111113 if partner == "British Borneo"
* British Borneo

replace partner_code = 1027 if partner == "British Columbia and Vancouver's Island"
replace partner_code = 110 if partner == "British Guiana"

replace partner_code = 1024 if partner == "British North America: Prince Edward Island"
*replace partner_code = 4781 if partner == "British Possessions and Protectorates in Western Africa: Lagos"

replace partner_code = 1111114 if partner == "British West India Islands"
* British West India Islands

replace partner_code = 355 if partner == "Bulgaria"
replace partner_code = 20 if partner == "Canada"
replace partner_code = 410 if partner == "Canary Islands"
replace partner_code = 89 if partner == "Central America"
replace partner_code = 780 if partner == "Ceylon"
replace partner_code = 2003 if partner == "Channel Islands"
replace partner_code = 155 if partner == "Chile"
replace partner_code = 710 if partner == "China"
replace partner_code = 8151 if partner == "Cochin China, Cambodia and Tonquin"
replace partner_code = 100 if partner == "Colombia"
replace partner_code = 484 if partner == "Congo Free State"
replace partner_code = 94 if partner == "Costa Rica"
*replace partner_code = 351 if partner == "Crete"
replace partner_code = 40 if partner == "Cuba"
replace partner_code = 352 if partner == "Cyprus"
replace partner_code = 5 if partner == "Danish West India Islands"

replace partner_code = 1111115 if partner == "Deep Sea Fisheries"
* Deep Sea Fisheries

replace partner_code = 390 if partner == "Denmark"

replace partner_code = 1111116 if partner == "Dutch Borneo"
* Dutch Borneo

replace partner_code = 115 if partner == "Dutch Guiana"

replace partner_code = 1111117 if partner == "Dutch Possessions in India: Other Possessions in the Indian Seas"
* Dutch Possessions in India: Other Possessions in the Indian Seas

replace partner_code = 1111118 if partner == "Eastern Bengal and Assam"
* Eastern Bengal and Assam

replace partner_code = 1111119 if partner == "Eastern Coast of Africa, Native States"
* Eastern Coast of Africa, Native States

replace partner_code = 130 if partner == "Ecuador"
replace partner_code = 651 if partner == "Egypt"
replace partner_code = 1163 if partner == "Falkland Islands"
replace partner_code = 821 if partner == "Federated Malay States"
replace partner_code = 413 if partner == "Fernando Po"
replace partner_code = 950 if partner == "Fiji"
replace partner_code = 220 if partner == "France"

replace partner_code = 1111120 if partner == "French East Africa"
* French East Africa

replace partner_code = 120 if partner == "French Guiana"
replace partner_code = 810 if partner == "French Indo-China"

replace partner_code = 1111121 if partner == "French Islands in the Pacific"
* French Islands in the Pacific

replace partner_code = 751 if partner == "French Possessions in India"

replace partner_code = 1111122 if partner == "French Possessions in North America"
* French Possessions in North America

replace partner_code = 1111123 if partner == "French Possessions in Senegambia"
* French Possessions in Senegambia

replace partner_code = 522 if partner == "French Somaliland"
replace partner_code = 430 if partner == "French West Africa"

replace partner_code = 1111124 if partner == "French West India Islands"
* French West India Islands

replace partner_code = 420 if partner == "Gambia"
replace partner_code = 510 if partner == "German East Africa"
*replace partner_code = 912 if partner == "German Possessions in New Guinea"

replace partner_code = 1111125 if partner == "German Possessions in the Pacific"
* German Possessions in the Pacific

replace partner_code = 1111126 if partner == "German West Africa"
* German West Africa

replace partner_code = 255 if partner == "Germany"
replace partner_code = 231 if partner == "Gibraltar"
replace partner_code = 452 if partner == "Gold Coast"

replace partner_code = 350 if partner == "Greece"
replace partner_code = 90 if partner == "Guatemala"
replace partner_code = 4 if partner == "Hawaii"

replace partner_code = 1111128 if partner == "Hayti and St. Domingo"
* Hayti and St. Domingo

replace partner_code = 2249 if partner == "Heligoland"
replace partner_code = 91 if partner == "Honduras"
replace partner_code = 720 if partner == "Hong Kong"

replace partner_code = 1111129 if partner == "Islands in the Indian Seas"
* Islands in the Indian Seas

replace partner_code = 1111130 if partner == "Islands in the Pacific"
* Islands in the Pacific

replace partner_code = 5201 if partner == "Italian East Africa"

replace partner_code = 1111131 if partner == "Italian Possessions in the Red Sea"
* Italian Possessions in the Red Sea

replace partner_code = 325 if partner == "Italy"
replace partner_code = 740 if partner == "Japan"

replace partner_code = 1111132 if partner == "Java"
* Java

replace partner_code = 501 if partner == "Kenya"
replace partner_code = 730 if partner == "Korea"
replace partner_code = 8231 if partner == "Labuan"
*replace partner_code = 4781 if partner == "Lagos"
replace partner_code = 450 if partner == "Liberia"
replace partner_code = 721 if partner == "Macao"
replace partner_code = 580 if partner == "Madagascar"
replace partner_code = 401 if partner == "Madeira"

replace partner_code = 1111133 if partner == "Madras"
* Madras

replace partner_code = 338 if partner == "Malta and Goso"
* Malta and Goso

replace partner_code = 590 if partner == "Mauritius"
replace partner_code = 70 if partner == "Mexico"
replace partner_code = 341 if partner == "Montenegro"
replace partner_code = 602 if partner == "Morocco"

replace partner_code = 1111135 if partner == "Native Islands in the Indian Seas: Borneo"
* Native Islands in the Indian Seas: Borneo

replace partner_code = 1111136 if partner == "Native Islands in the Pacific"
* Native Islands in the Pacific

replace partner_code = 1111137 if partner == "Native Territories in the Indian Seas: Other Islands"
* Native Territories in the Indian Seas: Other Islands

replace partner_code = 210 if partner == "Netherlands"
replace partner_code = 901 if partner == "New South Wales"
replace partner_code = 920 if partner == "New Zealand"
replace partner_code = 93 if partner == "Nicaragua"
replace partner_code = 385 if partner == "Norway"

replace partner_code = 1111138 if partner == "Nyasaland Protectorate"
* Nyasaland Protectorate

replace partner_code = 1111139 if partner == "Other Dutch Possessions in the Indian Seas"
* Other Dutch Possessions in the Indian Seas

replace partner_code = 1111140 if partner == "Other Islands in the Pacific (British)"
* Other Islands in the Pacific (British)

replace partner_code = 1111141 if partner == "Other Possessions in the Indian Seas"
* Other Possessions in the Indian Seas

replace partner_code = 1111142 if partner == "Other Territories under British Influence"
* Other Territories under British Influence

replace partner_code = 95 if partner == "Panama"
replace partner_code = 150 if partner == "Paraguay"

replace partner_code = 1111143 if partner == "Patagonia"
* Patagonia /*became a part of Chile and Argentina after 1880*/

replace partner_code = 630 if partner == "Persia"
replace partner_code = 135 if partner == "Peru"

replace partner_code = 1111144 if partner == "Philippine Islands and Guam"
* Philippine Islands and Guam

replace partner_code = 1111145 if partner == "Philippine and Ladrone Islands"
* Philippine and Ladrone Islands

replace partner_code = 1111146 if partner == "Portuguese Possessions in the Indian Seas"
* Portuguese Possessions in the Indian Seas

replace partner_code = 6 if partner == "Porto Rico"
replace partner_code = 235 if partner == "Portugal"
replace partner_code = 541 if partner == "Portuguese East Africa"
replace partner_code = 752 if partner == "Portuguese India"
replace partner_code = 540 if partner == "Portuguese West Africa"
replace partner_code = 4784 if partner == "Protectorate of Northern Nigeria"
replace partner_code = 4783 if partner == "Protectorate of Southern Nigeria"
replace partner_code = 585 if partner == "Reunion"
replace partner_code = 360 if partner == "Roumania"
replace partner_code = 365 if partner == "Russia"
replace partner_code = 92 if partner == "San Salvador"
replace partner_code = 591 if partner == "Seychelles"
replace partner_code = 800 if partner == "Siam"
replace partner_code = 451 if partner == "Sierra Leone"
replace partner_code = 560 if partner == "South Africa"
replace partner_code = 230 if partner == "Spain"

replace partner_code = 1111147 if partner == "Spanish Ports in North Africa"
* Spanish Ports in North Africa

replace partner_code = 1111148 if partner == "Spanish West Africa"
* Spanish West Africa

replace partner_code = 1111149 if partner == "Spanish West India Islands"
* Spanish West India Islands

replace partner_code = 4050 if partner == "St. Helena"
replace partner_code = 1029 if partner == "St. Pierre and Miquelon"
replace partner_code = 827 if partner == "Straits Settlements"
replace partner_code = 380 if partner == "Sweden"
replace partner_code = 911 if partner == "Territory of Papua" /*added british and german new guinea*/
replace partner_code = 616 if partner == "Tripoli and Tunis" /*add Tripoli and Tunis from the RICardo data and give it a number*/

replace partner_code = 640 if partner == "Turkey"
replace partner_code = 2 if partner == "United States of America"
replace partner_code = 165 if partner == "Uruguay"
replace partner_code = 101 if partner == "Venezuela"

replace partner_code = 1111150 if partner == "Wallachia and Moldavia"
* Wallachia and Moldavia

replace partner_code = 7105 if partner == "Weihaiwei"

replace partner_code = 1111151 if partner == "West Africa Settlements (British Possessions on the River Gambia and Sierra Leone)"
* West Africa Settlements (British Possessions on the River Gambia and Sierra Leone)

replace partner_code = 1111152 if partner == "West Africa, not particularly designated"
* West Africa, not particularly designated

replace partner_code = 1111153 if partner == "Whale Fisheries: Northern"
* Whale Fisheries: Northern

replace partner_code = 1111154 if partner == "Whale Fisheries: Southern"
* Whale Fisheries: Southern

replace partner_code = 1111155 if partner == "Zanzibar and Pemba"
* Zanzibar and Pemba

*****************************************************
***** ----- Getting rid of the duplicates ----- *****
*****************************************************

gen reporting_code = 200
gen id = string(reporting_code) + "_" + string(partner_code) + "_" + string(year)
replace id = "" if partner_code == .
drop if partner_code == .

* some country pair have duplicates and 1 of them is 0 while the other has the data
bysort year partner reporting: egen sum_ss_vessels_import = total(ss_vessels_import)
bysort year partner reporting: egen sum_ss_tons_import = total(ss_tons_import)
bysort year partner reporting: egen sum_s_vessels_import = total(s_vessels_import)
bysort year partner reporting: egen sum_s_tons_import = total(s_tons_import)
bysort year partner reporting: egen sum_ss_vessels_export = total(ss_vessels_export)
bysort year partner reporting: egen sum_ss_tons_export = total(ss_tons_export)
bysort year partner reporting: egen sum_s_vessels_export = total(s_vessels_export)
bysort year partner reporting: egen sum_s_tons_export = total(s_tons_export)

* Replace the original variables with the summed versions
replace ss_vessels_import = sum_ss_vessels_import
replace ss_tons_import = sum_ss_tons_import
replace s_vessels_import = sum_s_vessels_import
replace s_tons_import = sum_s_tons_import
replace ss_vessels_export = sum_ss_vessels_export
replace ss_tons_export = sum_ss_tons_export
replace s_vessels_export = sum_s_vessels_export
replace s_tons_export = sum_s_tons_export

* Remove the temporary sum variables
drop sum_ss_vessels_import sum_ss_tons_import sum_s_vessels_import sum_s_tons_import sum_ss_vessels_export sum_ss_tons_export sum_s_vessels_export sum_s_tons_export

* Keep only one row for every unique combination
duplicates drop year partner reporting, force

*** --- Merge with ISO GPH crosswalk --- ***
/*just for the iso code*/
merge m:1 partner_code using "$cepii/crosswalk.dta", keep(1 3)
drop _merge

*** -- Getting the iso codes that do not exist from the crosswalk
foreach x in "Arabia: States not separately enumerated" "Ascension" "Bengal and Burmah" ///
"Bombay" "British Borneo" "British Columbia and Vancouver's Island" ///
"British West India Islands" "Central America" "Channel Islands" ///
"Cochin China, Cambodia and Tonquin" ///
"Deep Sea Fisheries" "Dutch Borneo" "Dutch Possessions in India: Other Possessions in the Indian Seas" ///
"Eastern Bengal and Assam" "Eastern Coast of Africa, Native States" "Fernando Po" "French East Africa" ///
"French Islands in the Pacific" "French Possessions in India" "French Possessions in North America" ///
"French Possessions in Senegambia" "French West India Islands" "German East Africa" ///
"German Possessions in the Pacific" "German West Africa" ///
"Hawaii" "Hayti and St. Domingo" "Heligoland" "Islands in the Indian Seas" ///
"Islands in the Pacific" "Italian Possessions in the Red Sea" "Java" "Labuan" "Madras" ///
"Native Islands in the Indian Seas: Borneo" "Native Islands in the Pacific" ///
"Native Territories in the Indian Seas: Other Islands" "Nyasaland Protectorate" ///
"Other Dutch Possessions in the Indian Seas" "Other Islands in the Pacific (British)" ///
"Other Possessions in the Indian Seas" "Other Territories under British Influence" "Patagonia" ///
"Philippine Islands and Guam" "Philippine and Ladrone Islands" "Portuguese Possessions in the Indian Seas" ///
"Protectorate of Northern Nigeria" "Protectorate of Southern Nigeria" "Roumania" "Spanish Ports in North Africa" ///
"Spanish West Africa" "Spanish West India Islands" "Turkey" "Wallachia and Moldavia" "Weihaiwei" ///
"West Africa Settlements (British Possessions on the River Gambia and Sierra Leone)" ///
"West Africa, not particularly designated" "Whale Fisheries: Northern" "Whale Fisheries: Southern" ///
"Zanzibar and Pemba" {
	quietly replace partner_iso = "`x'" if partner == "`x'"
}

gen ID = reporting_iso + partner_iso + string(year)

* save the final data
save "$data/clean_data.dta", replace

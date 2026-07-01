library(tidyverse)
library(haven)
library(here)
library(janitor)

file_paths = list.files(path = here(), pattern = "RICardo.*\\.csv$", ignore.case = TRUE, full.names = TRUE)

# this data does not have the partner_code
combined_data = file_paths %>%
  set_names(basename(.)) %>% 
  map_df(~read_csv(.x, col_types = cols(.default = "c")), .id = "filename") %>% 
  type_convert() %>%
  clean_names()

combined_data = combined_data %>%
  select(-any_of(c("partner_type", "ric_type", "continent", "gph_code", "gph_dot_code"))) %>%
  mutate(match_key = str_to_lower(str_replace_all(partner, "[^[:alnum:]]", "")))

length(unique(combined_data$partner)) # there is 115 distinct partners here (the UK was excluded in the STATA)
unique(combined_data$partner)

combined_data = combined_data %>%
  mutate(total_trade = import + export) %>%
  mutate(diff = total_trade - total) 

# load the codes data
codes = read.csv(here("codes.csv"))
unique(codes$GPH.code)
length(unique(na.omit(codes$GPH.code)))
length(unique(codes$GPH.code)) # there are 486 eith NA's and not merged yet
#codes$RICname[is.na(codes$GPH.code)]

codes = codes %>%
  rename(ric_name = any_of(c("RICname", "RICName", "ricname", "RIC Name", "ric_name"))) %>%
  rename(ric_type = any_of(c("RICtype", "RICType", "rictype", "RIC Type", "ric_type"))) %>%
  rename(gph_code = any_of(c("GPH.code", "GPH code", "GPHcode", "gph_code"))) %>%
  mutate(match_key = str_to_lower(str_replace_all(ric_name, "[^[:alnum:]]", ""))) %>%
  select(match_key, ric_name, ric_type, continent, gph_code) %>%
  distinct(match_key, .keep_all = TRUE)

# join both data 
final_data = combined_data %>%
  left_join(codes, by = "match_key") %>%
  mutate(partner = coalesce(ric_name, partner)) %>%
  select(-ric_name, -filename)

final_data = final_data %>%
  as.data.frame() %>%
  lapply(function(x) {
    if (is.character(x)) {
      x <- iconv(x, to = "UTF-8", sub = "") 
    }
    attributes(x) <- NULL 
    return(x)
  }) %>%
  as_tibble() 

final_data = final_data %>%
  type_convert() %>%
  mutate(across(where(is.logical), as.numeric)) %>%
  clean_names()

write_csv(final_data, here("data.csv"), na = "")

## the number of countries
# n_distinct(codes$ric_name[!is.na(codes$gph_code)])

# codes_only = codes %>%
#  filter(!is.na(gph_code)) %>%
#  distinct(ric_name, gph_code)
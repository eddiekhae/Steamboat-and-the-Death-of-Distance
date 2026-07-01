################################################
#### ---- Combining the data from ASNS ---- #### 
################################################

library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)
library(writexl)

# 1. SETTINGS
folder_path = "/Volumes/Edward HDD Main/Thesis/data/ASNS/excel/"

file_list = list.files(path = folder_path, pattern = "\\d{4} data\\.xlsx$", full.names = TRUE)
file_list = file_list[!grepl("~\\$", file_list)] 

file_years = as.numeric(str_extract(basename(file_list), "\\d{4}"))
file_list = file_list[file_years >= 1871 & file_years <= 1913]

# --- CLEANING FUNCTION ---
clean_name = function(x) {
  x %>% 
    as.character() %>% 
    str_replace_all("\\*", "") %>%  
    str_squish() %>%                
    str_remove("\\.+$") %>%         
    str_squish()               
}

# --- DYNAMIC PROCESSING FUNCTION ---
process_trade_file = function(file_path) {
  
  current_year = as.numeric(str_extract(basename(file_path), "\\d{4}"))
  message(paste("Processing Year:", current_year))
  
  raw_data = read_excel(file_path, skip = 1)
  col_names = tolower(colnames(raw_data))
  country_cols = which(str_detect(col_names, "country"))
  
  # HELPER: Extract specific blocks and CREATE Importer/Exporter columns
  extract_trade_block = function(data, country_index_num, v_col_name, t_col_name, direction = "import") {
    
    # We define the expected columns immediately to ensure they exist even if the block is empty
    if (length(country_cols) >= country_index_num) {
      idx <- country_cols[country_index_num]
      end_idx <- min(idx + 2, ncol(data))
      
      df_temp <- data[, idx:end_idx]
      # Temporary name for the first column which contains the country name
      colnames(df_temp) = c("partner_name", v_col_name, t_col_name)[1:ncol(df_temp)]
      
      df_temp <- df_temp %>%
        mutate(partner_name = clean_name(partner_name)) %>%
        filter(!is.na(partner_name), 
               !grepl("Total", partner_name, ignore.case = TRUE), 
               suppressWarnings(is.na(as.numeric(partner_name))))
      
      if(nrow(df_temp) == 0) return(NULL)
      
      # CREATE THE COLUMNS BASED ON DIRECTION
      if(direction == "import") {
        # If it's an import block: UK is receiving, Partner is sending
        df_temp <- df_temp %>% 
          mutate(importer = "United Kingdom", 
                 exporter = partner_name)
      } else {
        # If it's an export block: Partner is receiving, UK is sending
        df_temp <- df_temp %>% 
          mutate(importer = partner_name, 
                 exporter = "United Kingdom")
      }
      
      # Select only the relevant columns to ensure consistency for bind_rows
      return(df_temp %>% select(importer, exporter, all_of(v_col_name), all_of(t_col_name)))
      
    } else {
      return(NULL)
    }
  }
  
  # A. Extract the 4 distinct tables
  # Note: The column names here will become the 8 final data columns
  ss_imp <- extract_trade_block(raw_data, 1, "ss_vessels_import", "ss_tons_import", direction = "import")
  ss_exp <- extract_trade_block(raw_data, 2, "ss_vessels_export", "ss_tons_export", direction = "export")
  s_imp  <- extract_trade_block(raw_data, 3, "s_vessels_import", "s_tons_import", direction = "import")
  s_exp  <- extract_trade_block(raw_data, 4, "s_vessels_export", "s_tons_export", direction = "export")
  
  # B. Combine all blocks
  # bind_rows handles NULLs automatically and keeps all unique column names
  combined_df <- bind_rows(ss_imp, ss_exp, s_imp, s_exp)
  
  # Check if we actually got any data (prevents the group_by error)
  if(is.null(combined_df) || nrow(combined_df) == 0) {
    return(NULL)
  }
  
  # Ensure all trade columns exist before numeric conversion (in case a file was missing a section)
  target_cols <- c("ss_vessels_import", "ss_tons_import", "ss_vessels_export", "ss_tons_export",
                   "s_vessels_import", "s_tons_import", "s_vessels_export", "s_tons_export")
  
  for(col in target_cols) {
    if(!(col %in% names(combined_df))) combined_df[[col]] <- NA
  }
  
  final_df <- combined_df %>%
    mutate(year = current_year) %>%
    # Clean numeric data (remove commas/chars)
    mutate(across(all_of(target_cols), 
                  ~as.numeric(gsub("[^0-9.]", "", as.character(.))))) %>%
    # Replace NAs with 0 for summation
    mutate(across(where(is.numeric), ~replace_na(., 0))) %>%
    # Group by the keys we created
    group_by(year, importer, exporter) %>%
    summarise(across(all_of(target_cols), sum, na.rm = TRUE), .groups = "drop")
  
  return(final_df)
}

# ---------------------------------------------------------
# 2. EXECUTE & REFORMAT
# ---------------------------------------------------------
# First, get the raw processed data
raw_master <- map_dfr(file_list, process_trade_file)

# Now, transform it to the "Reporting/Partner" format
master_database <- raw_master %>%
  mutate(
    reporting = "United Kingdom",
    # Logic: if UK is the importer, the other guy is the partner. 
    # If UK is exporter, the other guy is the partner.
    partner = if_else(importer == "United Kingdom", exporter, importer)
  ) %>%
  # Remove the old direction columns
  select(-importer, -exporter) %>%
  # Relocate columns to match the second picture's style
  select(reporting, partner, year, everything()) %>%
  # Group by year and partner to merge the Import and Export rows together
  group_by(reporting, partner, year) %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE), .groups = "drop") %>%
  # Sorting
  arrange(year, partner)

# 3. VIEW RESULT
View(master_database)

# write to excel 
write_xlsx(master_database, path = "/Volumes/Edward HDD Main/Thesis/data/ASNS/excel/data.xlsx")
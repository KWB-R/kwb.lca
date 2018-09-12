#kwb.package::updateKwbPackages("kwb.lca")
#install.packages("openxlsx")

library("kwb.utils")

setwd(safePath(desktop(), "tmp"))

# MAIN -------------------------------------------------------------------------
if (FALSE)
{
  file_in <- "SMART-Plant_LCA_data_Karmiel_v0.3.1.xlsx"
  file_out <- "SMART-Plant_LCA_data_Karmiel_v0.3.1_simple.xlsx"

  # Read LCA parameters from Excel file into R data frame
  lca <- kwb.lca::read_lca_parameters_from_xls(file_in, country = "en")

  # Write data frame to CSV file
  csv_file <- "SMART-Plant_LCA_data_Karmiel_long.csv"

  write.csv(lca, file = csv_file, row.names = FALSE, na = "")

  # Reread the CSV file and check the content
  lca_reread <- read.csv(csv_file)

  kwb.utils::catLines(readLines(csv_file, 4))

  View(lca_reread)

  # Write data frame to an Excel file
  kwb.lca:::save_lca_parameters_to_xlsx(lca, file_out, overwrite = TRUE)
}

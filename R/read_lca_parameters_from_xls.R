# read_lca_parameters_from_xls -------------------------------------------------

#' Read LCA Parameters from an Excel File
#' 
#' @param file path to the Excel file to be read
#' @param country country code: "de" for German or "en" for "English". Required
#'   to convert the text values in the Value columns
#'   
#' @export
#'  
read_lca_parameters_from_xls <- function(file, country = "de")
{
  file <- kwb.utils::safePath(file)
  
  all_matrices <- kwb.readxl:::get_text_tables_from_xlsx(file)
  
  lca_matrices <- all_matrices[sapply(all_matrices, is_lca_text_matrix)]
  
  stopifnot(all(sapply(lca_matrices, has_lca_matrix_format)))
  
  data_frames <- lapply(lca_matrices, get_named_table)
  
  data_frames <- lapply(data_frames, kwb.utils::removeColumns, "Remarks")
  
  data_frames_long <- lapply(data_frames, convert_wide_lca_table_to_long_format)
  
  lca <- kwb.utils::rbindAll(data_frames_long, nameColumn = "Source")
  
  lca$Variable <- gsub("_\\d+$", "", lca$Variable)
  
  lca$Source <- gsub("^([^.]+)[.].*$", "\\1", lca$Source)
  
  `%>%` <- magrittr::`%>%`
  
  sheet_info <- kwb.readxl:::get_sheet_info(all_matrices)
  
  result <- merge(lca, sheet_info, by.x = "Source", by.y = "sheet_id") %>% 
    kwb.utils::renameColumns(list(sheet_name = "Sheet")) %>%
    kwb.utils::removeColumns("Source") %>%
    kwb.utils::moveColumnsToFront("Sheet") 
  
  result$Value <- kwb.utils::hsChrToNum(
    result$Value, country, stopOnError = FALSE
  )
  
  result
}

# is_lca_text_matrix -----------------------------------------------------------
is_lca_text_matrix <- function(text_matrix)
{
  kwb.utils::defaultIfNA(text_matrix[1, 1], "") == "T"
}

# has_lca_matrix_format ------------------------------------------------------
has_lca_matrix_format <- function(lca_matrix)
{
  tags <- kwb.utils::defaultIfNA(lca_matrix[, 1], "")
  
  has_only_one_T <- (sum(tags == "T") == 1)
  
  all_tags_expected <- all(tags %in% c("T", "H", "V", ""))
  
  has_only_one_T && all_tags_expected
}

# get_named_table --------------------------------------------------------------
get_named_table <- function(text_matrix)
{
  (x <- text_matrix[, -1, drop = FALSE])
  (n_headers <- sum(text_matrix[, 1] %in% c("T", "H")))
  (xx <- x[2:n_headers, , drop = FALSE])
  xx[is.na(xx) | xx == "x"] <- ""
  header <- unname(apply(xx, 2, kwb.utils::collapsed, "_"))
  header <- gsub("^ *_+ *| *_+ *$", "", header)
  is_value_column <- header != ""
  content <- x[-seq_len(n_headers), is_value_column]
  colnames(content) <- header[is_value_column]
  
  kwb.utils::noFactorDataFrame(Table = unname(text_matrix[1, 2]), content)
}

# convert_wide_lca_table_to_long_format ----------------------------------------
convert_wide_lca_table_to_long_format <- function(lca_table)
{
  keys <- c("Table", "Parameter", "Code", "Unit")
  
  kwb.utils::checkForMissingColumns(lca_table, keys)
  
  value_columns <- setdiff(names(lca_table), keys)
  
  if (! length(value_columns)) {
    
    kwb.utils::printIf(TRUE, kwb.utils::headtail(lca_table))
    
    stop("There are no value columns!")
  }
  
  kwb.utils::hsMatrixToListForm(
    lca_table, keyFields = keys, colNamePar = "Variable", colNameVal = "Value"
  )
}

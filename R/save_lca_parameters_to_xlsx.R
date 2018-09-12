# save_lca_parameters_to_xlsx --------------------------------------------------

#' Save LCA parameters to an Excel File
#'
#' @param lca data frame with lca parameters as returned by
#'   \code{\link{read_lca_parameters_from_xls}}
#' @param file path to Excel file to be written
#' @param overwrite it \code{TRUE} an existing file will be overwritten, passed
#'   to \code{\link[openxlsx]{saveWorkbook}}
#'
save_lca_parameters_to_xlsx <- function(lca, file, overwrite = FALSE)
{
  # Split data frame into sheets and separate blocks of data by a blank line
  sheet_contents <- split_lca_parameters_into_sheets(lca)

  workbook <- create_workbook_with_sheets(sheet_contents)

  openxlsx::saveWorkbook(workbook, file, overwrite = overwrite)
}

# split_lca_parameters_into_sheets ---------------------------------------------
split_lca_parameters_into_sheets <- function(lca)
{
  # Get sheet column
  sheets <- kwb.utils::selectColumns(lca, "Sheet")

  # Remove sheet column
  lca <- kwb.utils::removeColumns(lca, "Sheet")

  lapply(split(lca, sheets), function(x) {

    tables <- kwb.utils::selectColumns(x, "Table")

    kwb.utils::rbindAll(lapply(split(x, tables), function(xx) {

      kwb.utils::addRowWithName(xx, to_empty_row(xx), "emtpy_row")
    }))
  })
}

# to_empty_row -----------------------------------------------------------------
to_empty_row <- function(x)
{
  empty_row <- x[1, ]

  empty_row[1, ] <- NA

  empty_row
}

# create_workbook_with_sheets --------------------------------------------------
create_workbook_with_sheets <- function(sheet_contents)
{
  wb <- openxlsx::createWorkbook()

  sheets <- names(sheet_contents)

  for (sheet in sheets) {

    openxlsx::addWorksheet(wb, sheet)

    content <- sheet_contents[[sheet]]

    openxlsx::writeData(wb, sheet = sheet, x = content)

    cols <- seq_len(ncol(content))

    openxlsx::setColWidths(wb, sheet = sheet, cols = cols, widths = "auto")
  }

  wb
}

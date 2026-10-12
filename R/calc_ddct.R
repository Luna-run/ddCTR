#' @title Calculate delta-delta CT
#' @description Reads qPCR data from an Excel file and calculates
#'   dCT, ddCT, and relative expression using the ΔΔCT method.
#'
#' @param file Path to the Excel file
#' @param ref_gene Reference gene name (e.g. "EIF4B")
#' @param goi Gene of interest name (e.g. "NIT4A-2")
#' @param ctrl_line Control line name for ddCT calculation (e.g. "Ecf99")
#'
#' @return A data frame with columns: Sample, Line, dct, ddct, Expression
#' @export
#' @examples
#' # d3 <- calc_ddct("data.xlsx", "EIF4B", "NIT4A-2", "Ecf99")

calc_ddct <- function(file, ref_gene, goi, ctrl_line) {

  d <- readxl::read_excel(file) |>
    dplyr::filter(!is.na(Target)) |>
    dplyr::group_by(Sample, Target, Line) |>
    dplyr::summarise(CT_mean = mean(CT), .groups = "drop")

  Ref <- d |> dplyr::filter(Target == ref_gene)
  GOI <- d |> dplyr::filter(Target == goi)

  d2 <- Ref |>
    dplyr::left_join(GOI, by = "Sample") |>
    dplyr::mutate(dct = CT_mean.y - CT_mean.x)

  x <- d2 |>
    dplyr::filter(Line.x == ctrl_line) |>
    dplyr::summarise(mean_dct = mean(dct)) |>
    dplyr::pull(mean_dct)

  d2 |>
    dplyr::mutate(ddct = dct - x) |>
    dplyr::mutate(Expression = 2^(-ddct)) |>
    dplyr::rename(Line = Line.x) |>
    dplyr::select(Sample, Line, dct, ddct, Expression)
}

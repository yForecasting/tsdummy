#' diva_to_dits function
#'
#' Format from DIVA to DITS.
#'
#' The function converts from DIVA (Date Item Value Attributes) to DITS (Date
#' Item Table Structure, or Date Item TimeSeries) format.
#'
#' @param file Filename of csv file to read. Alternatively, a datatable is also
#'  taken.
#'
#' @param data Datatable to convert directly, without reading a .csv-file.
#'
#' @param sep Separator for the csv file: often , or ;
#'
#' @param start Start of time series in time series format: for monthly data
#' c(2025,12), for weekly data c(2025, 40), for daily data c(2025,11,25).
#'
#' @param frequency Frequency of the time series
#'
#' @param d Column name for date information
#'
#' @param i Column name for item information
#'
#' @param v Column name for value information
#'
#' @author Yves R. Sagaert
#'
#' @export
#'
#' @examples
#'  \dontrun{
#'     diva_to_dits("data.csv")
#'  }


diva_to_dits <- function(file="", data="",
                         sep=";", start=c(1,1), frequency=1,
                         d="yearweek", i="sku",
                         v="real_sales"){
  # Read data
  if (file==""){
    if (data==""){
      stop("Input data is missing.")
    }
  } else {
    if (methods::is(file,"data.frame")){
      data <- file
    } else {
      data <- utils::read.csv(file,sep=sep)
    }
  }

  # Untangle DIVA to DITS
  dat <- data[,c(d,i,v)]
  wide_data <- tidyr::pivot_wider(dat, names_from = i, values_from = v, values_fill = 0)
  wide_data <- dplyr::arrange(wide_data, d)
  wdat <- data.frame(wide_data)
  rownames(wdat) <- wdat[,d]
  wdat <- wdat[, -1]
  tdat <- stats::ts(wdat,start=start,frequency=frequency)

  return(tdat)


}

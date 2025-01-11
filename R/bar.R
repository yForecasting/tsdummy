#' bar function
#'
#' Tells a bar joke.
#'
#' This demo function tells a bar joke.
#'
#' @param ts Argument to specify number of datapoints. Numeric or string value
#' allowed.
#'
#' @author Yves R. Sagaert
#'
#' @export
#'
#' @examples
#'     bar(ts=3)


bar <- function(ts){
  select_joke <- stats::runif(1)>0.5
  if (select_joke){
    cat(paste0(ts, " time series walk into a bar. They walk to a table and",
    " ask: Can we join?. That depends, what features do you bring to the table?"))
  } else {
    cat(paste0(ts, " time series walk into a bar. They walk left to a table",
    " and ask: Can we join?. Absolutely not, but you are welcome to cbind."))
  }
}

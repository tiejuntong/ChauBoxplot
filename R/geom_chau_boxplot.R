#' Title: Chauvenet-type boxplot in ggplot2
#'
#'This function can be operated the same way as geom_boxplot() in ggplot2, except that the fence coefficient k=1.5
#'in Tukey's boxplot is replaced by the fence coefficient associated with Chauvenet’s criterion. For details,
#'please refer to formula (9) in Lin et al. (2025).
#'
#' @references Hongmei Lin, Riquan Zhang and Tiejun Tong (2025). When Tukey meets Chauvenet: a new boxplot criterion for outlier detection. Journal of Computational and Graphical Statistics, accepted.
#' @param mapping Aesthetic mappings created by `aes()`.
#' @param data The data to be displayed in this layer.
#' @param geom The geometric object to use for display.
#' @param position The position adjustment.
#' @param na.rm Logical. Should missing values be removed?
#' @param show.legend Logical. Should this layer be included in the legends?
#' @param inherit.aes If FALSE, overrides the default aesthetics.
#' @param ... Other arguments passed to the layer.
#' @return A ggplot2 layer with the Chauvenet-type boxplot.
#' @export
#' @importFrom stats qnorm
#' @importFrom graphics axis boxplot
#' @importFrom ggplot2 ggproto layer StatBoxplot
#' @examples
#' # Example 1
#' library(ggplot2)
#'
#' rate.senior <- c(4.96, 6.30, -5.38, 1.60, 7.24, 5.26, 2.55, 5.96, 3.96, 4.19, 1.88, 4.06, 4.75, 0, 0, 2.5, 2.87, 3.00)/100
#' year <- 2007:2024
#' data.senior <- data.frame(x=year, y=rate.senior)
#'
#' C.boxplot.senior <-
#' ggplot(data.senior, aes(y=rate.senior)) +
#' geom_chau_boxplot(fill="purple",width=3) +
#' theme(legend.position = "none") +
#' scale_x_discrete(breaks = NULL) +
#' ylim(-0.057,0.077) +
#' theme(plot.margin = unit(c(0, 0, 0, 0), "inches")) +
#' labs(title="C.boxplot", subtitle="Senior civil servants", x="", y="")
#'
#' print(C.boxplot.senior)


geom_chau_boxplot <- function(mapping = NULL, data = NULL, geom = "boxplot",
                      position = "dodge2", na.rm = FALSE, show.legend = NA,
                      inherit.aes = TRUE, ...) {

  # Nested helper function to calculate Chauvenet's coefficient
  .calculate_chau_coef <- function(n) {
    qnorm(1 - 0.25/n)/1.35 - 0.5
  }

  # Nested ggproto object for the custom stat
  StatChauBoxplot <- ggproto("StatChauBoxplot", StatBoxplot,
                          compute_group = function(data, scales, coef = .calculate_chau_coef(nrow(data))) {
                            StatBoxplot$compute_group(data, scales, coef = coef)
                          })

  layer(
    data = data,
    mapping = mapping,
    stat = StatChauBoxplot,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

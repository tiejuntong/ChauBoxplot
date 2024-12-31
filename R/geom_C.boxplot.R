library(ggplot2)

geom_C.boxplot <- function(mapping = NULL, data = NULL, geom = "boxplot",
                      position = "dodge2", na.rm = FALSE, show.legend = NA,
                      inherit.aes = TRUE, ...) {
  
  # Nested helper function to calculate Chauvenet's coefficient
  .calculate_chauvenet_coef <- function(n) {
    qnorm(1 - 0.25 / n) / 1.35 - 0.5
  }
  
  # Nested ggproto object for the custom stat
  StatCboxplot <- ggproto("StatCboxplot", StatBoxplot,
                          compute_group = function(data, scales, coef = .calculate_chauvenet_coef(nrow(data))) {
                            StatBoxplot$compute_group(data, scales, coef = coef)
                          })
  
  layer(
    data = data,
    mapping = mapping,
    stat = StatCboxplot,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      outlier.colour = outlier.colour,
      outlier.shape = outlier.shape,
      outlier.size = outlier.size,
      ...
    )
  )
}

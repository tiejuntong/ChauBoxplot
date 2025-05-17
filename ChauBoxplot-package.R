#' ChauBoxplot: Chauvenet-type boxplot
#'
#' This package provides a modified boxplot with the new fence coefficient determined by Lin et al. (2025). Specifically, the fence coefficient k=1.5 in Tukey's boxplot has been replaced by the fence coefficient associated with Chauvenet's criterion in their formula (9). The Chauvenet-type boxplot can be implemented in base R with function chau_boxplot(), and in ggplot2 with function geom_chau_boxplot().
#'
#' @references
#' Hongmei Lin, Riquan Zhang and Tiejun Tong (2025). When Tukey meets Chauvenet: a new boxplot criterion for outlier detection. Journal of Computational and Graphical Statistics, accepted.
#'
"_PACKAGE"


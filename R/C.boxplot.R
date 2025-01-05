C.boxplot <- function(data, group_col = NULL, value_col = NULL, ...) {
  
  # Determine data type and extract values
  if (!is.null(group_col) && !is.null(value_col) && is.data.frame(data)) { # Grouped data (data frame)
    values <- data[[value_col]]
    group <- factor(data[[group_col]])
  } else if (is.null(group_col) && is.null(value_col)) { # Single group (vector or single-column data frame)
    if (is.numeric(data)) {
      values <- data
    } else if (is.data.frame(data) && ncol(data) == 1 && is.numeric(data[, 1])) {
      values <- data[, 1]
    } else {
      stop("For single-group data, provide a numeric vector or a single-column data frame with numeric values.")
    }
    group <- NULL  # No grouping for single data
  } else {
    stop("Incorrect data format or arguments.  Provide a numeric vector/data frame for single-group or a data frame with 'group_col' and 'value_col' for grouped data.")
  }
  
  
  # Calculate the Chauvenet-type ranges (if grouped)
  if (!is.null(group)) {
    Chauvenet_ranges <- tapply(values, group, function(x) {
      n <- length(x)
      qnorm(1 - 0.25/n) / 1.35 - 0.5
    })
  } else {
    n <- length(values)
    Chauvenet_range <- qnorm(1 - 0.25/n) / 1.35 - 0.5
  }
  
  # Create the boxplot
  if (!is.null(group)) { # Grouped plot
    plot(NULL, xlim = c(0.5, length(levels(group)) + 0.5), ylim = range(values, na.rm = TRUE),
         xaxt = "n", xlab = group_col, ylab = value_col, main = "Chauvenet-type Boxplot")
    axis(1, at = 1:length(levels(group)), labels = levels(group))
    
    for (i in 1:length(levels(group))) {
      group_name <- levels(group)[i]
      group_data <- values[group == group_name]
      boxplot(group_data, at = i, range = Chauvenet_ranges[group_name], add = TRUE, names = "", ...)
    }
  } else { # Single group plot
    boxplot(values, range = Chauvenet_range, outpch = 19, main = "Chauvenet-type Boxplot", ...)
  }
}

---
title: "ChauBoxplot Package"
---

## ChauBoxplot

`ChauBoxplot` is an R package designed to create an improved version of the boxplot. This package implements a new fence coefficient proposed by Lin et al. (2025), replacing the traditional fence coefficient \(k=1.5\) in Tukey's boxplot. The new coefficient \(k_n^{Chau}\) is calculated based on Chauvenet's criterion, which is given in formula (9) in their paper.

## Features

- `chau_boxplot()`: Generates Chauvenet-type boxplots in base R. Its usage is similar to `boxplot()`, but it employs an updated fence coefficient for more robust outlier detection.
- `geom_chau_boxplot()`: Creates Chauvenet-type boxplots in `ggplot2`, functioning similarly to `geom_boxplot()`.

## Installation

To install the `ChauBoxplot` package from CRAN, please use the following command in R:

install.packages("ChauBoxplot")

To install the `ChauBoxplot` package from GitHub, please use the following commands in R:

library(devtools)  
install_github("tiejuntong/ChauBoxplot")

## Usage

Below is a real example with R code of how to create a Chauvenet-type boxplot for the pay adjustment rates of senior civil servants in Hong Kong. 

### R code in base R
library(ChauBoxplot)  
rate.senior <- c(4.96, 6.30, -5.38, 1.60, 7.24, 5.26, 2.55, 5.96, 3.96, 4.19, 1.88, 4.06, 4.75, 0, 0, 2.5, 2.87, 3.00)/100
chau_boxplot(rate.senior)  

### R code in ggplot2
library(ggplot2)  
library(ChauBoxplot)

rate.senior <- c(4.96, 6.30, -5.38, 1.60, 7.24, 5.26, 2.55, 5.96, 3.96, 4.19, 1.88, 4.06, 4.75, 0, 0, 2.5, 2.87, 3.00)/100  
year <- 2007:2024  
data.senior <- data.frame(x=year, y=rate.senior)  

C.boxplot.senior <-   
  ggplot(data.senior, aes(y=rate.senior)) +  
  geom_chau_boxplot(fill="purple",width=3) +  
  theme(legend.position = "none") +  
  scale_x_discrete(breaks = NULL) +  
  ylim(-0.057,0.077) +  
  theme(plot.margin = unit(c(0, 0, 0, 0), "inches")) +  
  labs(title="C.boxplot", subtitle="Senior civil servants", x="", y="")  

print(C.boxplot.senior)

## References

Hongmei Lin, Riquan Zhang and Tiejun Tong (2025). When Tukey meets Chauvenet: a new boxplot criterion for outlier detection. Journal of Computational and Graphical Statistics, accepted.

## Contact

Should you have any questions, please feel free to contact Tiejun Tong via [tongt@hkbu.edu.hk](mailto:tongt@hkbu.edu.hk).  



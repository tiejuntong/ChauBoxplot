rm(list=ls())
library(ggplot2)
library(patchwork)
library(ChauBoxplot)

### Pay adjustment for junior civil servants in Hong Kong ###
rate.junior <- c(4.62, 5.29, 0, 0.56, 6.16, 5.80, 3.92, 4.71, 4.62, 4.68, 2.94, 4.51, 5.26, 0, 0, 2.5, 4.65, 3.00)/100
year <- 2007:2024
data.junior <- data.frame(x=year, y=rate.junior)

T.boxplot.junior <- ggplot(data.junior, aes(y=rate.junior)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  ylim(-0.003,0.065) +
  theme(plot.margin = unit(c(0, 0, 0, 0), "inches")) +
  labs(title="T.boxplot", subtitle="Junior civil servants", x="", y="")

C.boxplot.junior <- ggplot(data.junior, aes(y=rate.junior)) +
  geom_chau_boxplot(fill="purple",width=3) +
  annotate(geom="point", x=-0.25, y=0) +
  annotate(geom="point", x=0, y=0) +
  annotate(geom="point", x=0.25, y=0) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  ylim(-0.003,0.065) +
  theme(plot.margin = unit(c(0, 0, 0, 0), "inches")) +
  labs(title="C.boxplot", subtitle="Junior civil servants", x="", y="")


### Pay adjustment for senior civil servants in Hong Kong ###
rate.senior <- c(4.96, 6.30, -5.38, 1.60, 7.24, 5.26, 2.55, 5.96, 3.96, 4.19, 1.88, 4.06, 4.75, 0, 0, 2.5, 2.87, 3.00)/100
year <- 2007:2024
data.senior <- data.frame(x=year, y=rate.senior)

T.boxplot.senior <- ggplot(data.senior, aes(y=rate.senior)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  ylim(-0.057,0.077) +
  theme(plot.margin = unit(c(0, 0, 0, 0), "inches")) +
  labs(title="T.boxplot", subtitle="Senior civil servants", x="", y="")

C.boxplot.senior <- ggplot(data.senior, aes(y=rate.senior)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  ylim(-0.057,0.077) +
  theme(plot.margin = unit(c(0, 0, 0, 0), "inches")) +
  labs(title="C.boxplot", subtitle="Senior civil servants", x="", y="")


### Figure for the pay adjustment ###
(T.boxplot.junior | C.boxplot.junior | T.boxplot.senior | C.boxplot.senior)

ggsave("Figure_pay_adjustment.pdf", height=4, width=7.7)


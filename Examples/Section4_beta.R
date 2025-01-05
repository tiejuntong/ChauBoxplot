rm(list=ls())
library(ggplot2)
library(patchwork)

library(devtools)
install_github("tiejuntong/C.boxplot")
library(C.boxplot)


### Generate data from the beta(2,5) distribution ###
set.seed(1863)
n1 <- 50
y1 <- c(rbeta(n1,2,5))
x1 <- rep("n1",length(y1))
data1 <- data.frame(x=x1,y=y1)

set.seed(1863)
n2 <- 500
y2 <- c(rbeta(n2,2,5))
x2 <- rep("n2",length(y2))
data2 <- data.frame(x=x2,y=y2)

set.seed(1863)
n3 <- 5000
y3 <- c(rbeta(n3,2,5))
x3 <- rep("n3",length(y3))
data3 <- data.frame(x=x3,y=y3)

set.seed(1863)
n4 <- 50000
y4 <- c(rbeta(n4,2,5))
x4 <- rep("n4",length(y4))
data4 <- data.frame(x=x4,y=y4)

y.min <- min(y1,y2,y3,y4)
y.max <- max(y1,y2,y3,y4)


### Tukey's boxplots ###
T.boxplot.fig1 <- ggplot(data1,aes(y=y1)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=50}")), x="", y="")

T.boxplot.fig2 <- ggplot(data2,aes(y=y2)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=500}")), x="", y="")

T.boxplot.fig3 <- ggplot(data3,aes(y=y3)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=5000}")), x="", y="")

T.boxplot.fig4 <- ggplot(data4,aes(y=y4)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=50000}")), x="", y="")


### Chauvenet-type boxplots ###
C.boxplot.fig1 <- ggplot(data1,aes(y=y1)) +
  geom_C.boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot",subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=50}")), x="", y="")

C.boxplot.fig2 <- ggplot(data2,aes(y=y2)) +
  geom_C.boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot",subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=500}")), x="", y="")

C.boxplot.fig3 <- ggplot(data3,aes(y=y3)) +
  geom_C.boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min,y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot",subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=5000}")), x="", y="")

C.boxplot.fig4 <- ggplot(data4,aes(y=y4)) +
  geom_C.boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",Beta(2,5),", ",italic(n),"=50000}")), x="", y="")


### Figure for the chi-square distribution ###
(T.boxplot.fig1 | T.boxplot.fig2 | T.boxplot.fig3 | T.boxplot.fig4) /
  (C.boxplot.fig1 | C.boxplot.fig2 | C.boxplot.fig3 | C.boxplot.fig4)

ggsave("Figure_beta.pdf", height=9, width=8)


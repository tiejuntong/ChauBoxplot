rm(list=ls())
library(ggplot2)
library(patchwork)
library(ChauBoxplot)

### Generate data from the lognormal distribution ###
sigma <- sqrt(0.1)

set.seed(1863)
n1 <- 50
y1 <- c(rlnorm(n1,0,sigma))
x1 <- rep("n1",length(y1))
data1 <- data.frame(x=x1,y=y1)

set.seed(1863)
n2 <- 500
y2 <- c(rlnorm(n2,0,sigma))
x2 <- rep("n2",length(y2))
data2 <- data.frame(x=x2,y=y2)

set.seed(1863)
n3 <- 5000
y3 <- c(rlnorm(n3,0,sigma))
x3 <- rep("n3",length(y3))
data3 <- data.frame(x=x3,y=y3)

set.seed(1863)
n4 <- 50000
y4 <- c(rlnorm(n4,0,sigma))
x4 <- rep("n4",length(y4))
data4 <- data.frame(x=x4,y=y4)

y.min <- min(y1,y2,y3,y4)
y.max <- max(y1,y2,y3,y4)


### Tukey's boxplots ###
T.boxplot.fig1 <- ggplot(data1,aes(y=y1)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=50}")), x="", y="")

T.boxplot.fig2 <- ggplot(data2,aes(y=y2)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=500}")), x="", y="")

T.boxplot.fig3 <- ggplot(data3,aes(y=y3)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=5000}")), x="", y="")

T.boxplot.fig4 <- ggplot(data4,aes(y=y4)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=50000}")), x="", y="")


### Chauvenet-type boxplots ###
C.boxplot.fig1 <- ggplot(data1,aes(y=y1)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=50}")), x="", y="")

C.boxplot.fig2 <- ggplot(data2,aes(y=y2)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=500}")), x="", y="")

C.boxplot.fig3 <- ggplot(data3,aes(y=y3)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=5000}")), x="", y="")

C.boxplot.fig4 <- ggplot(data4,aes(y=y4)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",LN(0,0.1),", ",italic(n),"=50000}")), x="", y="")


### Figure for the t distribution ###
(T.boxplot.fig1 | T.boxplot.fig2 | T.boxplot.fig3 | T.boxplot.fig4) /
  (C.boxplot.fig1 | C.boxplot.fig2 | C.boxplot.fig3 | C.boxplot.fig4)

ggsave("Figure_lognormal.pdf", height=9, width=8)


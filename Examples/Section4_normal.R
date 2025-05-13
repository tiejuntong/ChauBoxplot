rm(list=ls())
library(ggplot2)
library(patchwork)
library(ChauBoxplot)

### Generate data from the normal distribution ###
outs <- c(5,6)

set.seed(1863)
n1 <- 50-2
y1 <- c(rnorm(n1),outs)
x1 <- rep("n1",length(y1))
data1 <- data.frame(x=x1,y=y1)

set.seed(1863)
n2 <- 500-2
y2 <- c(rnorm(n2),outs)
x2 <- rep("n2",length(y2))
data2 <- data.frame(x=x2,y=y2)

set.seed(1863)
n3 <- 5000-2
y3 <- c(rnorm(n3),outs)
x3 <- rep("n3",length(y3))
data3 <- data.frame(x=x3,y=y3)

set.seed(1863)
n4 <- 50000-2
y4 <- c(rnorm(n4),outs)
x4 <- rep("n4",length(y4))
data4 <- data.frame(x=x4,y=y4)

y.min <- min(y1,y2,y3,y4)
y.max <- max(y1,y2,y3,y4)


### Tukey's boxplots ###
T.boxplot.fig1 <- ggplot(data1,aes(y=y1)) +
  geom_boxplot(width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=50}")), x="", y="")

T.boxplot.fig2 <- ggplot(data2,aes(y=y2)) +
  geom_boxplot(width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=500}")), x="", y="")

T.boxplot.fig3 <- ggplot(data3,aes(y=y3)) +
  geom_boxplot(width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=5000}")), x="", y="")

T.boxplot.fig4 <- ggplot(data4,aes(y=y4)) +
  geom_boxplot(width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min, y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=50000}")), x="", y="")


### Chauvenet-type boxplots ###
C.boxplot.fig1 <- ggplot(data1, aes(y=y1)) +
  geom_chau_boxplot(fill="purple",width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min,y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=50}")), x="", y="")

C.boxplot.fig2 <- ggplot(data2, aes(y=y2)) +
  geom_chau_boxplot(fill="purple",width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min,y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=500}")), x="", y="")

C.boxplot.fig3 <- ggplot(data3, aes(y=y3)) +
  geom_chau_boxplot(fill="purple",width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min,y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=5000}")), x="", y="")

C.boxplot.fig4 <- ggplot(data4, aes(y=y4)) +
  geom_chau_boxplot(fill="purple",width=3) +
  annotate(geom="point", x=0, y=outs, colour = "red", shape=4, size=2) +
  theme(legend.position = "none") +
  ylim(y.min,y.max) + scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot", subtitle=expression(paste("{",N(0,1),", ",italic(n),"=50000}")), x="", y="")


### Figure for the normal distribution ###
(T.boxplot.fig1 | T.boxplot.fig2 | T.boxplot.fig3 | T.boxplot.fig4) /
  (C.boxplot.fig1 | C.boxplot.fig2 | C.boxplot.fig3 | C.boxplot.fig4)

ggsave("Figure_normal.pdf", height=8.5, width=7.5)


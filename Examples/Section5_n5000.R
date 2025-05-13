rm(list=ls())
install.packages('litteR')
library('litteR')

library(ggplot2)
library(patchwork)
library(ChauBoxplot)

### Generate data from the chi-square and t distributions ###
n1 <- n2 <- 5000

set.seed(1863)
y1 <- c(rchisq(n1,df=8))
x1 <- rep("n1",length(y1))
data1 <- data.frame(x=x1,y=y1)

set.seed(1863)
y2 <- c(rt(n2,df=8))
x2 <- rep("n2",length(y2))
data2 <- data.frame(x=x2,y=y2)


### Boxplots for the chi-square distribution ###
T.boxplot.chisq <- ggplot(data1,aes(y=y1)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",chi[8]^2,", ",italic(n),"=5000}")), x="", y="")

T.boxplot.NN.chisq <- ggplot(data1, aes(x=x1, y=y1)) +
  stat_adj_boxplot() +
  stat_adj_boxplot_outlier() +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot.NN", subtitle=expression(paste("{",chi[8]^2,", ",italic(n),"=5000}")), x="", y="")

C.boxplot.chisq <- ggplot(data1,aes(y=y1)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot",subtitle=expression(paste("{",chi[8]^2,", ",italic(n),"=5000}")), x="", y="")

q1.1 <- quantile(y1,0.25)
q3.1 <- quantile(y1,0.75)
IQR1 <- q3.1-q1.1
nu1.hat <- mean(y1)
k1.Lower <- (qchisq(0.25,df=nu1.hat)-qchisq(0.25/n1,df=nu1.hat))/(qchisq(0.75,df=nu1.hat)-qchisq(0.25,df=nu1.hat))
k1.Upper <- (qchisq(1-0.25/n1,df=nu1.hat)-qchisq(0.75,df=nu1.hat))/(qchisq(0.75,df=nu1.hat)-qchisq(0.25,df=nu1.hat))
out1.Chau.NN <- subset(y1, (y1>(q3.1+k1.Upper*IQR1))|(y1<(q1.1-k1.Lower*IQR1)))
out1.Chau.NN
C.boxplot.NN.chisq <- ggplot(data1, aes(y=y1)) +
  stat_boxplot(linetype=1, width=0.5, coef = k1.Upper) +
  geom_boxplot(outlier.shape=NA, fill="purple",width=3) +
  annotate(geom="point", x=0, y=out1.Chau.NN) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot.NN", subtitle=expression(paste("{",chi[8]^2,", ",italic(n),"=5000}")), x="", y="")


### Boxplots for the t distribution ###
T.boxplot.t <- ggplot(data1,aes(y=y2)) +
  geom_boxplot(width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot", subtitle=expression(paste("{",italic(t)[8],", ",italic(n),"=5000}")), x="", y="")

T.boxplot.NN.t <- ggplot(data1, aes(x=x2, y=y2)) +
  stat_adj_boxplot() +
  stat_adj_boxplot_outlier() +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="T.boxplot.NN", subtitle=expression(paste("{",italic(t)[8],", ",italic(n),"=5000}")), x="", y="")

C.boxplot.t <- ggplot(data1,aes(y=y2)) +
  geom_chau_boxplot(fill="purple",width=3) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot",subtitle=expression(paste("{",italic(t)[8],", ",italic(n),"=5000}")), x="", y="")

q1.2 <- quantile(y2,0.25)
q3.2 <- quantile(y2,0.75)
IQR2 <- q3.2-q1.2
nu2.hat <- var(y2)*2/(var(y2)-1)
k2.Lower <- (qt(0.25,df=nu2.hat)-qt(0.25/n2,df=nu2.hat))/(qt(0.75,df=nu2.hat)-qt(0.25,df=nu2.hat))
k2.Upper <- (qt(1-0.25/n2,df=nu2.hat)-qt(0.75,df=nu2.hat))/(qt(0.75,df=nu2.hat)-qt(0.25,df=nu2.hat))
out2.Chau.NN <- subset(y2, (y2>(q3.2+k2.Upper*IQR2))|(y2<(q1.2-k2.Lower*IQR2)))
out2.Chau.NN
C.boxplot.NN.t <- ggplot(data2, aes(y=y2)) +
  stat_boxplot(linetype=1, width=0.5, coef = k2.Upper) +
  geom_boxplot(outlier.shape=NA, fill="purple",width=3) +
  annotate(geom="point", x=0, y=out2.Chau.NN) +
  theme(legend.position = "none") +
  scale_x_discrete(breaks = NULL) +
  labs(title="C.boxplot.NN", subtitle=expression(paste("{",italic(t)[8],", ",italic(n),"=5000}")), x="", y="")


### Figure for the chi-square distribution with NN ###
(T.boxplot.chisq | C.boxplot.chisq | T.boxplot.NN.chisq | C.boxplot.NN.chisq) /
  (T.boxplot.t | C.boxplot.t | T.boxplot.NN.t | C.boxplot.NN.t)

ggsave("Figure_NN_n5000.pdf", height=8.5, width=7.5)



set.seed(2000)
x <- round(rnorm(7),3)

x.total <- sort(c(x,100,100))
x.mean <- round(mean(x.total),3)
x.mean
x.sd <- round(sd(x.total),3)
x.sd

round(abs(x.total-x.mean)/x.sd,3)

x.mean - 3*x.sd
x.mean + 3*x.sd

sort(x.total)
summary(x.total)

Chau.coef <- qnorm(1-0.25/length(x.total))/1.35-0.5

Q1 <- -0.854
Q3 <- 1.741
LF <- Q1 - Chau.coef*(Q3-Q1)
UF <- Q3 + Chau.coef*(Q3-Q1)
LF
UF



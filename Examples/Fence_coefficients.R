library(ggplot2)

n <- 8:2000
k.ER <- exp(4.01761 - 2.35363*log(n) + 0.64618*(log(n))^2 - 0.07893*(log(n))^3 + 0.00368*(log(n))^4)
k.TL <- exp(4.45171 - 2.44501*log(n) + 0.64990*(log(n))^2 - 0.07851*(log(n))^3 + 0.00365*(log(n))^4)
alpha <- 0.05
term2 <- (qnorm((1-alpha/2)^(1/n)) - 0.6745)/1.349
k.AF <- (1 + 8.9764*n^(-1) - 126.6262*n^(-2) + 1531.7064*n^(-3) - 10729.3439*n^(-4))*term2
k.EC <- 1.5*(1 + 0.1*log(n/10))
k.Chau <- qnorm(1-0.25/n)/1.35 - 0.5

y.max <- max(k.Chau, k.ER, k.TL, k.AF, k.EC)
y.min <- min(k.Chau, k.ER, k.TL, k.AF, k.EC)

df.fence <- data.frame(n, k.Chau, k.ER, k.TL, k.AF, k.EC)

ggplot(df.fence, aes(x=n)) +
  geom_line(aes(y=k.TL), lwd=1, lty=2, col=2) +
    annotate("text", x=1960, y=3.12, label="italic(k)[italic(n)]^TL~'in'~(4)", parse=TRUE) +
  geom_line(aes(y=k.ER), lwd=1.3, lty=3, col=3) +
    annotate("text", x=1957, y=2.83, label="italic(k)[italic(n)]^ER~'in'~(3)", parse=TRUE) +
  geom_line(aes(y=k.AF), lwd=1, lty=4, col=4) +
    annotate("text", x=1959, y=2.55, label="italic(k)[italic(n)]^AF~'in'~(5)", parse=TRUE) +
  geom_line(aes(y=k.EC), lwd=1, lty=5, col=5) +
    annotate("text", x=1957, y=2.35, label="italic(k)[italic(n)]^EC~'in'~(6)", parse=TRUE) +
  geom_line(aes(y=k.Chau), lwd=1, lty=1, col=1) +
    annotate("text", x=1936, y=2.12, label="italic(k)[italic(n)]^Chau~'in'~(9)", parse=TRUE) +
  geom_hline(yintercept=1.5, lty=2, lwd=0.5) +
    annotate("text", x=1995, y=1.45, label="italic(k)~'='~1.5", parse=TRUE) +
  ylim(y.min+0.28, y.max-1.48) +
  labs(x=expression(italic(n)), y="Fence coefficients") + theme_bw()

ggsave("Fence_coefficients.pdf", height=5, width=6)

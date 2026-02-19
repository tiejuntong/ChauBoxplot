library(ggplot2)
library(ChauBoxplot)
library(patchwork)

province <- c("Tianjin", "Beijing", "Shanghai", "Jilin", "Qinghai", "Ningxia", "Shaanxi", "Liaoning",
              "Zhejiang", "Chongqing", "Hubei", "Shanxi", "Shandong", "Fujian", "Jiangsu", "Heilongjiang",
              "Xinjiang", "Hainan", "Guangxi", "Guangdong", "Henan", "Gansu", "Sichuan", "Xizang",
              "Hunan", "Hebei", "Yunnan", "Inner Mongolia", "Anhui", "Guizhou", "Jiangxi")
rate.985 <- c(6.0, 5.3, 4.4, 3.2, 2.7, 2.1, 2.0, 2.0, 1.8, 1.8, 1.8, 1.7, 1.7, 1.7, 1.6, 1.6, 1.5, 1.5,
              1.4, 1.4, 1.4, 1.3, 1.3, 1.3, 1.3, 1.2, 1.2, 1.1, 1.1, 1.1, 1.0)
rate.211 <- c(13.0, 16.7, 11.2, 8.0, 10.4, 7.7, 5.4, 5.2, 3.9, 4.6, 4.6, 5.3, 3.5, 4.5, 5.5, 5.4,
              7.0, 5.3, 5.4, 3.0, 4.0, 3.1, 3.8, 9.9, 3.3, 3.7, 4.0, 4.5, 4.0, 4.6, 3.8)

gaokao <- data.frame(province, rate.985, rate.211)

theme_box <- theme(
  legend.position = "none",
  plot.margin = unit(c(0, 0, 0, 0), "inches")
)

Boxplot.985 <- ggplot(gaokao, aes(x = "", y = `rate.985`)) +
  geom_boxplot(width = 0.5) +
  scale_x_discrete(breaks = NULL) +
  theme_box +
  labs(title = "Tukey's Boxplot", subtitle = "985 Rate (%)", x = "", y = "")

ChauBoxplot.985 <- ggplot(gaokao, aes(x = "", y = `rate.985`)) +
  geom_chau_boxplot(width = 0.5) +
  geom_text(
    data = subset(gaokao, province == "Qinghai"),
    mapping = aes(x = "", y = `rate.985`, label = province),
    nudge_x = 0.25, size = 3.5, color = "blue", vjust = 0.5) +
  scale_x_discrete(breaks = NULL) +
  theme_box +
  labs(title = "ChauBoxplot", subtitle = "985 Rate (%)", x = "", y = "")

Boxplot.211 <- ggplot(gaokao, aes(x = "", y = `rate.211`)) +
  geom_boxplot(width = 0.5) +
  scale_x_discrete(breaks = NULL) +
  theme_box +
  labs(title = "Tukey's Boxplot", subtitle = "211 Rate (%)", x = "", y = "")

ChauBoxplot.211 <- ggplot(gaokao, aes(x = "", y = `rate.211`)) +
  geom_chau_boxplot(width = 0.5) +
  scale_x_discrete(breaks = NULL) +
  theme_box +
  labs(title = "ChauBoxplot", subtitle = "211 Rate (%)", x = "", y = "")

(Boxplot.985 | ChauBoxplot.985 | Boxplot.211 | ChauBoxplot.211)

ggsave("Gaokao2024.pdf", height = 5, width = 8.5)




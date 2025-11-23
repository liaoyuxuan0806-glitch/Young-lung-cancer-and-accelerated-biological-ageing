rm(list=ls())
df<-read.xlsx("真实世界青年bioage12.8.xlsx",sheet="Sheet4")
df<-read.xlsx("真实世界老年肺癌bioage数据（原始）.xlsx", sheet = "Sheet5")
# 计算生物年龄加速 (Biological Age Acceleration, BAA)
df$BAA <- df$biological_age - df$chronological_age

# 按生物年龄加速与否进行分组
df$group <- ifelse(df$BAA > 0, "accelerated", 
                   ifelse(df$BAA < 0, "decelerated", "same"))

# 查看分组后的频次
table(df$group)

# 比较不同组别中肺癌的发生情况
table(df$group, df$lung_cancer)

# 可视化肺癌在不同组别中的分布情况
library(ggplot2)
library(cowplot)
ggplot(df, aes(x = group, fill = as.factor(lung_cancer))) +
  geom_bar(position = "fill") +
  labs(x = "Group", fill = "Lung Cancer (0 = No, 1 = Yes)", 
       title = "Lung Cancer Proportion by Age Acceleration Group") +
  scale_fill_manual(values = c("0" = "blue", "1" = "red")) +
  theme_minimal()
# 密度图
ggplot(df, aes(x = biological_age, fill = factor(lung_cancer))) +
  geom_density(alpha = 0.5) +
  labs(x = "Biological Age", y = "Density", title = "Distribution of Biological Age by Lung Cancer Status") +
  scale_fill_discrete(name = "Lung Cancer", labels = c("No", "Yes"))
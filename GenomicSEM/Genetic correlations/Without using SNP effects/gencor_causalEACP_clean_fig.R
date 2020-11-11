##################################################
## Project: CogNonCog 2018
## Script purpose: Clean results of the genetic correlations with the Causal EA-CP model 
## and make the Supp Figure 17
## Date: August 2020
## Author: Perline Demange 
##################################################


cor <-read.csv("gencor_all_woSNP_causalEACP.csv", header=T, stringsAsFactors = F)
head(cor)

myvars <- c("trait.name", "Standardized_Est", "Standardized_SE", "Standardized_Est.1", "Standardized_SE.1")
clean <- cor[myvars]
names(clean) <- c("trait.name", "Est_Cog", "SE_Cog", "Est_NonCog", "SE_NonCog")
rgs <- clean

rgs$Z_Cog <- rgs$Est_Cog / rgs$SE_Cog
rgs$Z_NonCog <- rgs$Est_NonCog / rgs$SE_NonCog
rgs$P_Cog <- 2*pnorm(-abs(rgs$Z_Cog))
rgs$P_NonCog <- 2*pnorm(-abs(rgs$Z_NonCog))
rgs$P_fdr_Cog <- p.adjust(rgs$P_Cog, method="fdr")
rgs$P_fdr_NonCog <- p.adjust(rgs$P_NonCog, method="fdr")
#write.csv(rgs, "gencor_all_causalEACP_pval.csv", row.names=F)


cov0 <- read.csv("../gencor_all_woSNP_cov0.csv", header=T, stringsAsFactors = F)
myvars <- c("trait.name", "Standardized_Est", "Standardized_SE", "Standardized_Est.1", "Standardized_SE.1")
clean <- cov0[myvars]
names(clean) <- c("trait.name", "Est_Cog", "SE_Cog", "Est_NonCog", "SE_NonCog")
original <- clean
original$Z_Cog <- original$Est_Cog / original$SE_Cog
original$Z_NonCog <- original$Est_NonCog / original$SE_NonCog

library(ggplot2)
library(ggrepel)
data <- rgs 
data$Est_cog_or <- original$Est_Cog
data$Est_Noncog_or <- original$Est_NonCog

ggplot(data, aes(x = Est_Cog, y = Est_cog_or)) +
  geom_point(size=2) +
  geom_text_repel(label = data$trait.name, 
                  size=3) +
  ylab("rG when CP ~ 0.2*EA") + 
  xlab("rG when CP ~~ 0*EA") +
  labs(title="Cog")+
  xlim(-0.8, 0.8) +
  ylim(-0.8, 0.8) +
  geom_abline(intercept=0, slope=1)+
  theme_light()
ggplot(data, aes(x = Est_NonCog, y =Est_Noncog_or )) +
  geom_point(size=2) +
  geom_text_repel(label = data$trait.name, 
                  size=3) +
  ylab("rG when CP ~ 0.2*EA") + 
  xlab("rG when CP ~~ 0*EA") +
  labs(title="NonCog")+
  xlim(-0.8, 0.8) +
  ylim(-0.8, 0.8) +
  geom_abline(intercept=0, slope=1)+
  theme_light()

cor(data$Est_Cog, data$Est_cog_or) # 0.991198
cor(data$Est_NonCog, data$Est_Noncog_or) #0.9952034

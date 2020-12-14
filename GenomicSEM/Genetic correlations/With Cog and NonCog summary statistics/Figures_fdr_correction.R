##################################################
## Project: CogNonCog 2018
## Script purpose: Figure for the genetic correlation data, cog and noncog
## Date: February 2020
# Author: Perline Demange, Adapted from Abdel Abdellaoui's script  C:\Users\PDE430\Documents\CogNonCog\Abdel\loneline rG figure
#  + Modified by Margherita Malanchini on May 23rd 2020
##################################################

#install.packages("ggplot2")
library(ggplot2)
library(tidyverse); library(dplyr); library(ggtext) 

setwd("C:/Users/PDE430/Documents/CogNonCog/Analyses/Genetic_correlations/Final_allchr/Results_LISA_with23andMe")

rgs <- read.csv("rG_CogNonCog_EA_alltraits_23andMe_030220_fdrcorrected.csv",header=T,sep = ",", strip.white=T)

## Adjust Pvalues 
#rgs$cogT_P_uncons_fdr <- p.adjust(rgs$cogT_P_uncons, method="fdr") 
#rgs$noncogT_P_uncons_fdr <- p.adjust(rgs$noncogT_P_uncons, method="fdr")
#rgs$T_pval_fdr <- p.adjust(rgs$T_pval, method="fdr")
#rgs$T_pval_bonf <- p.adjust(rgs$T_pval, method="bonferroni")
#write.csv(rgs, "rG_CogNonCog_EA_alltraits_23andMe_030220_fdrcorrected.csv", row.names=FALSE)
#rgs <- read.csv("rG_CogNonCog_EA_alltraits_23andMe_030220_fdrcorrected.csv",header=T,sep = ",", strip.white=T)

# Rename 

levels(rgs$trait.name)
levels(rgs$trait.name)[levels(rgs$trait.name)=="Age at first birth \x96 Men"] <- "Age at first birth - men"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Age at first birth \x96 Women"] <- "Age at first birth - women"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Number children ever born \x96 Men"] <- "Number children ever born - men"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Number children ever born \x96 Women"] <- "Number children ever born - women"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Obsessive Compulsive Disorder"] <- "Obsessive-compulsive disorder"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Anorexia Nervosa"] <- "Anorexia nervosa"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Bipolar Disorder"] <- "Bipolar disorder"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Attention Deficit Hyperactivity Disorder"] <- "Attention deficit hyperactivity disorder"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Major Depressive Disorder"] <- "Major depressive disorder"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Autism Spectrum Disorder"] <- "Autism spectrum disorder"
levels(rgs$trait.name)[levels(rgs$trait.name)=="Mind in the Eyes score"] <- "Mind in the eyes score"


## Define categories 
ses <-                  c("Household income", "Neighborhood deprivation","Longevity")
decision_making <-      c("Risk tolerance", "Delay discounting")
fertility_risk <-       c("Risk behaviour composite","Speeding propensity", "Ever smoker", 
                          "Age at smoking initiation", "Cigarettes per day", 
                          "Alcohol use", "Drinks per week", "Alcohol dependence", "Cannabis use",
                          "Age at menarche","Age at first sex", "Number of sexual partners", "Age at first birth - women", 
                          "Age at first birth - men", "Number children ever born - women", "Number children ever born - men", 
                          "Age at menopause")
personality_traits <-   c("Openness","Conscientiousness","Extraversion","Agreeableness","Neuroticism")
mental_health_traits <- c("Schizophrenia","Bipolar disorder","Obsessive-compulsive disorder",
                          "Anorexia nervosa","Attention deficit hyperactivity disorder",
                          "Major depressive disorder","Autism spectrum disorder")
supp <-                 c("Birth weight", "BMI", "Chronotype", "Height",
                          "Insomnia", "Loneliness", "Mind in the eyes score", "Self-rated health",
                          "Self-reported empathy", "Subjective wellbeing", 
                          "Tiredness")


# add a column with the category name 
rgs$category <- NULL
rgs$category[rgs$trait.name %in% mental_health_traits] <- "Psychiatry"
rgs$category[rgs$trait.name %in% fertility_risk] <- "Health-risk behavior & delayed fertility"
rgs$category[rgs$trait.name %in% personality_traits] <- "Personality"
rgs$category[rgs$trait.name %in% decision_making] <- "Decision"
rgs$category[rgs$trait.name %in% ses] <- "SES-related"
rgs$category[rgs$trait.name %in% supp] <- "Supplementary"


## To fix the order of the groups and traits 
rgs$category_f <- factor(rgs$category, levels=c("SES-related", "Decision",
                                                "Health-risk behavior & delayed fertility",
                                                "Personality","Psychiatry")) # create a factor to fix the order of the facets in the figure

rgs_fig4$trait.name_f <- factor(rgs_fig4$trait.name, levels=c(
  "Household income", "Neighborhood deprivation","Longevity",
  "Openness","Conscientiousness","Extraversion","Agreeableness","Neuroticism",
  "Risk tolerance", "Delay discounting",
  "Risk behaviour composite","Speeding propensity", "Ever smoker", "Age at smoking initiation", "Cigarettes per day", 
  "Alcohol use", "Drinks per week", "Alcohol dependence", "Cannabis use",
  "Age at menarche","Age at first sex", "Number of sexual partners", "Age at first birth - women", "Age at first birth - men",
  "Number children ever born - women", "Number children ever born - men", "Age at menopause",
  "Schizophrenia","Bipolar disorder","Obsessive-compulsive disorder","Anorexia nervosa",
  "Attention deficit hyperactivity disorder","Major depressive disorder","Autism spectrum disorder"
))

levels(rgs_fig4$trait.name_f)[levels(rgs_fig4$trait.name_f)=="Risk tolerance"]  <- "General risk tolerance"


### Fig 4 ###

nudge <- position_nudge(x = 0, y = 0)
nudge1 <- position_nudge(x = .2, y = 0)
nudge2 <- position_nudge(x = -.2, y = 0)

fig4 <- ggplot(rgs_fig4, aes(y=noncogT_uncons, x=reorder(trait.name_f, desc(trait.name_f)))) + 
  scale_colour_manual( name="Data", values=c("0" = "#ff9933","1" = "#1E90FF","2" = "#C0C0C0", "3"="red"), labels = c(italic("NonCog"),italic("Cog"),"EA", "FDR-corrected \nsignificant difference \nbetween NonCog and Cog")) + #need trick with both values and labels and number to order the legend..... 
  scale_shape_manual( name="Data", values=c("0" =16,"1" =16,"2" =18, "3"=8), labels = c("NonCog", "Cog", "EA", "FDR-corrected \nsignificant difference \nbetween NonCog and Cog")) +
  geom_point(aes(y=EAT_est, x=reorder(trait.name_f, desc(trait.name_f)),color="2", shape="2"), size=3, position = nudge)+
  geom_errorbar(aes(ymin=EAT_est-1.96*EAT_SE, ymax=EAT_est+1.96*EAT_SE,color="2"), width=.3, show.legend=FALSE, position = nudge) +
  geom_point(aes(y=cogT_uncons, x=reorder(trait.name_f, desc(trait.name_f)),color="1", shape="1"), size=3, position = nudge2) +
  geom_errorbar(aes(ymin=cogT_uncons-1.96*cogT_SE_uncons, ymax=cogT_uncons+1.96*cogT_SE_uncons,color="1"), width=.3, show.legend=FALSE, position = nudge2) +
  geom_point(aes(y=noncogT_uncons, x=reorder(trait.name_f, desc(trait.name_f)),color="0", shape="0"), size=3, position = nudge1) + 
  geom_errorbar(aes(ymin=noncogT_uncons-1.96*noncogT_SE_uncons, ymax=noncogT_uncons+1.96*noncogT_SE_uncons,color="0", shape="0"), width=.3, show.legend=FALSE,
                position = nudge1) +
  geom_point(data = rgs_fig4[rgs_fig4$T_pval_fdr < .05, ], # star to indicate the significance of the difference
             aes(y=-1, x=reorder(trait.name_f, desc(trait.name_f)), color="3",
                 shape = "3"),
             size=3) +
  ylim(-1, 1) +
  geom_hline(yintercept = 0) +
  theme_light(base_size=12) +
  theme(axis.title.y=element_blank(),
        #axis.title.x=element_blank(),
        legend.title=element_blank(),
        panel.grid=element_blank(),
        plot.background=element_blank()) +
  ylab("Genetic Correlation") +
  theme(legend.position="right") +
  #facet_grid(category_f ~ ., scales = "free", space = "free_y") +
  coord_flip()

fig4a = fig4+facet_grid(category_f ~ ., scales = "free", space = "free")+
  theme(strip.text = element_text(size=10, colour = 'black', face = "bold"),
        strip.background = element_rect(colour="gray", fill="white"))

plot(fig4a)
#ggsave(fig4a, file="Figure4_final.tiff", width=10, height=13)
#ggsave(fig4a, file="Figure4_R1.pdf", width=11, height=13)

### Supplementary Fig 11 ###
sup <- rgs[which(rgs$category == "Supplementary"), ] 

figs2<- ggplot(sup, aes(y=noncogT_uncons, x=reorder(trait.name, 1-T_pval_fdr))) + 
  scale_colour_manual( name="Data", values=c("0" = "#ff9933","1" = "#1E90FF","2" = "#C0C0C0", "3"="red"), labels = c("NonCog", "Cog", "EA", "FDR-corrected \nsignificant difference \nbetween NonCog and Cog")) + #need trick with both values and labels and number to order the legend.....
  scale_shape_manual( name="Data", values=c("0" =16,"1" =16,"2" =18, "3"=8), labels = c("NonCog", "Cog", "EA", "FDR-corrected \nsignificant difference \nbetween NonCog and Cog")) +
  geom_point(aes(y=EAT_est, x=reorder(trait.name, 1-T_pval_fdr),color="2", shape="2"), size=4, position = nudge) +
  geom_errorbar(aes(ymin=EAT_est-1.96*EAT_SE, ymax=EAT_est+1.96*EAT_SE,color="2"), width=.2, show.legend=FALSE, position = nudge) +
  geom_point(aes(y=cogT_uncons, x=reorder(trait.name, 1-T_pval_fdr),color="1", shape="1"), size=4, position = nudge2) +
  geom_errorbar(aes(ymin=cogT_uncons-1.96*cogT_SE_uncons, ymax=cogT_uncons+1.96*cogT_SE_uncons,color="1"), width=.2, show.legend=FALSE, position = nudge2) +
  geom_point(aes(y=noncogT_uncons, x=reorder(trait.name, 1-T_pval_fdr),color="0", shape="0"), size=4, position = nudge1) + 
  geom_errorbar(aes(ymin=noncogT_uncons-1.96*noncogT_SE_uncons, ymax=noncogT_uncons+1.96*noncogT_SE_uncons,color="0", shape="0"), width=.2, show.legend=FALSE, position = nudge1) +
  geom_point(data = sup[sup$T_pval_fdr < .05, ], # star to indicate thesignificance of the difference
             aes(y=-1, x=reorder(trait.name, 1-T_pval_fdr), color="3",
                 shape = "3"),
             size=2) +
  ylim(-1, 1) +
  geom_hline(yintercept = 0) +
  theme_light(base_size=12) +
  theme(axis.title.y=element_blank(),
        #axis.title.x=element_blank(),
        legend.title=element_blank()) +
  ylab("Genetic Correlation") +
  theme(legend.position="right") +
  #facet_grid(category_f ~ ., scales = "free", space = "free_y") +
  coord_flip() # flip y and x 

print(figs2)
#ggsave(figs2, file="FigureS2_R1.png", width=9, height=8)
#ggsave(figs2, file="FigureS2_R1.pdf", width=9, height=8)

### Fig 3 ###

## RGs
# add EA in holdout 23andMe to the data 
fig3<- rgs[which(rgs$trait.name %in% c("Childhood IQ","Highest math class taken","Self-reported math ability")),]
fig3 <- fig3[,c(2:13)]
fig3
fig3 <-fig3[,c(1,3:12)]
dataea <- data.frame("EA in 23andMe", 0.5721141,0.01732339, 0.7073207, 0.01758624,36.67798, 1.393449e-09, 0.6328346, 0.01781819, 0.6328346, 0.0170765 )
names(dataea) <- c("trait.name","cogT_uncons",  "cogT_SE_uncons", "noncogT_uncons", "noncogT_SE_uncons",  "T_chisquare",  "T_pval",  "cogT_cons",  "cogT_SE_cons",  "noncogT_cons", "noncogT_SE_cons")
fig3<- rbind (fig3, dataea)
fig3
# manually replace pval of childhood id by fdr corrected (with all traits), pval for ea is not fdr corrected 
rgs$T_pval_fdr[rgs$trait.name == "Childhood IQ"]
fig3$T_pval[fig3$trait.name == "Childhood IQ"] <- 1.6262e-07
rgs$T_pval_fdr[rgs$trait.name == "Highest math class taken"]
fig3$T_pval[fig3$trait.name == "Highest math class taken"] <- 3.2e-08
rgs$T_pval_fdr[rgs$trait.name == "Self-reported math ability"]
fig3$T_pval[fig3$trait.name == "Self-reported math ability"] <- 2.49e-89

fig3$trait.name <- factor(fig3$trait.name, levels=c('Childhood IQ',"Self-reported math ability","Highest math class taken", "EA in 23andMe" ))

pdf("Fig3_rg_2702_math.pdf",width=6,height=3)
ggplot(fig3, aes(y=noncogT_uncons, x=trait.name)) + 
  #geom_point(aes(y=EAT_est, x=trait.name),color="#808080") +
  #geom_errorbar(aes(ymin=EAT_est-1.96*EAT_SE, ymax=EAT_est+1.96*EAT_SE), width=.2,color="#808080") +
  geom_point(aes(y=cogT_uncons, x=trait.name),color="#1E90FF", size=4) +
  geom_errorbar(aes(ymin=cogT_uncons-1.96*cogT_SE_uncons, ymax=cogT_uncons+1.96*cogT_SE_uncons), width=.4,color="#1E90FF") +
  geom_point(aes(y=noncogT_uncons, x=trait.name),color="#ff9933", size=4) + 
  geom_errorbar(aes(ymin=noncogT_uncons-1.96*noncogT_SE_uncons, ymax=noncogT_uncons+1.96*noncogT_SE_uncons), width=.4,color="#ff9933") +
  #geom_point(data = fig3[fig3$T_pval < .05, ], # star to indicate thesignificance of the difference
  #           aes(y=0, x=trait.name),
  #           color="red",
  #           shape = "*",
  #           size=7.5,
  #           show.legend = F) +
  ylim(0, 1) +
  geom_hline(yintercept = 0) +
  theme_light(base_size=10) +
  theme(axis.title.y=element_blank(), axis.text.y=element_blank(), axis.text= element_text(size=14),
        axis.title.x=element_blank(),
        legend.title=element_blank()) +
  ylab("Genetic Correlation") +
  #facet_grid(category_f ~ ., scales = "free", space = "free_y") +
  coord_flip()
dev.off()

## PGS
data <- read.csv("C:/Users/PDE430/Documents/CogNonCog/Figures/PRSmetaanalysis_data_withall.csv", stringsAsFactors = T, strip.white=T)
listfi3 <- c("Full scale IQ", "Educational Attainment", "Reading", "Mathematics")
validation <- data[which(data$Phenotype %in% listfi3), ]
head(validation)

#density data EA
dataEANC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Educational Attainment" & validation$PGS =="NonCog")], 
                                   validation$Coefficient_SE[which(validation$Phenotype=="Educational Attainment" & validation$PGS =="NonCog")]), "NonCog")
dataEAC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Educational Attainment" & validation$PGS =="Cog")], 
                                  validation$Coefficient_SE[which(validation$Phenotype=="Educational Attainment" & validation$PGS =="Cog")]), "Cog")


colnames(dataEANC) <- c("Density","trait")
colnames(dataEAC) <- c("Density","trait")

EA <- cbind.data.frame(rbind.data.frame(dataEANC, dataEAC),"Educational Achievement")
head(EA)
colnames(EA) <- c("Density","PGS","Trait")

#density data IQ
dataIQNC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Full scale IQ" & validation$PGS =="NonCog")], 
                                   validation$Coefficient_SE[which(validation$Phenotype=="Full scale IQ" & validation$PGS =="NonCog")]), "NonCog")
dataIQC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Full scale IQ" & validation$PGS =="Cog")], 
                                  validation$Coefficient_SE[which(validation$Phenotype=="Full scale IQ" & validation$PGS =="Cog")]), "Cog")


colnames(dataIQNC) <- c("Density","trait")
colnames(dataIQC) <- c("Density","trait")

IQ <- cbind.data.frame(rbind.data.frame(dataIQNC, dataIQC),"Full scale IQ")
head(IQ)
colnames(IQ) <- c("Density","PGS","Trait")

#density data maths
datamaNC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Mathematics" & validation$PGS =="NonCog")], 
                                   validation$Coefficient_SE[which(validation$Phenotype=="Mathematics" & validation$PGS =="NonCog")]), "NonCog")
datamaC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Mathematics" & validation$PGS =="Cog")], 
                                  validation$Coefficient_SE[which(validation$Phenotype=="Mathematics" & validation$PGS =="Cog")]), "Cog")


colnames(datamaNC) <- c("Density","trait")
colnames(datamaC) <- c("Density","trait")

math <- cbind.data.frame(rbind.data.frame(datamaNC, datamaC),"Mathematics")
head(math)
colnames(math) <- c("Density","PGS","Trait")

#density reading
datareNC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Reading" & validation$PGS =="NonCog")], 
                                   validation$Coefficient_SE[which(validation$Phenotype=="Reading" & validation$PGS =="NonCog")]), "NonCog")
datareC <- cbind.data.frame(rnorm(100000, validation$Coefficient[which(validation$Phenotype=="Reading" & validation$PGS =="Cog")], 
                                  validation$Coefficient_SE[which(validation$Phenotype=="Reading" & validation$PGS =="Cog")]), "Cog")


colnames(datareNC) <- c("Density","trait")
colnames(datareC) <- c("Density","trait")

reading <- cbind.data.frame(rbind.data.frame(datareNC, datareC),"Reading")
head(reading)
colnames(reading) <- c("Density","PGS","Trait")

data_all <- rbind.data.frame(EA, math, reading, IQ)
head(data_all)


library(ggridges)
data_all$PGS <- factor(data_all$PGS, levels=c("NonCog", "Cog"))
data_all$Trait <- factor(data_all$Trait, levels=c("Full scale IQ","Mathematics", "Reading", "Educational Achievement"))

pdf("Fig3_pgs_2702_math.pdf",width=6,height=3)
ggplot(data_all,  aes(y= Trait))  +  
  scale_fill_manual(values=c("NonCog" = "#ff9933","Cog" = "#1E90FF"))  +
  stat_density_ridges(quantile_lines = F, aes(x = Density, fill = PGS), alpha=.7, color = "grey", from = -.9, to = 0.9,scale = 0.9) +
  theme_light(base_size=10) + 
  scale_y_discrete(expand = expand_scale(mult = c(0.04,0.32))) +
  #scale_y_discrete(expand = c(0.04, 0.7)) +
  #coord_cartesian(clip = "off") +
  theme(axis.title.y=element_blank(), axis.text.y=element_blank(),axis.text= element_text(size=14),
        axis.title.x=element_blank(), 
        legend.title=element_blank(), legend.position = "none") +
  xlab("Polygenic score prediction") +
  xlim(0,0.4) +
  geom_vline(xintercept=0)
  #theme_ridges(center = TRUE)
dev.off()

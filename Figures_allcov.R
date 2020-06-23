### Results and figure when fixing cov(Cog.NonCog) > 0
####################

library(ggplot2)
library(dplyr)

### Merge results with different covariances ###

cov0 <-read.csv("gencor_all_woSNP_cov0.csv", header=T, stringsAsFactors = F)
head(cov0)
cov0$covariance <- 0

cov01 <-read.csv("gencor_all_woSNP_cov01.csv", header=T, stringsAsFactors = F)
cov01$covariance <- 0.1

cov02 <-read.csv("gencor_all_woSNP_cov02.csv", header=T, stringsAsFactors = F)
cov02$covariance <- 0.2

cov03 <-read.csv("gencor_all_woSNP_cov03.csv", header=T, stringsAsFactors = F)
cov03$covariance <- 0.3

data <- rbind(cov0, cov01, cov02, cov03)

myvars <- c("trait.name", "Standardized_Est", "Standardized_SE", "Standardized_Est.1", "Standardized_SE.1", "covariance")
clean <- data[myvars]
names(clean) <- c("trait.name", "Est_Cog", "SE_Cog", "Est_NonCog", "SE_NonCog", "Covariance")
rgs <- clean
head(rgs)

#write.csv(rgs, "data_allcov.csv", row.names=F)

### Get p-values ###
rgs$Z_Cog <- rgs$Est_Cog / rgs$SE_Cog
rgs$Z_NonCog <- rgs$Est_NonCog / rgs$SE_NonCog
rgs$P_Cog <- 2*pnorm(-abs(rgs$Z_Cog))
rgs$P_NonCog <- 2*pnorm(-abs(rgs$Z_NonCog))

cov0  <- rgs[rgs$Covariance == 0,]
cov01  <- rgs[rgs$Covariance == 0.1,]
cov02  <- rgs[rgs$Covariance == 0.2,]
cov03  <- rgs[rgs$Covariance == 0.3,]
cov0$P_fdr_Cog <- p.adjust(cov0$P_Cog, method="fdr")
cov01$P_fdr_Cog <- p.adjust(cov01$P_Cog, method="fdr")
cov02$P_fdr_Cog <- p.adjust(cov02$P_Cog, method="fdr")
cov03$P_fdr_Cog <- p.adjust(cov03$P_Cog, method="fdr")
cov0$P_fdr_NonCog <- p.adjust(cov0$P_NonCog, method="fdr")
cov01$P_fdr_NonCog <- p.adjust(cov01$P_NonCog, method="fdr")
cov02$P_fdr_NonCog <- p.adjust(cov02$P_NonCog, method="fdr")
cov03$P_fdr_NonCog <- p.adjust(cov03$P_NonCog, method="fdr")

data <- rbind(cov0, cov01, cov02, cov03)

#write.csv(data, "data_allcov_pval.csv", row.names=F)

### Figures ###

# manually change trait.names to nicely written ones
rgs <- read.csv("data_allcov.csv", header=T, stringsAsFactors = F)
head(rgs)

# Categories
education <- c("Childhood IQ", "Highest math class taken", "Self-reported math ability")

ses <- c("Household income", "Neighborhood deprivation","Longevity")

decision_making <- c("Risk tolerance", "Delay discounting")
fertility_risk <- c("Risk behaviour composite","Speeding propensity", "Ever smoker", "Age at smoking initiation", "Cigarettes per day", 
                    "Alcohol use", "Drinks per week", "Alcohol dependence", "Cannabis use",
                    "Age at menarche","Age at first sex", "Number of sexual partners", "Age at first birth Women", "Age at first birth Men",
                    "Number children ever born Women", "Number children ever born Men", "Age at menopause")
personality_traits <- c("Openness","Conscientiousness","Extraversion","Agreeableness","Neuroticism")


mental_health_traits <- c("Schizophrenia","Bipolar Disorder","Obsessive Compulsive Disorder","Anorexia Nervosa","Attention Deficit Hyperactivity Disorder","Major Depressive Disorder",
                          "Autism Spectrum Disorder")

supp <- c("Birth weight", "BMI", "Chronotype", "Height", "Insomnia", "Loneliness", "Mind in the Eyes score", "Self-rated health",  "Self-reported empathy ", "Subjective wellbeing", "Tiredness")

# Add columns with category names 

# add a column with the category name 
rgs$category <- NULL
rgs$category[rgs$trait.name %in% mental_health_traits] <- "Psychiatry"
rgs$category[rgs$trait.name %in% fertility_risk] <- "Health-Risk Behavior & Delayed Fertility"
rgs$category[rgs$trait.name %in% personality_traits] <- "Personality"
rgs$category[rgs$trait.name %in% decision_making] <- "Dec."
rgs$category[rgs$trait.name %in% ses] <- "SES"
rgs$category[rgs$trait.name %in% supp] <- "Supplementary"
rgs$category[rgs$trait.name %in% education] <- "Educ."


# Main figure

rgs$category_f <- factor(rgs$category, levels=c("Educ.", "SES", "Dec.",
                                                'Health-Risk Behavior & Delayed Fertility',
                                                'Personality','Psychiatry',"Supplementary")) # create a factor to fix the order of the facets in the figure
rgs$trait.name_f <- factor(rgs$trait.name, 
                                levels=c("Highest math class taken",
                                         "Self-reported math ability", 
                                         "Childhood IQ",
                                         "Household income", 
                                         "Neighborhood deprivation","Longevity",
                                         "Openness","Conscientiousness","Extraversion",
                                         "Agreeableness","Neuroticism",
                                         "Risk tolerance", "Delay discounting",
                                         "Risk behaviour composite","Speeding propensity",
                                         "Ever smoker", "Age at smoking initiation",
                                         "Cigarettes per day", "Alcohol use", 
                                         "Drinks per week", "Alcohol dependence", 
                                         "Cannabis use", "Age at menarche",
                                         "Age at first sex", "Number of sexual partners",
                                         "Age at first birth Women", 
                                         "Age at first birth Men",
                                         "Number children ever born Women",
                                         "Number children ever born Men",
                                         "Age at menopause",
                                         "Schizophrenia","Bipolar Disorder",
                                         "Obsessive Compulsive Disorder",
                                         "Anorexia Nervosa",
                                         "Attention Deficit Hyperactivity Disorder",
                                         "Major Depressive Disorder",
                                         "Autism Spectrum Disorder", 
                                         "Self-reported empathy ",
                                         "BMI",
                                         "Tiredness",
                                         "Mind in the Eyes score",
                                         "Insomnia",
                                         "Chronotype",
                                         "Subjective wellbeing",
                                         "Loneliness", 
                                         "Self-rated health",
                                         "Height", 
                                         "Birth weight"))

levels(rgs$trait.name_f)[levels(rgs$trait.name_f)=="Risk tolerance"]  <- "General risk tolerance"

rgs_fig4 <- rgs[which(rgs$trait.name %in% mental_health_traits | 
                      rgs$trait.name %in% fertility_risk | 
                      rgs$trait.name %in% personality_traits | 
                      rgs$trait.name %in% decision_making | 
                      rgs$trait.name %in% ses ),]
rgs_fig4$trait.name_f <- factor(rgs_fig4$trait.name, 
                                levels=c("Household income", 
                                         "Neighborhood deprivation","Longevity",
                                         "Openness","Conscientiousness","Extraversion",
                                         "Agreeableness","Neuroticism",
                                         "Risk tolerance", "Delay discounting",
                                         "Risk behaviour composite","Speeding propensity",
                                         "Ever smoker", "Age at smoking initiation",
                                         "Cigarettes per day", "Alcohol use", 
                                         "Drinks per week", "Alcohol dependence", 
                                         "Cannabis use", "Age at menarche",
                                         "Age at first sex", "Number of sexual partners",
                                         "Age at first birth – Women", 
                                         "Age at first birth – Men",
                                         "Number children ever born – Women",
                                         "Number children ever born – Men",
                                         "Age at menopause",
                                         "Schizophrenia","Bipolar Disorder",
                                         "Obsessive Compulsive Disorder",
                                         "Anorexia Nervosa",
                                         "Attention Deficit Hyperactivity Disorder",
                                         "Major Depressive Disorder",
                                         "Autism Spectrum Disorder"))

levels(rgs_fig4$trait.name_f)[levels(rgs_fig4$trait.name_f)=="Risk tolerance"]  <- "General risk tolerance"

### GIF ####
############

library(gganimate)
#install.packages('gifski')

# Main Figure

anim <- ggplot(rgs_fig4, aes(y=Est_NonCog, x=reorder(trait.name_f, desc(trait.name_f)))) + 
  scale_colour_manual( name="Data", values=c("0" = "#ff9933","1" = "#1E90FF"), labels = c("NonCog", "Cog")) + #need trick with both values and labels and number to order the legend.....
  scale_shape_manual( name="Data", values=c("0" =16,"1" =16), labels = c("NonCog", "Cog")) +
  geom_point(aes(y=Est_Cog, x=reorder(trait.name_f, desc(trait.name_f)),color="1", shape="1"), size=4) +
  geom_errorbar(aes(ymin=Est_Cog-1.96*SE_Cog, ymax=Est_Cog+1.96*SE_Cog,color="1"), width=.4, show.legend=FALSE) +
  geom_point(aes(y=Est_NonCog, x=reorder(trait.name_f, desc(trait.name_f)),color="0", shape="0"), size=4) + 
  geom_errorbar(aes(ymin=Est_NonCog-1.96*SE_NonCog, ymax=Est_NonCog+1.96*SE_NonCog,color="0", shape="0"), width=.4, show.legend=FALSE) +
    ylim(-1, 1) +
  geom_hline(yintercept = 0) +
  theme_light(base_size=12) +
  theme(axis.title.y=element_blank(),
        #axis.title.x=element_blank(),
        legend.title=element_blank()) +
  ylab("Genetic Correlation") +
  theme(legend.position="right") +
  facet_grid(category_f ~ ., scales = "free", space = "free_y") +
  coord_flip() + # flip y and x 
  transition_states(Covariance,
                    transition_length = 1,
                    state_length = 1, 
                    wrap = F) + 
  ggtitle('Cov(Cog, NonCog) = {closest_state}')
 
animate(anim + ease_aes('cubic-in-out'), 
        width=800, height=700, res=90)         
anim_save('Figure_rg_allcov_res90.gif')


# Supplementary Figure

sup <- rgs[which(rgs$category == "Supplementary"), ] 
sup

anim2 <- ggplot(sup, aes(y=Est_NonCog, x=reorder(trait.name, desc(trait.name)))) + 
  scale_colour_manual( name="Data", values=c("0" = "#ff9933","1" = "#1E90FF"), labels = c("NonCog", "Cog")) + #need trick with both values and labels and number to order the legend.....
  scale_shape_manual( name="Data", values=c("0" =16,"1" =16), labels = c("NonCog", "Cog")) +
  geom_point(aes(y=Est_Cog, x=reorder(trait.name, desc(trait.name)),color="1", shape="1"), size=4) +
  geom_errorbar(aes(ymin=Est_Cog-1.96*SE_Cog, ymax=Est_Cog+1.96*SE_Cog,color="1"), width=.4, show.legend=FALSE) +
  geom_point(aes(y=Est_NonCog, x=reorder(trait.name, desc(trait.name)),color="0", shape="0"), size=4) + 
  geom_errorbar(aes(ymin=Est_NonCog-1.96*SE_NonCog, ymax=Est_NonCog+1.96*SE_NonCog,color="0", shape="0"), width=.4, show.legend=FALSE) +
  ylim(-1, 1) +
  geom_hline(yintercept = 0) +
  theme_light(base_size=12) +
  theme(axis.title.y=element_blank(),
        #axis.title.x=element_blank(),
        legend.title=element_blank()) +
  ylab("Genetic Correlation") +
  theme(legend.position="right") +
  #facet_grid(category_f ~ ., scales = "free", space = "free_y") +
  coord_flip() + # flip y and x 
  transition_states(Covariance,
                    transition_length = 1,
                    state_length = 1, 
                    wrap = F) + 
  ggtitle('Cov(Cog, NonCog) = {closest_state}')

animate(anim2 + ease_aes('cubic-in-out'), 
        width=800, height=700, res=90)         
anim_save('Figure_supp_rg_allcov_res90.gif')


### Static figures ###
#####################

# all traits all cov

rgs$Covariance[rgs$Covariance == 0 ] <- "rG = 0"
rgs$Covariance[rgs$Covariance == 0.1 ] <- "rG = 0.1"
rgs$Covariance[rgs$Covariance == 0.2 ] <- "rG = 0.2"
rgs$Covariance[rgs$Covariance == 0.3 ] <- "rG = 0.3"

pdf("rG_fig4_cov_all_style.pdf",width=20,height=10) #
ggplot(rgs, aes(y=Est_NonCog, x=reorder(trait.name_f, desc(trait.name_f)))) + 
  scale_colour_manual( name="Data", values=c("0" = "#ff9933","1" = "#1E90FF"), labels = c("NonCog", "Cog")) + 
  scale_shape_manual( name="Data", values=c("0" =16,"1" =16), labels = c("NonCog", "Cog")) +
  geom_point(aes(y=Est_Cog, x=reorder(trait.name_f, desc(trait.name_f)),color="1", shape="1"), size=2) +
  geom_errorbar(aes(ymin=Est_Cog-1.96*SE_Cog, ymax=Est_Cog+1.96*SE_Cog,color="1"), width=.4, show.legend=FALSE) +
  geom_point(aes(y=Est_NonCog, x=reorder(trait.name_f, desc(trait.name_f)),color="0", shape="0"), size=2) + 
  geom_errorbar(aes(ymin=Est_NonCog-1.96*SE_NonCog, ymax=Est_NonCog+1.96*SE_NonCog,color="0", shape="0"), width=.4, show.legend=FALSE) +
  ylim(-0.9, 0.9) +
  geom_hline(yintercept = 0) +
  theme_light(base_size=12) +
  theme(axis.title.y=element_blank(),
        #axis.title.x=element_blank(),
        legend.title=element_blank()) +
  ylab("Genetic Correlation") +
  theme(legend.position="right") +
  facet_grid(category_f ~ Covariance, scales = "free", space = "free_y") +
  theme(strip.text = element_text(size=10, colour = 'black', face = "bold"),
        strip.background = element_rect(colour="gray", fill="white")) +
  coord_flip()
dev.off()


### Figure change in difference ###

rgs_cov0 <- rgs[rgs$Covariance == 0, ]
rgs_cov3 <- rgs[rgs$Covariance == 0.3, ]
rgsdiff <- merge( rgs_cov0, rgs_cov3, by= "trait.name", suffixes = c(".cov0",".cov3"))
head(rgsdiff)
rgsdiff$Diff <- abs(rgsdiff$Est_NonCog.cov0 - rgsdiff$Est_NonCog.cov3)
summary(lm(Diff ~ Est_Cog.cov0, data=rgsdiff))
plot(rgsdiff$Diff, abs(rgsdiff$Est_Cog.cov0), ylab = "Absolute Cog rG with target trait", xlab= "Absolute difference in NonCog rG with target trait \n when rG(Cog,NonCog)=0.0 versus rG(Cog,NonCog)=0.3")


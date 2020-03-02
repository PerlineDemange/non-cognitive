

# Example meta-analysis cognitive and non-cogntive PGS
# Including forest plots and joy plots
# Big 5 personality variables

# Packages needed
#install.packages("")
#require(metafor)
#require(ggplot2)
#require(ggsci)
#require(tidyverse)

# read in data:
data <- read.csv("",strip.white=TRUE, header = T, na.strings = 'NA')


#### META REGRESSION for NEUROTICISM:
#Select phenotype for meta-regression (Neuroticism)
neu <- data[data$Phenotype ==  "Big5-N",]

# 0) Baseline model
meta_regression_neu_null <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1 | cohort,data=neu)
summary(meta_regression_neu_null)

# 1) Meta-regression comparing effects for cognitive and noncognitive pgs
meta_regression_neu_01 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ factor(PGS),intercept = FALSE,random= ~ 1| cohort,data=neu,
                                 slab = paste(cohort,PGS))
summary(meta_regression_neu_01)
# Forest plot 
forest(meta_regression_neu_01, xlim=c(-1, 1),
       order=order(neu$cohort),  xlab="Big5-N", addcred=TRUE)

# 2) Separate meta regressions for cognitive and noncognitive pgs 

# 2a) Neuro COG
neuC <- data[c(data$Phenotype ==  "Big5-N"& data$PGS ==  "COG"),]
meta_regression_neu_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=neuC,
                                  slab = paste(cohort,PGS))
summary(meta_regression_neu_02)
# Forest plot only cognitive 
forest(meta_regression_neu_02, xlim=c(-1, 1),
       order=order(neuC$cohort),  xlab="Big5-N", addcred=TRUE)

# 2b) Neuro NONCOG
neuNC <- data[c(data$Phenotype ==  "Big5-N"& data$PGS ==  "NONCOG"),]
meta_regression_neu_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=neuNC,
                                  slab = paste(cohort,PGS))
summary(meta_regression_neu_03)
# Forest plot only noncognitive 
forest(meta_regression_neu_03, xlim=c(-1, 1),
       order=order(neuNC$cohort),  xlab="Big5-N", addcred=TRUE)

#### META REGRESSION for OPENNESS:
# Select phneotype
open <- data[data$Phenotype ==  "Big5-O",]
# 0) Baseline model
meta_regression_OPEN_null <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1 | cohort,data=open )
summary(meta_regression_OPEN_null)
# 1) Meta-regression comparing effects for cognitive and noncognitive pgs
meta_regression_OPEN_01 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ factor(PGS),intercept = FALSE,random= ~ 1| cohort,data=open,
                                  slab = paste(cohort,PGS))
summary(meta_regression_OPEN_01)
# Forest plot
forest(meta_regression_OPEN_01, xlim=c(-1, 1),
       order=order(open$cohort),  xlab="Big5-O", addcred=TRUE)

# 2) Separate meta regressions for cognitive and noncognitive pgs 

# 2a) cognitive
openC <- data[c(data$Phenotype ==  "Big5-O"& data$PGS ==  "COG"),]
meta_regression_open_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=openC,
                                 slab = paste(cohort,PGS))
summary(meta_regression_open_02)
forest(meta_regression_open_02, xlim=c(-1, 1),
       order=order(openC$cohort),  xlab="Big5-O", addcred=TRUE)

# 2b) noncognitive
openNC <- data[c(data$Phenotype ==  "Big5-O"& data$PGS ==  "NONCOG"),]
meta_regression_open_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=openNC,
                                 slab = paste(cohort,PGS))
summary(meta_regression_open_03)
forest(meta_regression_open_03, xlim=c(-1, 1),
       order=order(openNC$cohort),  xlab="Big5-O", addcred=TRUE)

#### META REGRESSION for EXTRAVERSION:

Extra <- data[data$Phenotype ==  "Big5-E",]

# 0) Baseline
meta_regression_Extra_null <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1 | cohort,data=Extra)
summary(meta_regression_Extra_null )
# 1) Meta-regression comparing effects for cognitive and noncognitive pgs
meta_regression_Extra_01 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ factor(PGS),intercept = FALSE,random= ~ 1| cohort,data=Extra,
                                   slab = paste(cohort,PGS))
summary(meta_regression_Extra_01)

forest(meta_regression_Extra_01, xlim=c(-1, 1),
       order=order(Extra$cohort),  xlab="Big5-E", addcred=TRUE)

# 2) Separate meta regressions for cognitive and noncognitive pgs 
# 2a) cognitive
extraC <- data[c(data$Phenotype ==  "Big5-E"& data$PGS ==  "COG"),]
meta_regression_extra_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=extraC,
                                  slab = paste(cohort,PGS))
summary(meta_regression_extra_02)
forest(meta_regression_extra_02, xlim=c(-1, 1),
       order=order(extraC$cohort),  xlab="Big5-E", addcred=TRUE)

# 2b) noncognitive
extraNC <- data[c(data$Phenotype ==  "Big5-E"& data$PGS ==  "NONCOG"),]
meta_regression_extra_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=extraNC,
                                   slab = paste(cohort,PGS))
summary(meta_regression_extra_03)
forest(meta_regression_extra_03, xlim=c(-1, 1),
       order=order(extraNC$cohort),  xlab="Big5-E", addcred=TRUE)

#### META REGRESSION for Agreeableness:
Agree <- data[data$Phenotype ==  "Big5-A",]
# 0) Baseline model
meta_regression_Agree_null <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1 | cohort,data=Agree )
summary(meta_regression_Agree_null )
# 1) Meta-regression comparing effects for cognitive and noncognitive pgs 
meta_regression_Agree_01 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ factor(PGS),intercept = FALSE,random= ~ 1| cohort,data=Agree,
                                   slab = paste(cohort,PGS))
summary(meta_regression_Agree_01)

forest(meta_regression_Agree_01, xlim=c(-1, 1),
       order=order(Agree$cohort),  xlab="Big5-A", addcred=TRUE)
# 2) Separate meta regressions for cognitive and noncognitive pgs 
# 2a) cognitive
agreeC <- data[c(data$Phenotype ==  "Big5-A"& data$PGS ==  "COG"),]
meta_regression_agree_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=agreeC,
                                   slab = paste(cohort,PGS))
summary(meta_regression_agree_02)
forest(meta_regression_agree_02, xlim=c(-1, 1),
       order=order(agreeC$cohort),  xlab="Big5-A", addcred=TRUE)

# 2b) noncognitive
agreeNC <- data[c(data$Phenotype ==  "Big5-A"& data$PGS ==  "NONCOG"),]
meta_regression_agree_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=agreeNC,
                                   slab = paste(cohort,PGS))
summary(meta_regression_agree_03)
forest(meta_regression_agree_03, xlim=c(-1, 1),
       order=order(agreeNC$cohort),  xlab="Big5-A", addcred=TRUE)


#### META REGRESSION for Conscientiousness:

Cons<- data[data$Phenotype ==  "Big5-C",]
# 0) Baseline 
meta_regression_Cons_null <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1 | cohort,data=Cons )
summary(meta_regression_Cons_null )

# 1) Meta-regression comparing effects for cognitive and noncognitive pgs 
meta_regression_Cons_01 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ factor(PGS),intercept = FALSE,random= ~ 1| cohort,data=Cons,
                                  slab = paste(cohort, PGS))
summary(meta_regression_Cons_01)
forest(meta_regression_Cons_01, xlim=c(-.6, .8),
  order=order(Cons$PGS),  xlab="Big5-C", addcred=TRUE)

# 2) Separate meta regressions for cognitive and noncognitive pgs 
# 2a) cognitive
ConsC <- data[c(data$Phenotype ==  "Big5-C"& data$PGS ==  "COG"),]
meta_regression_Cons_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=ConsC,
                                  slab = paste(cohort,PGS))
summary(meta_regression_Cons_02)
forest(meta_regression_Cons_02, xlim=c(-.6, .8),
       order=order(ConsC$PGS),  xlab="Big5-C", addcred=TRUE)

# 2b) noncognitive
ConsNC <- data[c(data$Phenotype ==  "Big5-C"& data$PGS ==  "NONCOG"),]
meta_regression_Cons_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=ConsNC,
                                  slab = paste(cohort,PGS))
summary(meta_regression_Cons_03)
forest(meta_regression_Cons_03, xlim=c(-.6, .8),
       order=order(ConsNC$PGS),  xlab="Big5-C", addcred=TRUE)

### Visualize results (simple visualization)
######### Pull values from meta-regressions ########
open_cog <- cbind.data.frame(meta_regression_open_02$b,meta_regression_open_02$ci.lb,meta_regression_open_02$ci.ub,
                             "BFI-O","COG")
open_noncog <- cbind.data.frame(meta_regression_open_03$b,meta_regression_open_03$ci.lb,meta_regression_open_03$ci.ub,
                             "BFI-O","NONCOG")
cons_cog <- cbind.data.frame(meta_regression_Cons_02$b,meta_regression_Cons_02$ci.lb,meta_regression_Cons_02$ci.ub,
                             "BFI-C","COG")
cons_noncog <- cbind.data.frame(meta_regression_Cons_03$b,meta_regression_Cons_03$ci.lb,meta_regression_Cons_03$ci.ub,
                             "BFI-C","NONCOG")
extra_cog<- cbind.data.frame(meta_regression_extra_02$b,meta_regression_extra_02$ci.lb,meta_regression_extra_02$ci.ub,
                              "BFI-E","COG")
extra_noncog<- cbind.data.frame(meta_regression_extra_03$b,meta_regression_extra_03$ci.lb,meta_regression_extra_03$ci.ub,
                              "BFI-E","NONCOG")
agree_cog<- cbind.data.frame(meta_regression_agree_02$b,meta_regression_agree_02$ci.lb,meta_regression_agree_02$ci.ub,
                             "BFI-A","COG")
agree_noncog<- cbind.data.frame(meta_regression_agree_03$b,meta_regression_agree_03$ci.lb,meta_regression_agree_03$ci.ub,
                             "BFI-A","NONCOG")
neu_cog<-cbind.data.frame(meta_regression_neu_02$b,meta_regression_neu_02$ci.lb,meta_regression_neu_02$ci.ub,
                          "BFI-N","COG")
neu_noncog<-cbind.data.frame(meta_regression_neu_03$b,meta_regression_neu_03$ci.lb,meta_regression_neu_03$ci.ub,
                             "BFI-N","NONCOG")

colnames(open_cog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(open_noncog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(cons_cog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(cons_noncog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(extra_cog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(extra_noncog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(agree_cog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(agree_noncog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(neu_cog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")
colnames(neu_noncog) <- c("meta_B","meta_ci.lb", "meta_ci.ub","phenotype","PGS")

bfimeta<- rbind.data.frame(open_cog,open_noncog, cons_cog, cons_noncog, extra_cog,
                           extra_noncog,agree_cog,agree_noncog, neu_cog,neu_noncog)

bfimeta$PGS_f = factor(bfimeta$PGS, levels=c('NONCOG','COG'))
bfimeta$PGS_f2<- dplyr::recode(bfimeta$PGS_f,`NONCOG` = "Noncognitive", `COG` = "Cognitive")

bfimeta$phenotype_f <- factor(bfimeta$phenotype, levels=c("BFI-N","BFI-A","BFI-E", 
                                                          "BFI-C",'BFI-O'))

bfimeta$phenotype_f<- dplyr::recode(bfimeta$phenotype_f, 
                                     `BFI-N` = "Neuroticism", `BFI-A` = "Agreeableness",
                                     `BFI-E` = "Extraversion", `BFI-C` = "Conscientiousness", 
                                     `BFI-O` = "Openness")

                     
p = ggplot(bfimeta, aes(x = phenotype_f, y = meta_B, ymin= meta_ci.lb, ymax=meta_ci.ub, color=PGS_f2))+
    geom_pointrange(size = 1, alpha = .8)+
    geom_hline(yintercept=0, linetype = "solid", size = 0.4)+
    theme(legend.position= c(.80,.7),
    legend.text = element_text(size = 16,colour="black", family = "sans"),
    legend.title = element_blank(),
    panel.grid.major = element_blank(),panel.background = element_blank(),
    panel.border = element_blank(),panel.grid=element_blank(),
    plot.background=element_blank(),
    axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
    axis.line.y = element_line(colour = 'white', size=0.5, linetype='solid'),
    axis.text = element_text(size = 16, colour="black", family = "sans"), axis.title= element_text(size = 16),
    panel.grid.minor = element_blank())+
    #panel.spacing=unit(1, "lines"))+
    ylim(-0.3,0.3)+
    xlab(" ")+ ylab("Meta-analytic PGS predictions")+
    coord_flip()
p
p1= p+ scale_color_manual(values=c("darkorange","royalblue"))

p2=  p1+#facet_wrap(~PGS_f)+
  theme(
    strip.background = element_rect(
      color="black", fill="white", size=1.5, linetype="solid"
    )) 

p2
### Replot Each PGS on a separate line 

bfimeta<- transform(bfimeta, phenotype_f_PGS=paste(phenotype_f, PGS, sep=" "))

bfimeta$phenotype_f_PGS <- factor(bfimeta$phenotype_f_PGS, levels=c("Neuroticism NONCOG","Neuroticism COG",
                                                            "Agreeableness NONCOG", "Agreeableness COG",
                                                            "Extraversion NONCOG", "Extraversion COG",
                                                            "Conscientiousness NONCOG", "Conscientiousness COG",
                                                            "Openness NONCOG", "Openness COG"))


p = ggplot(bfimeta, aes(x = factor(phenotype_f_PGS),
                        y = meta_B, ymin= meta_ci.lb, ymax=meta_ci.ub,color=factor(PGS)
))+
  geom_pointrange(size = 1, alpha = 1)+
  geom_hline(yintercept=0, linetype = "dashed", size = 0.4)+
  theme(legend.position='bottom',
        legend.text = element_text(size = 14, colour="black", family = "sans"),
        panel.grid.major = element_blank(),panel.background = element_blank(),
        panel.border = element_blank(),panel.grid=element_blank(),
        plot.background=element_blank(),
        axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
        axis.line.y = element_line(colour = 'white', size=0.5, linetype='solid'),
        axis.text = element_text(size = 14, colour="black", family = "sans"), axis.title= element_text(size = 16),
        panel.grid.minor = element_blank(),
        panel.spacing=unit(1.5, "lines"))+
  ylim(-0.2,0.2)+
  xlab(" ")+ ylab("Estimates")+
  coord_flip()


p1=  p+#facet_wrap(~PGS_f)+
  theme(
    strip.background = element_rect(
      color="black", fill="white", size=1.5, linetype="solid"
    )
  ) 
p2 = p1+scale_colour_npg(name="PGS")

p2

### Visualize teh results Joy plots 

### Trait: Big 5 Personality
# Sample: 1 Texas
# NONCOG 

dataset1 <- cbind.data.frame(rnorm(10000,0.0835360,0.0426610), "Big5-O", "NONCOG", "TexasTwins")
dataset2 <- cbind.data.frame(rnorm(10000,0.0631170,0.0427470), "Big5-C", "NONCOG", "TexasTwins")
dataset3 <- cbind.data.frame(rnorm(10000,-0.0213081,0.0434709),"Big5-E", "NONCOG", "TexasTwins")
dataset4 <- cbind.data.frame(rnorm(10000,-0.0027570,0.0430460),"Big5-A", "NONCOG", "TexasTwins")
dataset5 <- cbind.data.frame(rnorm(10000,-0.0272375,0.0430827),"Big5-N", "NONCOG", "TexasTwins")

colnames(dataset1) <- c("Density","trait", "pgs", "cohort")
colnames(dataset2) <- c("Density","trait", "pgs", "cohort")
colnames(dataset3) <- c("Density","trait", "pgs", "cohort")
colnames(dataset4) <- c("Density","trait", "pgs", "cohort")
colnames(dataset5) <- c("Density","trait", "pgs", "cohort")

#COG 

dataset6 <- cbind.data.frame(rnorm (10000,-0.0493820,0.0425850), "Big5-O", "COG", "TexasTwins")
dataset7 <- cbind.data.frame(rnorm (10000,0.0368410,0.0430000),  "Big5-C", "COG", "TexasTwins")
dataset8 <- cbind.data.frame(rnorm (10000,-0.0614145,0.0438634), "Big5-E", "COG", "TexasTwins")
dataset9 <- cbind.data.frame(rnorm (10000,0.0193640,0.0433190),  "Big5-A", "COG", "TexasTwins")
dataset10 <- cbind.data.frame(rnorm(10000,-0.0820698,0.0426953),"Big5-N", "COG", "TexasTwins")

colnames(dataset6)  <- c("Density","trait", "pgs","cohort")
colnames(dataset7)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset8)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset9)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset10) <- c("Density","trait", "pgs", "cohort")

tt <- rbind.data.frame(dataset1,dataset2, dataset3, dataset4, dataset5,
                       dataset6, dataset7, dataset8, dataset9, dataset10)


# Sample 2 NTR 

# Since personality measures were available at multiple waves,
#Meta-analyze the NTR samples before plotting (end product: 1 estimate per cohort)

dataNTR <- subset(data, cohort=="NTRteens"| cohort=="NTRadults")

#### META REGRESSION for NEURO:
### Neuro COG
NTRneuC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-N"& dataNTR$PGS ==  "COG"),]
NTRmeta_regression_neu_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRneuC,
                                 slab = paste(cohort,PGS))
summary(NTRmeta_regression_neu_02)

### Neuro NONCOG
NTRneuNC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-N"& dataNTR$PGS ==  "NONCOG"),]
NTRmeta_regression_neu_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRneuNC,
                                 slab = paste(cohort,PGS))
summary(NTRmeta_regression_neu_03)

### Open COG
NTRopenC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-O"& dataNTR$PGS ==  "COG"),]
NTRmeta_regression_open_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRopenC,
                                  slab = paste(cohort,PGS))
summary(NTRmeta_regression_open_02)

### Open NONCOG
NTRopenNC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-O"& dataNTR$PGS ==  "NONCOG"),]
NTRmeta_regression_open_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRopenNC,
                                  slab = paste(cohort,PGS))
summary(NTRmeta_regression_open_03)

#### META REGRESSION for Extra:
### Extra COG
NTRextraC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-E"& dataNTR$PGS ==  "COG"),]
NTRmeta_regression_extra_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRextraC,
                                   slab = paste(cohort,PGS))
summary(NTRmeta_regression_extra_02)

### Extra NONCOG
NTRextraNC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-E"& dataNTR$PGS ==  "NONCOG"),]
NTRmeta_regression_extra_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRextraNC,
                                   slab = paste(cohort,PGS))
summary(NTRmeta_regression_extra_03)

#### META REGRESSION for Agreeableness:
### Agreeableness COG
NTRagreeC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-A"& dataNTR$PGS ==  "COG"),]
NTRmeta_regression_agree_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRagreeC,
                                   slab = paste(cohort,PGS))
summary(NTRmeta_regression_agree_02)

### Agreeabeness NONCOG
NTRagreeNC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-A"& dataNTR$PGS ==  "NONCOG"),]
NTRmeta_regression_agree_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRagreeNC,
                                   slab = paste(cohort,PGS))
summary(NTRmeta_regression_agree_03)

#### META REGRESSION for Cons:
### Conscientiousness COG
NTRConsC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-C"& dataNTR$PGS ==  "COG"),]
NTRmeta_regression_Cons_02 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRConsC,
                                  slab = paste(cohort,PGS))
summary(NTRmeta_regression_Cons_02)

### Conscientiousness NONCOG
NTRConsNC <- dataNTR[c(dataNTR$Phenotype ==  "Big5-C"& dataNTR$PGS ==  "NONCOG"),]
NTRmeta_regression_Cons_03 <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1| cohort,data=NTRConsNC,
                                  slab = paste(cohort,PGS))
summary(NTRmeta_regression_Cons_03)



### Sample: NTR All (Meta-anayzed estimates)
### PGS: NONCOG 

dataset1 <- cbind.data.frame(rnorm(10000,NTRmeta_regression_open_03$b,NTRmeta_regression_open_03$se),   "Big5-O", "NONCOG","NTR")
dataset2 <- cbind.data.frame(rnorm(10000,NTRmeta_regression_Cons_03$b,NTRmeta_regression_Cons_03$se),   "Big5-C", "NONCOG","NTR")
dataset3 <- cbind.data.frame(rnorm(10000,NTRmeta_regression_extra_03$b,NTRmeta_regression_extra_03$se), "Big5-E", "NONCOG","NTR")
dataset4 <- cbind.data.frame(rnorm(10000,NTRmeta_regression_agree_03$b,NTRmeta_regression_agree_03$se), "Big5-A", "NONCOG","NTR")
dataset5 <- cbind.data.frame(rnorm(10000,NTRmeta_regression_neu_03$b,  NTRmeta_regression_neu_03$se),   "Big5-N", "NONCOG","NTR")

colnames(dataset1) <- c("Density","trait", "pgs", "cohort")
colnames(dataset2) <- c("Density","trait", "pgs", "cohort")
colnames(dataset3) <- c("Density","trait", "pgs", "cohort")
colnames(dataset4) <- c("Density","trait", "pgs", "cohort")
colnames(dataset5) <- c("Density","trait", "pgs", "cohort")

### PGS: COG 

dataset6  <- cbind.data.frame(rnorm(10000,NTRmeta_regression_open_02$b,NTRmeta_regression_open_02$se),   "Big5-O", "COG","NTR")
dataset7  <- cbind.data.frame(rnorm(10000,NTRmeta_regression_Cons_02$b,NTRmeta_regression_Cons_02$se),   "Big5-C", "COG","NTR")
dataset8  <- cbind.data.frame(rnorm(10000,NTRmeta_regression_extra_02$b,NTRmeta_regression_extra_02$se), "Big5-E", "COG","NTR")
dataset9  <- cbind.data.frame(rnorm(10000,NTRmeta_regression_agree_02$b,NTRmeta_regression_agree_02$se), "Big5-A", "COG","NTR")
dataset10 <- cbind.data.frame(rnorm(10000,NTRmeta_regression_neu_02$b,  NTRmeta_regression_neu_02$se),   "Big5-N", "COG","NTR")

colnames(dataset6)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset7)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset8)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset9)  <- c("Density","trait", "pgs", "cohort")
colnames(dataset10) <- c("Density","trait", "pgs", "cohort")

ntr<- rbind.data.frame(dataset1,dataset2, dataset3, dataset4, dataset5,
                       dataset6, dataset7, dataset8, dataset9, dataset10)

# Sample 3: Add Health 

dataset1 <- cbind.data.frame(rnorm(10000,0.13017,0.0150), "Big5-O", "NONCOG","Add Health")
dataset2 <- cbind.data.frame(rnorm(10000,0.03793,0.0152),  "Big5-C", "NONCOG","Add Health")
dataset3 <- cbind.data.frame(rnorm(10000,0.02560,0.0149),  "Big5-E", "NONCOG","Add Health")
dataset4 <- cbind.data.frame(rnorm(10000,0.07079,0.0141),  "Big5-A", "NONCOG","Add Health")
dataset5 <- cbind.data.frame(rnorm(10000,-0.11148,0.0148),  "Big5-N", "NONCOG","Add Health")

colnames(dataset1) <- c("Density","trait", "pgs", "cohort")
colnames(dataset2) <- c("Density","trait", "pgs", "cohort")
colnames(dataset3) <- c("Density","trait", "pgs", "cohort")
colnames(dataset4) <- c("Density","trait", "pgs", "cohort")
colnames(dataset5) <- c("Density","trait", "pgs", "cohort")

dataset6  <- cbind.data.frame(rnorm(10000,0.13694,	0.0163),    "Big5-O", "COG","Add Health" )
dataset7  <- cbind.data.frame(rnorm(10000,-0.00998,	0.0166),    "Big5-C", "COG","Add Health")
dataset8  <- cbind.data.frame(rnorm(10000,-0.00552,	0.0162),    "Big5-E", "COG","Add Health")
dataset9  <- cbind.data.frame(rnorm(10000,0.07157,	0.0153),    "Big5-A", "COG","Add Health")
dataset10 <- cbind.data.frame(rnorm(10000,-0.11687,	0.0161),    "Big5-N", "COG","Add Health")

colnames(dataset6)  <- c("Density","trait","pgs", "cohort")
colnames(dataset7)  <- c("Density","trait","pgs", "cohort")
colnames(dataset8)  <- c("Density","trait","pgs", "cohort")
colnames(dataset9)  <- c("Density","trait","pgs", "cohort")
colnames(dataset10) <- c("Density","trait","pgs", "cohort")

addhealth<- rbind.data.frame(dataset1,dataset2, dataset3, dataset4, dataset5,
                             dataset6, dataset7, dataset8, dataset9, dataset10)

#Sample 4: WLS
dataset1 <- cbind.data.frame(rnorm(10000,	 0.1027901	, 0.01307324),   "Big5-O", "NONCOG","WLS")
dataset2 <- cbind.data.frame(rnorm(10000,	-0.011303557,	0.013290269),  "Big5-C", "NONCOG","WLS")
dataset3 <- cbind.data.frame(rnorm(10000,	-0.013882973,	0.013425627),  "Big5-E", "NONCOG","WLS")
dataset4 <- cbind.data.frame(rnorm(10000,	 0.008309774,	0.012846622),  "Big5-A", "NONCOG","WLS")
dataset5 <- cbind.data.frame(rnorm(10000,	-0.041431368,	0.013560354),  "Big5-N", "NONCOG","WLS")

colnames(dataset1) <- c("Density","trait", "pgs", "cohort")
colnames(dataset2) <- c("Density","trait", "pgs", "cohort")
colnames(dataset3) <- c("Density","trait", "pgs", "cohort")
colnames(dataset4) <- c("Density","trait", "pgs", "cohort")
colnames(dataset5) <- c("Density","trait", "pgs", "cohort")

dataset6  <- cbind.data.frame(rnorm(10000, 0.090043555,0.013441123),    "Big5-O", "COG","WLS" )
dataset7  <- cbind.data.frame(rnorm(10000,-0.031993323,0.013409965),    "Big5-C", "COG","WLS")
dataset8  <- cbind.data.frame(rnorm(10000, 0.013423319,0.013247415),    "Big5-E", "COG","WLS")
dataset9  <- cbind.data.frame(rnorm(10000,-0.039027719,0.013073246),    "Big5-A", "COG","WLS")
dataset10 <- cbind.data.frame(rnorm(10000,-0.024548232,0.013324075),    "Big5-N", "COG","WLS")

colnames(dataset6)  <- c("Density","trait","pgs", "cohort")
colnames(dataset7)  <- c("Density","trait","pgs", "cohort")
colnames(dataset8)  <- c("Density","trait","pgs", "cohort")
colnames(dataset9)  <- c("Density","trait","pgs", "cohort")
colnames(dataset10) <- c("Density","trait","pgs", "cohort")

wls<- rbind.data.frame(dataset1,dataset2, dataset3, dataset4, dataset5,
                       dataset6, dataset7, dataset8, dataset9, dataset10)



#Combine all datasets

data_all <- rbind.data.frame(tt, ntr, wls, addhealth)

data_all[,2] <- as.factor(data_all[,2])
data_all[,3] <- as.factor(data_all[,3])

#library(ggplot2)
#library(ggridges)
#library(ggsci)
#library(gridExtra)

###### Plot Joy plot 
##### Combine joy plot and meta-estimate plot into 1 plot

datcog <- data_all[data_all$pgs != "NONCOG",]

CogBig5meta<- ggplot(datcog, aes(x = Density, y = trait_r, fill = cohort))+ 
  geom_vline(xintercept=0, linetype = "dashed", color = "black", size = 0.4)+
  geom_density_ridges(
    aes(x = Density, fill = paste(cohort)), 
    alpha = .6, color = "white", from = -.9, to = .9, scale = .7) +
  theme(legend.position='bottom',
       legend.text =  element_text(size = 12), 
        panel.grid.major = element_blank(),panel.background = element_blank(),
        panel.border = element_blank(),panel.grid=element_blank(),
        plot.background=element_blank(),
        axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
        axis.line.y = element_line(colour = 'white', size=0.5, linetype='solid'),
        axis.ticks.y = element_blank(),
        axis.title= element_text(size = 14),
        axis.text.x =  element_text(size = 14, colour="black", family = "sans"),
        axis.text.y =  element_text(size = 14, colour="black", family = "sans"),
        axis.title.x = element_text(size = 14),
        #axis.text.x=element_blank(),
        #axis.ticks.x=element_blank(),
        panel.grid.minor = element_blank(),
        #panel.spacing=unit(1.5, "lines")
        plot.title = element_text(hjust = 0.5, size  =14),
        plot.margin = unit(c(.5, .5, .5, .5), "cm"))+
  xlab('Estimates')+ 
  ggtitle('Cognitive')+
  ylab('')+
  xlim(-0.25,0.35)

#Big5meta1=Big5meta+facet_grid(.~pgs)+theme(
#  strip.background = element_rect(
#    color="black", fill="white", size=1.5, linetype="solid"
#  )
#)

#scale_fill_nejm()+coord_cartesian(xlim = c(-0.3,.3))
#Big5meta+scale_colour_manual(values = c("red", "blue", "green", "black"))

CogBig5meta1 = CogBig5meta+ scale_fill_manual(values=c('firebrick3',
                                                       'turquoise2','springgreen1', 'darkorchid'), name = " ",
                     labels = c("Add health", "NTR","Texas Twins", "WLS"))
#CogBig5meta1 = CogBig5meta1+ scale_y_discrete (labels = c( "Neuroticism","Agreeableness","Extraversion",
#                                                           "Conscientiousness","Openness"))

CogBig5meta2=CogBig5meta1+ annotate("point", x = open_cog$meta_B, y = 4.8, colour = "black", size = 1.5)
CogBig5meta3=CogBig5meta2 + annotate("segment",x = open_cog$meta_ci.lb, xend = open_cog$meta_ci.ub, y = 4.8, yend = 4.8, 
                                     colour = "black", size=0.9)

CogBig5meta4=CogBig5meta3+ annotate("point", x = cons_cog$meta_B, y = 3.8, colour = "black", size = 1.5)
CogBig5meta5=CogBig5meta4 + annotate("segment",x = cons_cog$meta_ci.lb, xend =cons_cog$meta_ci.ub, y = 3.8, yend = 3.8, 
                                     colour = "black", size=0.9)


CogBig5meta6=CogBig5meta5+ annotate("point", x = extra_cog$meta_B, y = 2.8, colour = "black", size = 1.5)
CogBig5meta7=CogBig5meta6 + annotate("segment",x = extra_cog$meta_ci.lb, xend =extra_cog$meta_ci.ub, y = 2.8, yend = 2.8, 
                                     colour = "black", size=0.9)

CogBig5meta8=CogBig5meta7 + annotate("point", x =  agree_cog$meta_B, y = 1.8, colour = "black", size = 1.5)
CogBig5meta9=CogBig5meta8 + annotate("segment",x = agree_cog$meta_ci.lb, xend = agree_cog$meta_ci.ub, y = 1.8, yend = 1.8, 
                                     colour = "black", size=0.9)

CogBig5meta10=CogBig5meta9 + annotate("point", x =  neu_cog$meta_B, y = 0.8, colour = "black", size = 1.5)
CogBig5meta11=CogBig5meta10 + annotate("segment",x = neu_cog$meta_ci.lb, xend = neu_cog$meta_ci.ub, y = 0.8, yend = 0.8, 
                                     colour = "black", size=0.9)

CogBig5meta11



#######################################################################################
##NON COG

datnoncog <- data_all[data_all$pgs != "COG",]
#datnoncog$trait_f <- factor(datnoncog$trait, levels=c ('Big5-N','Big5-A','Big5-E','Big5-C',"Big5-O" )) 

NCogBig5meta<- ggplot(datnoncog, aes(x = Density, y = trait_r, fill = cohort))+ 
  geom_vline(xintercept=0, linetype = "dashed", color = "black", size = 0.4)+
  geom_density_ridges(
    aes(x = Density, fill = paste(cohort)), 
    alpha = 0.6, color = "white", from = -.9, to = .9,scale = .7) +
  theme(legend.position= 'bottom',
        legend.text = element_text(size = 14),
        panel.grid.major = element_blank(),panel.background = element_blank(),
        panel.border = element_blank(),panel.grid=element_blank(),
        plot.background=element_blank(),
        axis.line.y = element_line(colour = 'white', size=0.5, linetype='solid'),
        axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
        axis.text.x =  element_text(size = 14, colour="black", family = "sans"),
        axis.text.y =  element_text(size = 14, colour="black", family = "sans"), 
        axis.title.x = element_text(size = 14),
        axis.ticks.y=element_blank(),
        panel.grid.minor = element_blank(),
        #panel.spacing=unit(1.5, "lines")
        plot.title = element_text(hjust = 0.5),
        plot.margin = unit(c(.5, 1.5, .5, .5), "cm"))+
  xlab('Estimates')+ 
  ggtitle('Non-Cognitive')+
  ylab('')+
  xlim(-0.25,0.35)

#Big5meta1=Big5meta+facet_grid(.~pgs)+theme(
#  strip.background = element_rect(
#    color="black", fill="white", size=1.5, linetype="solid"
#  )
#)

#scale_fill_nejm()+coord_cartesian(xlim = c(-0.3,.3))
#Big5meta+scale_colour_manual(values = c("red", "blue", "green", "black"))

NCogBig5meta1 = NCogBig5meta+ scale_fill_manual(values=c('firebrick3',
                                                         'turquoise2','springgreen1', 'darkorchid'), name = "Data",
                                              labels = c("Add health", "NTR","Texas Twins", "WLS"))
NCogBig5meta1 = NCogBig5meta1+ scale_y_discrete (labels = c( "Neuroticism","Agreeableness","Extraversion",
                                                           "Conscientiousness","Openness"))

NCogBig5meta2=NCogBig5meta1+ annotate("point", x = open_noncog$meta_B , y = 4.8, colour = "black", size = 1.5)
NCogBig5meta3=NCogBig5meta2 + annotate("segment",x = open_noncog$meta_ci.lb, xend = open_noncog$meta_ci.ub, y = 4.8, yend = 4.8, 
                                     colour = "black", size=0.9)

NCogBig5meta4=NCogBig5meta3+ annotate("point", x = cons_noncog$meta_B, y = 3.8, colour = "black", size = 1.5)
NCogBig5meta5=NCogBig5meta4 + annotate("segment",x = cons_noncog$meta_ci.lb , xend = cons_noncog$meta_ci.ub, y = 3.8, yend = 3.8, 
                                     colour = "black", size=0.9)


NCogBig5meta6=NCogBig5meta5+ annotate("point", x = extra_noncog$meta_B, y = 2.8, colour = "black", size = 1.5)
NCogBig5meta7=NCogBig5meta6 + annotate("segment",x = extra_noncog$meta_ci.lb, xend = extra_noncog$meta_ci.ub, y = 2.8, yend = 2.8, 
                                     colour = "black", size=0.9)

NCogBig5meta8=NCogBig5meta7 + annotate("point", x =  agree_noncog$meta_B, y = 1.8, colour = "black", size = 1.5)
NCogBig5meta9=NCogBig5meta8 + annotate("segment",x = agree_noncog$meta_ci.lb, xend = agree_noncog$meta_ci.ub, y = 1.8, yend = 1.8, 
                                     colour = "black", size=0.9)

NCogBig5meta10=NCogBig5meta9 + annotate("point", x =  neu_noncog$meta_B, y = 0.8, colour = "black", size = 1.5)
NCogBig5meta11=NCogBig5meta10 + annotate("segment",x = neu_noncog$meta_ci.lb, xend = neu_noncog$meta_ci.ub, y = 0.8, yend = 0.8, 
                                       colour = "black", size=0.9)

NCogBig5meta11

grid.arrange(CogBig5meta11, NCogBig5meta11, nrow = 1)




##### Alternative: Cog and Non-Cog on the same panel

data_all2<- transform(data_all, trait_PGS=paste(trait_r, pgs, sep=" "))
data_all2$trait_PGS_f <- factor(data_all2$trait_PGS, levels=c("Neuroticism COG","Neuroticism NONCOG",
                                                              "Agreeableness COG", "Agreeableness NONCOG",
                                                              "Extraversion COG", "Extraversion NONCOG",
                                                              "Conscientiousness COG", "Conscientiousness NONCOG",
                                                              "Openness COG", "Openness NONCOG" ))


data_all2[,2] <- as.factor(data_all2[,2])
data_all2[,3] <- as.factor(data_all2[,3])
data_all2[,5] <- as.factor(data_all2[,5])


Big5meta_y<- ggplot(data_all2, aes(x = Density, y = trait_PGS_f, fill = cohort))+ 
  geom_vline(xintercept=0, linetype = "dashed", color = "black", size = 0.4)+
  geom_density_ridges(
    aes(x = Density, fill = paste(cohort)), 
    alpha = 0.6, color = "white", from = -.9, to = .9,scale = .7) +
  theme(legend.position='bottom',
        legend.text = element_text(size=12),
        panel.grid.major = element_blank(),panel.background = element_blank(),
        panel.border = element_blank(),panel.grid=element_blank(),
        plot.background=element_blank(),
        axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
        axis.line.y = element_line(colour = 'white', size=0.5, linetype='solid'),
        axis.text.y =  element_text(size = 12, colour="black", family = "sans"),
        axis.text.x =  element_text(size = 12, colour="black", family = "sans"), 
        axis.title= element_text(size = 12),
        #axis.text.x=element_blank(),
        #axis.ticks.x=element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing=unit(1.5, "lines"))+
  xlab('Estimates')+ 
  ylab('')+xlim(-0.25,0.35)

Big5meta1_y=Big5meta_y+
  #facet_grid(.~pgs)+
  theme(
  strip.background = element_rect(
    color="black", fill="white", size=1.5, linetype="solid"
  )
)

#scale_fill_nejm()+coord_cartesian(xlim = c(-0.3,.3))
#Big5meta+scale_colour_manual(values = c("red", "blue", "green", "black"))

Big5meta2_y = Big5meta1_y+ scale_fill_manual(values=c('firebrick3',
                                            'turquoise2','springgreen1', 'darkorchid'), name = "Data",
                                         labels = c("Add health", "NTR","Texas Twins", "WLS"))
Big5meta2_y

Big5meta3_y=Big5meta2_y+ annotate("point", x = open_noncog$meta_B , y = 9.8, colour = "black", size = 1.5)
Big5meta4_y=Big5meta3_y + annotate("segment",x = open_noncog$meta_ci.lb, xend = open_noncog$meta_ci.ub, y = 9.8, yend = 9.8, 
                                       colour = "black", size=0.9)

Big5meta5_y=Big5meta4_y+ annotate("point", x = open_cog$meta_B, y = 8.8, colour = "gray65", size = 1.5)
Big5meta6_y=Big5meta5_y + annotate("segment",x = open_cog$meta_ci.lb, xend = open_cog$meta_ci.ub, y = 8.8, yend = 8.8, 
                                     colour = "gray65", size=0.9)

Big5meta7_y=Big5meta6_y+ annotate("point", x = cons_noncog$meta_B, y = 7.8, colour = "black", size = 1.5)
Big5meta8_y=Big5meta7_y + annotate("segment",x = cons_noncog$meta_ci.lb , xend = cons_noncog$meta_ci.ub, y = 7.8, yend = 7.8, 
                                       colour = "black", size=0.9)

Big5meta9_y=Big5meta8_y+ annotate("point", x = cons_cog$meta_B, y = 6.8, colour = "gray65", size = 1.5)
Big5meta10_y=Big5meta9_y + annotate("segment",x = cons_cog$meta_ci.lb, xend =cons_cog$meta_ci.ub, y = 6.8, yend = 6.8, 
                                     colour = "gray65", size=0.9)

Big5meta11_y=Big5meta10_y + annotate("point", x = extra_noncog$meta_B, y = 5.8, colour = "black", size = 1.5)
Big5meta12_y=Big5meta11_y + annotate("segment",x = extra_noncog$meta_ci.lb, xend = extra_noncog$meta_ci.ub, y = 5.8, yend = 5.8, 
                                       colour = "black", size=0.9)

Big5meta13_y=Big5meta12_y+ annotate("point", x = extra_cog$meta_B, y = 4.8, colour = "gray65", size = 1.5)
Big5meta14_y=Big5meta13_y + annotate("segment",x = extra_cog$meta_ci.lb, xend =extra_cog$meta_ci.ub, y = 4.8, yend = 4.8, 
                                     colour = "gray65", size=0.9)

Big5meta15_y=Big5meta14_y + annotate("point", x =  agree_noncog$meta_B, y = 3.8, colour = "black", size = 1.5)
Big5meta16_y=Big5meta15_y + annotate("segment",x = agree_noncog$meta_ci.lb, xend = agree_noncog$meta_ci.ub, y = 3.8, yend = 3.8, 
                                       colour = "black", size=0.9)

Big5meta17_y=Big5meta16_y + annotate("point", x =  agree_cog$meta_B, y = 2.8, colour = "gray65", size = 1.5)
Big5meta18_y=Big5meta17_y + annotate("segment",x = agree_cog$meta_ci.lb, xend = agree_cog$meta_ci.ub, y = 2.8, yend = 2.8, 
                                     colour = "gray65", size=0.9)

Big5meta19_y=Big5meta18_y + annotate("point", x =  neu_noncog$meta_B, y = 1.8, colour = "black", size = 1.5)
Big5meta20_y=Big5meta19_y + annotate("segment",x = neu_noncog$meta_ci.lb, xend = neu_noncog$meta_ci.ub, y = 1.8, yend = 1.8, 
                                         colour = "black", size=0.9)

Big5meta21_y=Big5meta20_y + annotate("point", x =  neu_cog$meta_B, y = 0.8, colour = "gray65", size = 1.5)
Big5meta22_y=Big5meta21_y + annotate("segment",x = neu_cog$meta_ci.lb, xend = neu_cog$meta_ci.ub, y = 0.8, yend = 0.8, 
                                       colour = "gray65", size=0.9)

Big5meta22_y


##################################################
## Project: CogNonCog 2018
## Script purpose: Combine the Cog and NonCog results from stratified LDSC together and with the description of the annotations 
## Create a scatterplot plotting zscore or enrichment of Cog against NonCog 
## Date: November 2018
## Author: Perline Demange 
##################################################

library(data.table)
#install.packages("tidyr")
library(tidyr) # package for the fct separate
library(ggplot2)

### Set directory and load dataframes ###
#########################################

setwd("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/LDSC/23andMe")
Cog_annot <- fread("Cog_collected_results.txt")
Noncog_annot <- fread("Noncog_collected_results.txt")
description <- fread("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/LDSC/mouseatlas_col_attrs.txt") #file containing the Annotation names and the description of these 
View(description[1:100,])


### Merging the files ###
#########################

# In LDSC outputs, Separate the column Category (Cog.Annot) into GWAS (Cog and NonCog) and ClusterName (celltypes)
Cog_annot <- separate(data = Cog_annot, col = Category, into = c("GWAS", "ClusterName"))
Noncog_annot <- separate(data = Noncog_annot, col = Category, into = c("GWAS", "ClusterName"))

# Calculate one sided p value from the z score and correct it for multiple testing
Cog_annot$pval <- pnorm(-abs(Cog_annot$'Coefficient_z-score'))
Cog_annot$pval_cor_bonf <- p.adjust(Cog_annot$pval, method="bonferroni")
Cog_annot$pval_cor_fdr <- p.adjust(Cog_annot$pval, method='fdr')
Noncog_annot$pval <- pnorm(-abs(Noncog_annot$'Coefficient_z-score'))
Noncog_annot$pval_cor_bonf <- p.adjust(Noncog_annot$pval, method="bonferroni")
Noncog_annot$pval_cor_fdr <- p.adjust(Noncog_annot$pval, method='fdr')

# Merge the two results files so that cog and NonCog is in the name of the variable
total_annot <- merge(Cog_annot, Noncog_annot, by="ClusterName", suffixes = c(".Cog", ".Noncog"))

# Clean descriptive file to essential 
description <- as.data.frame(description)
myvars <- c("Class", "ClusterName", "Description", "NCells", "Region", "TaxonomyRank1", "TaxonomyRank2", "TaxonomyRank3", "TaxonomyRank4")
description <- description[myvars]
  
# Merge with the annotation descriptive file 
total_annot <- merge(total_annot, description, by="ClusterName")


# Save result file 
write.table(total_annot, "Results_LDSC_annotation_CogNonCog_23andMe.txt", sep=" ")
#write.csv(total_annot, "Results_LDSC_annotation_CogNonCog.csv")
total_annot <- read.table("Results_LDSC_annotation_CogNonCog_23andMe.txt")

### Create a simple scatterplot ###
###################################
# Scatterplot comparing Cog and NonCog z score by annotation  
cor(total_annot$`Coefficient_z.score.Cog`, total_annot$`Coefficient_z.score.Noncog`)
ggplot(total_annot, aes(x=`Coefficient_z.score.Cog`, y=`Coefficient_z.score.Noncog`, color = total_annot$Class)) + 
  geom_point(size=3) +
  scale_color_manual(values=c("#000000", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "#F0E442"))

# Scatterplot comparing Cog and NonCog enrichement by celltypes  
ggplot(total_annot, aes(x=`Enrichment.Cog`, y=`Enrichment.Noncog`, color = total_annot$Class)) + 
  geom_point(size=3) +
  scale_color_manual(values=c("#000000", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "#F0E442"))
cor(total_annot$Enrichment.Cog, total_annot$Enrichment.Noncog)


## Descriptive ###
##################
LDSC <- total_annot
hist(LDSC$pval.Cog)
hist(LDSC$pval_corrected.Cog)
hist(LDSC$pval_cor_fdr.Cog)

#################################################################
##  Description of gene set enriched Cog and Noncog
#################################################################
significant_cog <- LDSC[LDSC$pval.Cog<0.05,]
significant_noncog <- LDSC[LDSC$pval.Noncog<0.05,]
significant_cog_bonf <- LDSC[LDSC$pval_cor_bonf.Cog<0.05,]
significant_noncog_bonf <- LDSC[LDSC$pval_cor_bonf.Noncog<0.05,]
sign_cog_fdr <- LDSC[LDSC$pval_cor_fdr.Cog<0.05,]
sign_noncog_fdr <- LDSC[LDSC$pval_cor_fdr.Noncog<0.05,]

significant_cog_bonf$TaxonomyRank4
significant_noncog_bonf$TaxonomyRank4

# # With Enrichment 
# LDSC$Enrichment_p_cor.Cog <- p.adjust(LDSC$Enrichment_p.Cog, method='bonferroni')
# LDSC$Enrichment_p_cor.Noncog <- p.adjust(LDSC$Enrichment_p.Noncog, method='bonferroni') 
# significant_cog_enr <- LDSC[LDSC$Enrichment_p_cor.Cog<0.05,]
# significant_noncog_enr <- LDSC[LDSC$Enrichment_p_cor.Noncog<0.05,]

#### Compare the coefficients between Cog and NonCog #####
##########################################################
CTI= -0.6701  #Estimated with LDSC

LDSC$z_celltype <- (LDSC$Coefficient.Cog - LDSC$Coefficient.Noncog)/sqrt(((LDSC$Coefficient_std_error.Cog)^2)+((LDSC$Coefficient_std_error.Noncog)^2)-2*LDSC$Coefficient_std_error.Cog*LDSC$Coefficient_std_error.Noncog*CTI)
LDSC$P_celltype <- 2*pnorm(-abs(LDSC$z_celltype)) # two sided Pvalue
LDSC$P_celltype_fdr <- p.adjust(LDSC$P_celltype, method="fdr")
LDSC$P_celltype_bonf <- p.adjust(LDSC$P_celltype, method="bonferroni")

significant <- LDSC[LDSC$P_celltype<0.05,] 
significant_fdr <- LDSC[LDSC$P_celltype_fdr<0.05,]
significant_bonf <- LDSC[LDSC$P_celltype_bonf<0.05,] 


### Write results for paper ###
###############################
install.packages("writexl")
library(writexl)
write_xlsx(LDSC, "Results_LDSC_annotation_CogNonCog_23andMe.xlsx")

##################################
# Plot
####################################
LDSC <- as.data.frame(LDSC)

myvars <- c("ClusterName", "Coefficient_z.score.Cog", "Coefficient_z.score.Noncog", "Class", "TaxonomyRank3")
LDSC_fig <- LDSC[myvars]
LDSC_fig <- melt(LDSC_fig, id=c("ClusterName", "Class", "TaxonomyRank3"))
names(LDSC_fig) <- c("Celltype", "Class","TaxonomyRank3", "Trait", "zscore")
LDSC_fig$Trait <- as.character(LDSC_fig$Trait)
LDSC_fig$Trait[LDSC_fig$Trait == "Coefficient_z.score.Cog"] <- "Cog"
LDSC_fig$Trait[LDSC_fig$Trait == "Coefficient_z.score.Noncog"] <- "Noncog"
LDSC_fig$TaxonomyRank3_f <- factor(LDSC_fig$TaxonomyRank3, levels=c('Telencephalon projecting neurons','Cerebellum neurons',
                                                                      'Telencephalon interneurons','Hindbrain neurons', "Di- and mesencephalon neurons", "Astroependymal cells",
                                                                      "Enteric neurons", 'Spinal cord neurons', "Cholinergic, monoaminergic and peptidergic neurons", "Immature neural", 
                                                                      "Oligodendrocytes", "Immune cells", "Neural crest-like glia", "Sympathetic neurons", "Vascular cells", "Peripheral sensory neurons")) # create a factor to fix the order of the facets in the figure


myvars <- c("ClusterName", "pval_cor_fdr.Cog", "pval_cor_fdr.Noncog", "Class")
LDSC_fig_P <- LDSC[myvars]
LDSC_fig_P <- melt(LDSC_fig_P, id=c("ClusterName", "Class"))
names(LDSC_fig_P) <- c("Celltype", "Class", "Trait", "Pval_fdr")
LDSC_fig_P$Trait <- as.character(LDSC_fig_P$Trait)
LDSC_fig_P$Trait[LDSC_fig_P$Trait == "pval_cor_fdr.Cog"] <- "Cog"
LDSC_fig_P$Trait[LDSC_fig_P$Trait == "pval_cor_fdr.Noncog"] <- "Noncog"
#LDSC_fig_P$Method <- "LDSC"
head(LDSC_fig_P)

myvars <- c("ClusterName", "pval_cor_bonf.Cog", "pval_cor_bonf.Noncog", "Class")
LDSC_fig_Pbonf <- LDSC[myvars]
LDSC_fig_Pbonf <- melt(LDSC_fig_Pbonf, id=c("ClusterName", "Class"))
names(LDSC_fig_Pbonf) <- c("Celltype", "Class", "Trait", "Pval_bonferroni")
LDSC_fig_Pbonf$Trait <- as.character(LDSC_fig_Pnocor$Trait)
LDSC_fig_Pbonf$Trait[LDSC_fig_Pbonf$Trait == "pval_cor_bonf.Cog"] <- "Cog"
LDSC_fig_Pbonf$Trait[LDSC_fig_Pbonf$Trait == "pval_cor_bonf.Noncog"] <- "Noncog"
head(LDSC_fig_Pbonf)

LDSC_fig_tot <- merge(LDSC_fig, LDSC_fig_P, by= c('Celltype', "Trait", "Class"))
LDSC_fig_tot <- merge(LDSC_fig_tot, LDSC_fig_Pbonf, by= c('Celltype', "Trait", "Class"))
head(LDSC_fig_tot)

LDSC_fig_tot$fill <- ifelse(LDSC_fig_tot$Pval_bonferroni < 0.05, "Bonferroni significant", ifelse(LDSC_fig_tot$Pval_fdr < 0.05, "FDR significant", "NS")) 
LDSC_fig_tot$fill <- factor(LDSC_fig_tot$fill, levels=c('NS','FDR significant', 'Bonferroni significant'))
                                                                    

pdf("Annotations_LDSCtaxo_23andMe_sign.pdf",width=7,height=14)
ggplot(LDSC_fig_tot, aes(x=reorder(Celltype, zscore), y=zscore, fill=fill)) +
  geom_bar(stat='identity') +
  facet_grid(TaxonomyRank3_f~Trait, scales = "free_y", space = "free_y", switch="x") +
  theme(axis.title.y=element_blank(),
        axis.text=element_text(size=3),
        legend.title=element_blank(), 
        strip.text.y = element_text(angle=0), 
        legend.position = "none") +
  scale_fill_manual(values = c("#999999","#ffb31a", "#D55E00")) +
  #bbc_style() +
  #labs(title="Association of cognitive and nocgnitive skills with nervous system cell types",
  #     subtitle = "Cog and NonCog GWAS") + 
  coord_flip()
dev.off()






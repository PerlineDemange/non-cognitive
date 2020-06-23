##################################################
## Project: CogNonCog 2018
## Script purpose: Combine the Cog and NonCog results from MAGMA gene set analysis together and with the description of the annotations
##                 Save MAGMA results in one txt file 
##                 Create a scatterplot plotting Beta Cog against NonCog 
##                 Compare geneset enrichment between Cog and NonCog 
##                 Compare genes enrichment between Cog and NonCog 
##                 Create a plot with all genesets associations z-scores by Taxonomy 
## Date: January 2018
## Author: Perline Demange 
##################################################

library(data.table)
library(ggplot2)
setwd("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/MAGMA/23andMe")

#####################################
#### Preprocessing of the output ####
#####################################

# In the terminal, need to: 
# I removed the headers lines of the MAGMA output .gsa.out 
# For Cog
#  tail -n+5 gene_set_analysis.gsa.out > gene_set_analysis_Cog_23andMe.txt
# For NonCog
#  tail -n+5 gene_set_analysis.gsa.out > gene_set_analysis_Noncog_23andMe.txt

#########################
### Merging the files ###
#########################

Cog_geneset <- fread("gene_set_analysis_Cog_23andMe.txt")
head(Cog_geneset)
Noncog_geneset <- fread("gene_set_analysis_Noncog_23andMe.txt")
head(Noncog_geneset)

#file containing the Annotation names and the description of these 
description <- fread("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/LDSC/mouseatlas_col_attrs.txt") 

# Merge the two results files so that cog and NonCog is in the name of the variable
total_annot <- merge(Cog_geneset, Noncog_geneset, by="VARIABLE", suffixes = c(".Cog", ".Noncog"))

# Merge with the annotation descriptive file 
total_annot <- merge(total_annot, description, by.x="VARIABLE", by.y="ClusterName")
head(total_annot)

# Save result file 
write.table(total_annot, "Results_MAGMA_annotation_CogNonCog_23andMe.txt", sep=" ")
#total_annot <- read.table("Results_MAGMA_annotation_CogNonCog_23andMe.txt")

############################
### Add relevant columns ###
############################
MAGMA <- total_annot
MAGMA$P.Cog_adjusted <- p.adjust(MAGMA$P.Cog, method="fdr")
MAGMA$P.Noncog_adjusted <- p.adjust(MAGMA$P.Noncog, method="fdr")
MAGMA$P.Cog_adjusted.log <- -log10(MAGMA$P.Cog_adjusted)
MAGMA$P.Noncog_adjusted.log <- -log10(MAGMA$P.Noncog_adjusted)
MAGMA$z.Cog <- MAGMA$BETA.Cog/MAGMA$SE.Cog
MAGMA$z.Noncog <- MAGMA$BETA.Noncog/MAGMA$SE.Noncog

##########################
### Simple scatterplot ###
##########################

# Scatterplot comparing Cog and NonCog beta by annotation  
cor(total_annot$BETA.Cog, total_annot$BETA.Noncog)
ggplot(total_annot, aes(x=BETA.Cog, y=BETA.Noncog, color = total_annot$Class)) + 
  geom_point(size=3) +
  scale_color_manual(values=c("#000000", "#56B4E9", "#009E73", "#0072B2", "#D55E00", "#CC79A7", "#F0E442"))

MAGMA$Significance <- ifelse(MAGMA$P.Cog_adjusted< 0.05, ifelse(MAGMA$P.Noncog_adjusted < 0.05, "Both", "Cog"), ifelse(MAGMA$P.Noncog_adjusted < 0.05, "NonCog", "None"))

ggplot(MAGMA, aes(x=BETA.Cog, y=BETA.Noncog, color = Significance)) + 
  geom_point(size=3)

#################################################################
##  Description of gene set enriched Cog and Noncog
#################################################################
significant_cog<- MAGMA[MAGMA$P.Cog_adjusted<0.05,]
significant_noncog<- MAGMA[MAGMA$P.Noncog_adjusted<0.05,]
sign_noncog_and_cog <- significant_cog[which(significant_cog$VARIABLE %in% significant_noncog$VARIABLE),]
sign_cog_and_notnoncog <- significant_cog[!(significant_cog$VARIABLE %in% significant_noncog$VARIABLE),]
sign_noncog_and_notcog <- significant_noncog[!(significant_noncog$VARIABLE %in% significant_cog$VARIABLE),]
head(sign_noncog_and_notcog)
head(sign_cog_and_notnoncog)

sign_cog_and_notnoncog$TaxonomyRank4
sign_noncog_and_notcog$TaxonomyRank4

###################################################################
### Statistical comparison between Cog and NonCog               ###
### Based on Skene et al. 2018                                  ###
###+ Comments Michel to correct for non-indepedance of samples  
###  With 23andMe extended data 
###################################################################

####################
# Comparison between celltypes (gene sets)
#######################

### Following Skene et al. No-correction for non-independance of samples 
# create zscore for each cell type 
# MAGMA$z_celltype_skene <- (MAGMA$BETA.Cog - MAGMA$BETA.Noncog)/ sqrt(((MAGMA$SE.Cog)^2)+((MAGMA$SE.Noncog)^2))
# MAGMA$P_celltype_skene <- 2*pnorm(-abs(MAGMA$z_celltype_skene)) # two sided Pvalue
# significant_skene <- MAGMA[MAGMA$P_celltype_skene<0.05,]  

### Correcting for non-independance of GWAS samples
# Need to integrate the cross trait intersect to correct for non-indepedance of samples in the above formula
# Cross trait intersect is calculated from LDSC in LISA Annotations/Sumstats
# In output cross trait intercept is gcov_int (SE is gcov_int_SE)   CTI= -0.6701 SE=0.0083 

CTI= -0.6701

MAGMA$z_celltype <- (MAGMA$BETA.Cog - MAGMA$BETA.Noncog)/sqrt(((MAGMA$SE.Cog)^2)+((MAGMA$SE.Noncog)^2)-2*MAGMA$SE.Cog*MAGMA$SE.Noncog*CTI)
MAGMA$P_celltype <- 2*pnorm(-abs(MAGMA$z_celltype)) # two sided Pvalue

hist(MAGMA$z_celltype)
head(MAGMA$P_celltype)
significant <- MAGMA[MAGMA$P_celltype<0.05,] # nothing is significantly different, even with p-values non adjusted for multiple comparisons

##################################
# Comparison between genes 
##################################

### Get data 
datagenes_cog <- read.table("gene_analysis_allchr_cog.genes.txt", header=T)
datagenes_noncog <- read.table("gene_analysis_allchr_noncog.genes.txt", header=T)
datagenes <- merge(datagenes_cog, datagenes_noncog, by=c("GENE", "CHR", "START", "STOP", "NSNPS", "NPARAM"), suffixes=c(".Cog", ".Noncog")) 
head(datagenes)

# geneset to gene table, same genes can be in several genesets 
geneset <- read.table("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/MAGMA/geneset_top10expression.txt", fill=T, header=F, stringsAsFactors=F)
head(geneset)# only shows V because too many columns 


### Basic comparison
cor(datagenes$ZSTAT.Cog, datagenes$ZSTAT.Noncog)
cor(datagenes$P.Cog, datagenes$P.Noncog)
plot(datagenes$ZSTAT.Cog, datagenes$ZSTAT.Noncog)


### With above formula, adapted for the use of z-score (beta and se not available from MAGMA output)
# SE=1 and beta=zscore
datagenes$z_genes <- (datagenes$ZSTAT.Cog - datagenes$ZSTAT.Noncog)/sqrt(2-2*CTI)
datagenes$P_genes <- 2*pnorm(-abs(datagenes$z_genes)) # two sided Pvalue
significant_diff_genes <- datagenes[datagenes$P_genes<0.05,] 
genomewide_sig = 0.05/nrow(datagenes) # adjusting p value threshold for multiple testing
genomewide_sig_diff_genes <- datagenes[datagenes$P_genes<genomewide_sig,] 
head(genomewide_sig_diff_genes)

datagenes$P_genes_adjusted <- p.adjust(datagenes$P_genes, method="bonferroni")
bonf_adj <- datagenes[datagenes$P_genes_adjusted<0.05,] 
head(bonf_adj)

##################################
# Plot
####################################
MAGMA <- as.data.frame(MAGMA)

myvars <- c("VARIABLE", "z.Cog", "z.Noncog", "Class", "TaxonomyRank3")
MAGMA_fig <- MAGMA[myvars]
MAGMA_fig <- melt(MAGMA_fig, id=c("VARIABLE", "Class", "TaxonomyRank3"))
names(MAGMA_fig) <- c("Celltype", "Class","TaxonomyRank3", "Trait", "zscore")
MAGMA_fig$Trait <- as.character(MAGMA_fig$Trait)
MAGMA_fig$Trait[MAGMA_fig$Trait == "z.Cog"] <- "Cog"
MAGMA_fig$Trait[MAGMA_fig$Trait == "z.Noncog"] <- "Noncog"
MAGMA_fig$TaxonomyRank3_f <- factor(MAGMA_fig$TaxonomyRank3, 
                                    levels=c('Telencephalon projecting neurons','Cerebellum neurons',
                                              'Telencephalon interneurons','Hindbrain neurons', "Di- and mesencephalon neurons", "Astroependymal cells",
                                               "Enteric neurons", 'Spinal cord neurons', "Cholinergic, monoaminergic and peptidergic neurons", 
                                             "Immature neural", "Oligodendrocytes", "Immune cells", "Neural crest-like glia", 
                                             "Sympathetic neurons", "Vascular cells", "Peripheral sensory neurons")) # create a factor to fix the order of the facets in the figure


myvars <- c("VARIABLE", "P.Cog_adjusted_bonf", "P.Noncog_adjusted_bonf", "Class")
MAGMA_fig_P <- MAGMA[myvars]
MAGMA_fig_P <- melt(MAGMA_fig_P, id=c("VARIABLE", "Class"))
names(MAGMA_fig_P) <- c("Celltype", "Class", "Trait", "Pval_bonferroni")
MAGMA_fig_P$Trait <- as.character(MAGMA_fig_P$Trait)
MAGMA_fig_P$Trait[MAGMA_fig_P$Trait == "P.Cog_adjusted_bonf"] <- "Cog"
MAGMA_fig_P$Trait[MAGMA_fig_P$Trait == "P.Noncog_adjusted_bonf"] <- "Noncog"
head(MAGMA_fig_P)

myvars <- c("VARIABLE", "P.Cog_adjusted_fdr", "P.Noncog_adjusted_fdr", "Class")
MAGMA_fig_P_fdr <- MAGMA[myvars]
MAGMA_fig_P_fdr <- melt(MAGMA_fig_P_fdr, id=c("VARIABLE", "Class"))
names(MAGMA_fig_P_fdr) <- c("Celltype", "Class", "Trait", "Pval_fdr")
MAGMA_fig_P_fdr$Trait <- as.character(MAGMA_fig_P_fdr$Trait)
MAGMA_fig_P_fdr$Trait[MAGMA_fig_P_fdr$Trait == "P.Cog_adjusted_fdr"] <- "Cog"
MAGMA_fig_P_fdr$Trait[MAGMA_fig_P_fdr$Trait == "P.Noncog_adjusted_fdr"] <- "Noncog"
head(MAGMA_fig_P_fdr)

MAGMA_fig_tot <- merge(MAGMA_fig, MAGMA_fig_P, by= c('Celltype', "Trait", "Class"))
MAGMA_fig_tot <- merge(MAGMA_fig_tot, MAGMA_fig_P_fdr, by= c('Celltype', "Trait", "Class"))
head(MAGMA_fig_tot)

MAGMA_fig_tot$fill <- ifelse(MAGMA_fig_tot$Pval_bonferroni < 0.05, "Bonferroni significant", ifelse(MAGMA_fig_tot$Pval_fdr < 0.05, "FDR significant", "NS")) 
MAGMA_fig_tot$fill <- factor(MAGMA_fig_tot$fill, levels=c('NS','FDR significant', 'Bonferroni significant'))


MAGMA_fig_tot1 = MAGMA_fig_tot[MAGMA_fig_tot$TaxonomyRank3_f != "Telencephalon interneurons", ]
MAGMA_fig_tot2 = MAGMA_fig_tot1[MAGMA_fig_tot1$TaxonomyRank3_f != "Telencephalon projecting neurons", ]
MAGMA_fig_tot3 = MAGMA_fig_tot2[MAGMA_fig_tot2$TaxonomyRank3_f != "Cerebellum neurons", ]
MAGMA_fig_tot4 = MAGMA_fig_tot3[MAGMA_fig_tot3$TaxonomyRank3_f != "Di- and mesencephalon neurons", ]
MAGMA_fig_tot5 = MAGMA_fig_tot4[MAGMA_fig_tot4$TaxonomyRank3_f != "Hindbrain neurons", ]
MAGMA_fig_tot6 = MAGMA_fig_tot5[MAGMA_fig_tot5$TaxonomyRank3_f != "Astroependymal cells", ]
MAGMA_fig_tot7 = MAGMA_fig_tot6[MAGMA_fig_tot6$TaxonomyRank3_f != "Enteric neurons", ]


MAGMA_fig_tot1a = MAGMA_fig_tot7

levels(MAGMA_fig_tot1a$TaxonomyRank3_f)[levels(MAGMA_fig_tot1a$TaxonomyRank3_f)=="Cholinergic, monoaminergic and peptidergic neurons"] <- "Cholinergic, monoaminergic and \n peptidergic neurons"

#pdf("Annotations_magmataxo_23andMe_sign.pdf",width=7,height=14)
figS51 = ggplot(MAGMA_fig_tot1a, aes(x=reorder(Celltype, zscore), y=zscore, fill=fill)) +
  geom_bar(stat='identity') +
  facet_grid(TaxonomyRank3_f~Trait, scales = "free_y", space = "free_y", switch="x") +
  theme(axis.title.y=element_blank(),
        axis.text=element_text(size=7),
        legend.title=element_blank(), 
        strip.text.y = element_text(angle=0), 
        legend.position = "none") +
   scale_fill_manual(values = c("#999999","#ffb31a", "#D55E00")) +
  #bbc_style() +
  #labs(title="Association of cognitive and nocgnitive skills with nervous system cell types",
  #     subtitle = "Cog and NonCog GWAS") + 
  coord_flip()

MAGMA_fig_tot0 = MAGMA_fig_tot  [MAGMA_fig_tot$TaxonomyRank3_f != "Spinal cord neurons", ]
MAGMA_fig_tot1 = MAGMA_fig_tot0 [MAGMA_fig_tot0$TaxonomyRank3_f != "Cholinergic, monoaminergic and peptidergic neurons", ]
MAGMA_fig_tot2 = MAGMA_fig_tot1 [MAGMA_fig_tot1$TaxonomyRank3_f != "Immature neural", ]
MAGMA_fig_tot3 = MAGMA_fig_tot2 [MAGMA_fig_tot2$TaxonomyRank3_f != "Oligodendrocytes", ]
MAGMA_fig_tot4 = MAGMA_fig_tot3 [MAGMA_fig_tot3$TaxonomyRank3_f != "Immune cells", ]
MAGMA_fig_tot5 = MAGMA_fig_tot4 [MAGMA_fig_tot4$TaxonomyRank3_f != "Neural crest-like glia", ]
MAGMA_fig_tot6 = MAGMA_fig_tot5 [MAGMA_fig_tot5$TaxonomyRank3_f != "Sympathetic neurons", ]
MAGMA_fig_tot7 = MAGMA_fig_tot6 [MAGMA_fig_tot6$TaxonomyRank3_f != "Vascular cells", ]
MAGMA_fig_tot8 = MAGMA_fig_tot7 [MAGMA_fig_tot7$TaxonomyRank3_f != "Peripheral sensory neurons", ]

MAGMA_fig_tot2 = MAGMA_fig_tot8


figS52 = ggplot(MAGMA_fig_tot2, aes(x=reorder(Celltype, zscore), y=zscore, fill=fill)) +
  geom_bar(stat='identity') +
  facet_grid(TaxonomyRank3_f~Trait, scales = "free_y", space = "free_y", switch="x") +
  theme(axis.title.y=element_blank(),
        axis.text=element_text(size=7),
        legend.title=element_blank(), 
        strip.text.y = element_text(angle=0), 
        legend.position = "none") +
   scale_fill_manual(values = c("#999999","#ffb31a", "#D55E00")) +
  #bbc_style() +
  #labs(title="Association of cognitive and nocgnitive skills with nervous system cell types",
  #     subtitle = "Cog and NonCog GWAS") + 
  coord_flip()


library (gridExtra)
figs5 = grid.arrange (figS52, figS51, nrow = 1)
figs5
#ggsave(figs5, file="FigureS5_R1.png", width=14, height=13)
#ggsave(figs5, file="FigureS5_R1.pdf", width=15, height=15)



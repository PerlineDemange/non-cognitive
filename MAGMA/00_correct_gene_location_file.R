##################################################
## Project: CogNonCog 2018
## Script purpose: Correction of the genecode file which contains duplicated genes
## Date: January 2018
## Author: Perline Demange 
##################################################

library(data.table)
library(dplyr)
library(stringr)
setwd("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/MAGMA")


# Reference data for the gene location 
# Given by Hill Ip, adapted to only contain genes form https://www.gencodegenes.org/human/release_19.html
geneCode<-fread("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/Mouse annotations/Perline_mouse_specific_expression/gencode_v19_gene_only.csv",header=T,showProgress=F,data.table=F) #map of human genes, positions
head(geneCode)
geneloc <- geneCode


# investigate duplicated genes in geneloc 
dupl <- geneloc[duplicated(geneloc$gene_name),]$gene_name # list of all the duplicated gene names 
all_dupli <- geneloc[geneloc$gene_name%in%dupl,] #dataframe with all the duplicated genes 
all_dupli # 2342 genes 

# remove all duplicated genes 
geneloc_duplicated_excluded <- geneloc[!geneloc$gene_name%in%dupl,] # remove 2342 genes (on 57820 so total of 55478)


#change the chromosome column to get only the number of the chromosome 
geneloc_duplicated_excluded$Chromosome <- as.numeric(gsub("chr", "", geneloc_duplicated_excluded$Chromosome, fixed=T)) #chromosome is then identified as number and not chr1 # introduced NA for sexual chromsome and mitochondrial chromosome
tail(geneloc_duplicated_excluded)

# remove sexual and mitochondrial genes (will be excluded in next step anyway as not SNP location for these chromosomes)
geneloc_duplicated_excluded <- geneloc_duplicated_excluded[!is.na(geneloc_duplicated_excluded$Chromosome),] #remove 5110 genes sexual or mitochondrial chromsomes (total=52710)

# save data 
write.table(geneloc_duplicated_excluded, "Geneloc_duplicated_excluded.txt", quote=F, row.names=F)


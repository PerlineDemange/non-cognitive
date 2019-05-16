##################################################
## Project: CogNonCog 2018
## Script purpose: Create the gene sets for MAGMA bioannotation
#                  Data comes from mice so the genes names are changed to human names.
## Date: January 2018
## Author: Perline Demange, adapted from Hill Ip, helped by Matthijs van der Zee 
##################################################

library(data.table)
setwd("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/MAGMA")


# Reference correspondance mouse to human genes, adapted by Hill Ip from http://www.informatics.jax.org/downloads/reports/HOM_MouseHumanSequence.rpt
mouse.human.hom<-fread("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/Mouse annotations/Perline_mouse_specific_expression/HOM_MouseHumanSequence.gencode_v19.list",header=T,showProgress=F,data.table=F)

# Gene expression in our mouse data 
data_expression<-fread("C:/Users/PDE430/Documents/CogNonCog/Analyses/Annotations/Mouse annotations/Mouseatlas_specific_expression_L5.txt",header=T,showProgress=F,data.table=F)
head(data_expression)


## Create a file containing the top 10% specific genes in the area, with a format fitting MAGMA gene set analysis 
dat <- data_expression
set <- NULL
sink(paste0("geneset_top10expression.txt")) # print directly in text to be able to append vectors with different lengths
for (i in 2:ncol(dat)) { 
top10 <- unique(dat[dat[,i]>=quantile(dat[,i],prob=1-10/100),1])  
human_genes<-unique(mouse.human.hom[mouse.human.hom[,2]%in%top10,1]) # get the human ID from the corresponding mouse ID 
vector <- c(colnames(dat)[i], human_genes)
for (x in vector) {
  cat(x," ")
}
cat("\n")
}
sink()
#set <- cbind(set, data.frame(vector))
  }







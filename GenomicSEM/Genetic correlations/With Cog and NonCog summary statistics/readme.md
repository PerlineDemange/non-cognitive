# Genetic correlations estimation and comparison with GenomicSEM 


Genetic correlations between a trait, Cog, NonCog and EA were done with the help of Genomic SEM. Models tested the null hypothesis  that trait genetic correlations with Cog and NonCog could be constrained to be equal using a chi-squared test (see Methods). 

1) sumstats_fertility.csv is an example of the format of the file containing information wbout the summary statistics used in the following scripts 

2) Munging the summary statistics: This was done with the R script *Gene_cor_GenSEM_LISA_munge.R*, called with *rG_GenSEM_munge_traitcategory.sh* on the LISA cluster computer to run several traits at once. 

3) Estimate the genetic correlations (unconstrained model) and chi-square test.  With Cog and NonCog this was done with the script *Gene_cor_GenSEM_LISA_gencor.R* (calling *gencor_function.R*) used in the bash job *rG_GenSEM_gencor_traitcategory.sh*. With EA, this was done with script *Gene_cor_GenSEM_LISA_gencor_EA.R* (calling *gencor_EA_function.R*) used in the bash job *rG_GenSEM_gencor_EA_traitcategory.sh*.  

4) FDR correction of p-values and Figures: **ADD script** 

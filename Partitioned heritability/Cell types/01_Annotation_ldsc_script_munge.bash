##################################################
## Project: CogNonCog 2018 - Stratified LDSC 
## Script purpose: Munge the sumstats to be able to use with LDSC 
## Date: November 2018
## Author: Perline Demange 
##################################################
## LDSC requires its input (i.e. the GWA summary statistics) to have a specific format. This can be easily achieved using a python tool that was created by Bulik-Sullivan and is called "munging" the summary statistics:

## load python version 2.7.9 (other versions may give errors)
module load python/2.7.9

/home/vubiopsy/GWAS/resources/software/ldsc/munge_sumstats.py \
--out /home/pdemange/CogNonCog/Annotations/Sumstats/Cog_23andMe \
--snp SNP \
--a1 A1 \
--a2 A2 \
--p P \
--frq MAF \
--N 257700 \ 
--info INFO \
--ignore est,SE,error,cog_CPest,cog_CPSE,cog_EAest,cog_EASE,non_EAest,non_EASE,chisq \
--merge-alleles /home/vubiopsy/GWAS/resources/LDScores/w_hm3.snplist \
--sumstats /home/pdemange/CogNonCog/Annotations/MAGMA/Cognitive_GWAS_short_with23andMe.txt

/home/vubiopsy/GWAS/resources/software/ldsc/munge_sumstats.py \
--out /home/pdemange/CogNonCog/Annotations/Sumstats/NonCog_23andMe \
--snp SNP \
--a1 A1 \
--a2 A2 \
--p P \
--frq MAF \
--N 623530 \
--info INFO \
--merge-alleles /home/vubiopsy/GWAS/resources/LDScores/w_hm3.snplist \
--sumstats /home/pdemange/CogNonCog/Annotations/MAGMA/Non_Cognitive_GWAS_short_with23andMe.txt


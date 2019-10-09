# Genetic correlations estimation and comparison with GenomicSEM 


To adapt and complete: 

The final genetic correlations files with Genomic SEM are in the folder C:\Users\PDE430\Documents\CogNonCog\Analyses\Genetic_correlations\Final_allchr 
- Munging the summary statistics: This was done with the R script Gene_cor_GenSEM_LISA_munge.R and then the jobs in LISA called rG_GenSEM_munge_traitcategory.sh This was done with the munging function from genomic SEM. C.sumstats, NC.sumstats and EA.sumstats were done on the computer. Output in the LISA folder Genetic_Correlations/Output_munge 
- rG With Cog and NonCog: I used the script Gene_cor_GenSEM_LISA_gencor.R (call gencor_function.R). Used in the bash job rG_GenSEM_gencor_traitcategory.sh Output in LISA in Output_cor and on the computer in C:\Users\PDE430\Documents\CogNonCog\Analyses\Genetic_correlations\Final_allchr\Results_LISA 
- rG with EA: I used the function gencor_EA in the script Gene_cor_GenSEM_LISA_gencor_EA.R (call gencor_EA_function.R). Used in the bash job rG_GenSEM_gencor_EA_traitcategory.sh Output in LISA in Output_cor_EA and on the computer in C:\Users\PDE430\Documents\CogNonCog\Analyses\Genetic_correlations\Final_allchr\Results_LISA 
- Figures and script for figures in folder Final_allchr/Results_LISA From script Figure_per_cat.R and Figure_per_cat_EA.R Inspired by the script by Abdel

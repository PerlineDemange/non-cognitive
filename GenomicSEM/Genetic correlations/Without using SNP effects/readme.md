# Genetic correlations using Genomic SEM without SNP effects 

See detailed method and model in **Supplementary methods**. 

Analyses were run on the cluster computer LISA. 
- *rG_traits.bash* was used to run the script: 
- *run_rG_woSNP.R*: run the genomic SEM model. The summary statistics need to be previously munged (see Step 1 https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects) / Use the function:
- *function_rg_woSNP.R*: contains our specified model. Call the functions ldsc and usermodel from the genomicSEM package. 

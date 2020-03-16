# Decomposition of the correlation between EA and a tertiary trait 

See detailed method and model in **Supplementary methods**. 

Analyses were run on the cluster computer LISA. 
- `rG_mediation.bash` was used to run the following script. The input data format is the same as for the genetic correlations analysis using the Cog and NonCog GWAS. 
- `run_rg_mediation.R`: run the genomic SEM model. The summary statistics need to be previously munged (see Step 1 https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects)  Use the function:
- `function_rg_mediation.R`: contains our specified model. Call the functions ldsc and usermodel from the genomicSEM package. 

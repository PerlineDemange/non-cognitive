# Genetic correlations using Genomic SEM without SNP effects 

To insure that collider bias doesn’t introduce spurious SNPs effects in the NonCog and Cog GWAS, which in turn would bias our genetic correlation analysis, we run the genetic correlation analysis in genomic SEM, jointly estimating the Cog and NonCog latent factors and their correlation with a third trait using the model reported in Supplementary Figure 8. We find similar genetic correlations with all traits when using both methods to estimate rg. Therefore if collider bias does indeed introduce spuriously SNPs effects, this doesn’t seem to affect our genetic correlations.

Analyses were run on the cluster computer LISA. 
- *rG_traits.bash* (here rG_fertility.bash as an example) was used to run the following script. The input data is on the same format as the input data for the genetic correlations analysis using the Cog and NonCog GWAS. 
- *run_rG_woSNP.R*: run the genomic SEM model. The summary statistics need to be previously munged (see Step 1 https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects)  Use the function:
- *function_rg_woSNP.R*: contains our specified model. Call the functions ldsc and usermodel from the genomicSEM package. 

- *Supplementarytable_rg_woSNPs.csv*: results 

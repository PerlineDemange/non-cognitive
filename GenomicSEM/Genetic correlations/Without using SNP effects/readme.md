# Genetic correlations using Genomic SEM without SNP effects 

To insure that collider bias doesn’t introduce spurious SNPs effects in the NonCog and Cog GWAS, which in turn would bias our genetic correlation analysis, we run the genetic correlation analysis in genomic SEM, jointly estimating the Cog and NonCog latent factors and their correlation with a third trait using the model reported in Supplementary Figure 8. We find similar genetic correlations with all traits when using both methods to estimate rg. Therefore if collider bias does indeed introduce spuriously SNPs effects, this doesn’t seem to affect our genetic correlations.

Additionally, we use this genetic correlation method to run sensitivity analysis: we test changes in our rG results when fixing the covariance of Cog and NonCog to 0 (our original model), 0.1, 0.2, and 0.3.  

Analyses were run on the cluster computer LISA. 
For running the analysis with cov(Cog, NonCog) = 0 :  
- `rG_all_cov0.bash` was used to run the following scripts. The input data is on the same format as the input data for the genetic correlations analysis using the Cog and NonCog GWAS. 
- `run_rG_woSNP.R`: run the genomic SEM model. The summary statistics need to be previously munged (see Step 1 https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects)  Use the function:
- `function_rg_woSNP.R`: contains our specified model. Call the functions ldsc and usermodel from the genomicSEM package. 
- `sumstats_all_202000513.csv`: contains the list of traits to run this analysis on. 

The scripts `rG_all_cov01.bash`, `run_rG_woSNPcov01.R`, `function_rg_woSNPcov1.R` are the equivalent scripts to run the analysis with cov(Cog, NonCog) = 0.1 (similar scripts for cov = 0.2 and 0.3). 


`Figure_allcov.R`: Get p-values and create Supplementary Figure on rG(Cog, NonCog)


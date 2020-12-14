## Genetic correlations using Genomic SEM without SNP effects 

To insure that collider bias does not introduce spurious SNPs effects in the NonCog and Cog GWAS, which in turn would bias our genetic correlation analysis, we run the genetic correlation analysis in genomic SEM, jointly estimating the Cog and NonCog latent factors and their correlation with a third trait using the model reported in Supplementary Figure 8. We find similar genetic correlations with all traits when using both methods to estimate rg. Therefore if collider bias does indeed introduce spuriously SNPs effects, this does not seem to affect our genetic correlations.Analyses were run on the cluster computer LISA. 

**Scripts:**
For running the analysis with cov(Cog, NonCog) = 0:

- `rG_all_cov0.bash` was used to run the following scripts. The input data is on the same format as the input data for the genetic correlations analysis using the Cog and NonCog GWAS. 
- `run_rG_woSNP.R`: run the genomic SEM model. The summary statistics need to be previously munged (see Step 1 https://github.com/MichelNivard/GenomicSEM/wiki/3.-Models-without-Individual-SNP-effects)  Use the function:
- `function_rg_woSNP.R`: contains our specified model. Call the functions ldsc and usermodel from the genomicSEM package. 
- `sumstats_all_202000513.csv`: contains the list of traits to run this analysis on. 



## Sensitivity test for non-zero correlation of Cog and NonCog

Additionally, we use this genetic correlation method to run sensitivity analysis: we test changes in our rG results when fixing the covariance of Cog and NonCog to 0 (our original model), 0.1, 0.2, and 0.3. 

The scripts `rG_all_cov01.bash`, `run_rG_woSNPcov01.R`, `function_rg_woSNPcov1.R` are the equivalent scripts to run the analysis with cov(Cog, NonCog) = 0.1 (similar scripts for cov = 0.2 and 0.3). 

`Figure_allcov.R`: Get p-values and create *Supplementary Figures 5 and 6* 

## Sensitivity test for causal relation between CP and EA 
We use the above genetic correlation method to run correlations with a model where EA is causal of CP(*Supplementary Figure 7*) as a sensitivity analysis (our GWAS-by-subtraction assumes CP is causal of EA). 
The scripts `rG_all_CausalEACP.bash`, `run_rG_woSNP_causalEACP.R`, `function_rg_woSNP_causalEACP.R` are the equivalent scripts to run this genetic correlation analysis with this model.

`gencor_causalEACP_clean_fig.R`: Get p-values and create *Supplementary Figure 9*

Additionally, the script `script_reverse_cause.R` runs the Cog and NonCog GWAS for the genome-wide significant SNPs with model in *Supplementary Figure 7* and compares with z-statistics from model in *Figure 1* (creates *Supplementary Figure 8*)


## Probing potential biases due to cohort differences in SNP heritability 
We use the above genetic correlation method to run sensitivity analysis with a model where CP is divided into Cogent CP and UKB CP (*Supplementary Figure 2*): we test change in our rG results between the two models. 
The scripts `rG_all_CogentUKB.bash`, `run_rG_woSNP_CogentUKB.R`, `function_rg_woSNP_CogentUKB.R` are the equivalent scripts to run this genetic correlation analysis with this model.

`clean_gencor_cogentukb.R`:Get p-values and create *Supplementary Figure 4*

Additionally, `Model_Cogent_CP.R` and `script_sensitivity.R` run the Cog and NonCog GWAS for the genome-wide significant SNPs with model in *Supplementary Figure 2* and compare with z-tatistics from model in *Figure 1* (create *supplementary Figure 3*)


## Probing potential biases resulting from cohort differences in SNPs

The script `snponlyinukb.R` was used to analyse the overlap of SNPs in the different cohorts of CP, and to add the column OnlyinUKB in the summary statistics 
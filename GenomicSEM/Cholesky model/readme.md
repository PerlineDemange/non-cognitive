# Cholesky model in Genomic SEM (GWAS-by-subtraction) 

This model takes GWAS summary statistics for educational attainment and cognitive performance, and fits a model where the SNP effects on EA shared with cognitive ability (i.e. *Cog*) are estimated as well as the SNP effects on educational attainment not shared with cognitive ability (i.e. *NonCog*). The scripts are developed to run on the [LISA system](https://userinfo.surfsara.nl/systems/lisa), which probably mean you need to modify them to get them to run on your IT infrastructure. 

A [tutorial to run a GWAS-by-subtraction](https://rpubs.com/MichelNivard/565885) is also available.

For general info on running GenomicSEM see: https://github.com/MichelNivard/GenomicSEM/wiki 

`PrepLDSCoutput.R`: munge the summary statitics (Step 1), and run the multivariate LDSC to obtain the covariance matrices (Step 2)

`PrepareDataSumstats.R` done on cluster computer with `PrepSumstats.bash`: prepare the summary statistics for GWAS (Step 3)

`ModelwoSNP.R`: run the GWAS-by-subtraction model without SNP effects

`CogNonCog2.R`: run the GWAS-by-subtraction with SNP effects with GenomicSEM, done on cluster computer LISA with the following files (we split the analysis to make it manageable): 
- `CogNonCog1-2M.sh`
- `CogNonCog3-4M.sh`
- `CogNonCog5-6M.sh`
- `CogNonCog7-8M.sh`

`MergingandCleaning.R`: merge the results files and clean the summary statistics 

`HowtoPruneforLD`: identify independent hits, done in interactive mode on LISA

`Manhattan_plot_HillIp.R`: make the manhattan plot 

`Calculation_samplesize.R`: compute the effective sample size of the GWAS, following Mallard et al. 2019

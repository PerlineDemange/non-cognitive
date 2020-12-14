# Investigating the Genetic Architecture of Non-Cognitive Skills Using GWAS-by-Subtraction 

Code used to create the GWAS-by-subtraction of non-cognitive abilities, and for follow-up analyses. 

1. [Meta-analysis of the GWAS of EA from Lee et al. 2018 and from 23andMe](https://github.com/MichelNivard/non-cognitive/tree/master/Meta-analysis)
2. [GWAS-by-subtraction with Genomic SEM](https://github.com/MichelNivard/non-cognitive/tree/master/GenomicSEM/Cholesky%20model). A tutorial to run a GWAS-by-subtraction is also available [here](https://rpubs.com/MichelNivard/565885), for more recent GenomicSEM versions. Find the link to the summary statistics below. 
3. [Sensitivity analyses: Sensitivity test for non-zero correlation of Cog and NonCog, Sensitivity test for causal relation between CP and EA, Probing potential biases due to cohort differences in SNP heritability](https://github.com/PerlineDemange/non-cognitive/tree/master/GenomicSEM/Genetic%20correlations/Without%20using%20SNP%20effects)
4. Genetic correlations and decomposition of the correlation
    - [Genetic correlations](https://github.com/PerlineDemange/non-cognitive/tree/master/GenomicSEM/Genetic%20correlations/With%20Cog%20and%20NonCog%20summary%20statistics): Figure 4, Sup. Figure 11, Sup. Table 14
    - [Decomposition of the correlation](https://github.com/PerlineDemange/non-cognitive/tree/master/GenomicSEM/Genetic%20correlations/Decomposition%20of%20the%20correlation): using the model Sup. Fig. 17, Sup. Table 15, it estimates the percentage of the genetic covariance between educational attainment and the target traits that was explained by Cog and NonCog.
5. [Polygenic score analyses](https://github.com/MichelNivard/non-cognitive/tree/master/PRS): meta-analyses, Fig 3, Sup. Figures 10 & 12, Sup. Table 12
6. [Enrichment  of  tissue-specific  gene  expression](https://github.com/MichelNivard/non-cognitive/tree/master/Partitioned%20heritability/tissues): Sup. Table 16
7. Enrichment of cell-type specific expression with:
    - [MAGMA](https://github.com/MichelNivard/non-cognitive/tree/master/MAGMA): Sup. Figure 13 & 14, Sup. Table 18
    - [Stratified LDscore regression](https://github.com/MichelNivard/non-cognitive/tree/master/Partitioned%20heritability/Cell%20types): Sup. Figure 15, Sup. Table 17 & 19 
8. [Transcriptome-wide analysis](https://github.com/MichelNivard/non-cognitive/tree/master/TWAS): Sup. Figure 16, Sup. Table 20


Code was written with GenomicSEM_0.0.2. 

You can find the associated preprint [here](https://www.biorxiv.org/content/10.1101/2020.01.14.905794v1.abstract).

You can download the summary statistics of [NonCog](ftp://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90011874) and [Cog](ftp://ftp.ebi.ac.uk/pub/databases/gwas/summary_statistics/GCST90011875), excluding 23andMe data, on the GWAS catalog website. 
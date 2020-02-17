**TO ADAPT AND COMPLETE**  
Add ManhanttanPlot.r when final

# Cholesky model in Genomic SEM (GWAS-by-subtraction) 

This model takes GWAS summary statistics for educational attainment and cognitive performance, and fits a model where the SNP effects on EA shared with cognitive ability (i.e. cog) are estimated as well as the SNP effects on educational attainment not shared with cognitive ability (i.e. non-cog). The scripts are developed to run on the [LISA system](https://userinfo.surfsara.nl/systems/lisa), which may mean you need to modify them to get them to run on your IT infrastructure. 

A tutorial to run a GWAS-by-subtraction is also available [here](https://rpubs.com/MichelNivard/565885).


For general info on running GenomicSEM see: https://github.com/MichelNivard/GenomicSEM/wiki 

*PrepLDSCoutput.R*
- input: Sumstats/Lee_2018_GWAS_CP_all.txt, Sumstats/meta_education_lee_23andMe_adjust_rsid.txt
- output: LDSCoutputCogNonCog.RData

*PrepareDataSumstats.R* done on cluster computer with PrepSumstats.bash
- input: Sumstats/Lee_2018_GWAS_CP_all.txt, Sumstats/meta_education_lee_23andMe_adjust_rsid.txt
- output: Sumstats.RData

*ModelwoSNP.R*: run the model without SNP with GenomicSEM
- input: LDSCoutputCogNonCog.RData
- output: Modeloutput_with23andMe.Rdata

*CogNonCog2.R*: run our model with SNP effects with GenomicSEM, done on cluster computer LISA with the following files (we split the analysis to make it manageable): 
- CogNonCog1-2M.sh
- CogNonCog3-4M.sh
- CogNonCog5-6M.sh 
- CogNonCog7-8M.sh
- output: (LISA and computer)/output : cognitive*m.Rda and noncog*m.Rda 

*MergingandCleaning.R* 
- outputs are full GWAS: 
- Cognitive_GWAS_with23andMe.Rda, Cognitive_GWAS_with23andMe.txt, Cognitive_GWAS_short_with23andMe.txt
- Non_Cognitive_GWAS_with23andMe.Rda, Non_Cognitive_GWAS_with23andMe.txt, Non_Cognitive_GWAS_short_with23andMe.txt

*HowtoPruneforLD*: identify independent hits, done in interactive mode on LISA
- outputs: Cog_23andMe_sig_independent_signals.txt, NonCog_23andMe_sig_independent_signals.txt		

*Manhattanplot.R*
- output: Manhattanplot_with23andMe.png

GWAS Output: 
- Cog GWAS: Cognitive_GWAS(_short)_with23andMe.txt
- NonCog GWAS:  Non_Cognitive_GWAS(_short)_with23andMe.txt

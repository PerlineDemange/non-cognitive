**TO ADAPT AND COMPLETE**  

# Cholesky model in Genomic SEM 

This model takes GWASs summary statoistics for educational attainment and cognitive ability, and fits a modle whether the SNP effects on EA shared with cognitive ability (i.e. cog) are estiamted as well as the SNP effcts on educational attainment not attricdbutabel to cognitive ability (ik.e. non-cog). the scripts are develped to run on the [LISA system](https://userinfo.surfsara.nl/systems/lisa), which may mean you need to modify them to get them to run on your IT infrastructure. 


See https://github.com/MichelNivard/GenomicSEM/wiki 

*PrepLDSCoutput.R*
- input: Sumstats/Lee_2018_GWAS_CP_all.txt, Sumstats/meta_education_lee_23andMe_adjust_rsid.txt
- output: LDSCoutputCogNonCog.RData

*PrepareDataSumstats.R* done on cluster computer with PrepSumstats.bash
- input: Sumstats/Lee_2018_GWAS_CP_all.txt, Sumstats/meta_education_lee_23andMe_adjust_rsid.txt
- output: Sumstats.RData

*ModelwoSNP.R*: run the model without SNP 
- input: LDSCoutputCogNonCog.RData
- output: Modeloutput_with23andMe.Rdata

Run our model with GSEM: *CogNonCog2.R*, done on cluster computer LISA with the files
- CogNonCog1-2M.sh
- CogNonCog3-4M.sh
- CogNonCog5-6M.sh 
- CogNonCog7-8M.sh
- output: (LISA and computer)/output : cognitive*m.Rda and noncog*m.Rda 
(- a version was run to save the userGWAS output (without organizing in dataframe), using CogNonCog*M-par.sh, saving the output in (LISA)/output_par) 

*MergingandCleaning.R* 
- outputs are full GWAS: 
- Cognitive_GWAS_with23andMe.Rda, Cognitive_GWAS_with23andMe.txt, Cognitive_GWAS_short_with23andMe.txt
- Non_Cognitive_GWAS_with23andMe.Rda, Non_Cognitive_GWAS_with23andMe.txt, Non_Cognitive_GWAS_short_with23andMe.txt

*HowtoPruneforLD_new*, done in interactive mode on LISA
- outputs: Cog_23andMe_sig_independent_signals.txt, NonCog_23andMe_sig_independent_signals.txt		

*Manhattanplot.R*
- output: Manhattanplot_with23andMe.png

GWAS Output: 
- Cog GWAS: Cognitive_GWAS(_short)_with23andMe.txt
- NonCog GWAS:  Non_Cognitive_GWAS(_short)_with23andMe.txt
